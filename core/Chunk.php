<?php
/**
 *  This file is part of Dashboard.
 *
 *  Dashboard is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Dashboard is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dashboard.  If not, see <http://www.gnu.org/licenses/>.
 *  
 *  @license http://www.gnu.org/licenses/gpl.txt
 *  @copyright Copyright 2007-2009 Norex Core Web Development
 *  @author See CREDITS file
 *
 */

  // Note that when a getter asks for the "draft", if no "draft" exists, we return the active version.

class Chunk extends DBRow {
	function createTable() {return parent::createTable("chunk", __CLASS__);}
	static function getAll() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getAllRows'), $args);
	}
	static function countAll() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getCountRows'), $args);
	}
	static function make($id = null) {return parent::make($id, __CLASS__);}

	static private $deleteQuery = null;
	static function deleteAllFor($obj) {
		if (!self::$deleteQuery) self::$deleteQuery = new Query ("delete from chunk_revision where parent=?", 'i');
		$chunks = self::getAllFor($obj);
		foreach ($chunks as $chunk) {
			self::$deleteQuery->query($chunk->getId());
			$chunk->delete();
		}
	}
	static function getAllFor($obj, $id = null) { // If $obj is a class name, $id is the object's id
		if ($id) {
			$class = $obj;
		} else {
			$class = get_class($obj);
			$id = $obj->getId();
		}
		return ($class && $id) ? self::getAll("where parent_class=? and parent=? order by sort", 'si', $class, $id) : array();
	}

	static function revertDrafts($class, $id) {
		foreach (self::getAllFor($class, $id) as $chunk) $chunk->revert();
	}
	function revert() {
		$draft = $this->getRevision('draft');
		if ($draft->getStatus() == 'draft') {
			$draft->setStatus('inactive');
			$draft->save();
		}
	}

	static function makeDraftActive($class, $id) {
		foreach (self::getAllFor($class, $id) as $chunk) $chunk->activate();
	}
	function activate() {
		$draft = $this->getRevision('draft');
		if ($draft->getStatus() == 'draft') {
			$active = $this->getRevision('active', false);
			if ($active && $active->getStatus() == 'active') {
				$active->setStatus('inactive');
				$active->save();
			}
			$draft->setStatus('active');
			$draft->save();
		}
	}
	
	private static $hasDraftFlag;
	static function hasDraft($obj) {
		self::getAllContentFor($obj, 'draft');
		return self::$hasDraftFlag;
	}

	static function getAllContentFor($obj, $status) {
		self::$hasDraftFlag = false;
		$chunks = Chunk::getAllFor($obj);
		foreach ($chunks as &$chunk) { // Converts Chunk -> rev -> content
			$type = $chunk->getType();
			$rev = $chunk->getRevision($status);
			if ($rev->getStatus() == 'draft') self::$hasDraftFlag = true;
			$chunk = DBRow::fromDB($type, $rev->getContent());
			if ($type == 'MenuType') {
				$chunk = Module::factory('Menu')->getUserInterface(array('id' => $chunk));
			}
		}
		return new ChunkList($chunks);
	}

	function getActualChunk() { // If this is a roled, named chunk returns the canonical version
		if (!($this->getName() && $this->getRole() && $this->getParent())) return $this;
		$name = e($this->getName());
		$role = $this->getRole();
		$c = self::getAll("where role=? and name=? and (parent is null or parent=0)", 'ss', $role, $name);
		if (!$c) { // Create the canonical Chunk with this (role, name) pair.
			$c = Chunk::make();
			$c->setRole($role);
			$c->setName($this->getName());
			$c->setType($this->getType());
			$c->save();
			return $c;
		} else {
			return $c[0];
		}
	}
	
	function getRevision ($statusORcount, $create = true, $follow = true, $version = 'single') {
		// This code not only gets the current revision, but also creates one if needed.
		$c = $follow ? $this->getActualChunk() : $this;
		$id = $c->getId();
		$count = (integer) $statusORcount;
		switch ($statusORcount) {
		case 'active': $statusClause = "status='$statusORcount'"; break;
		case 'draft': $statusClause = "(status='draft' OR status='active') ORDER BY status DESC limit 1"; break;
		default:
			if (!$count) trigger_error ("Invalid status in getRevision: $statusORcount");
			$statusClause = "count=$count";
			$draft = ChunkRevision::getAll("where status='draft'", '');
			if ($draft) { // RESET PREVIOUS draft TO inactive
				$draft = $draft[0];
				$draft->setStatus('inactive');
				$draft->save();
			}
		}
		$all = ChunkRevision::getAll("where parent=? and version=? AND $statusClause", 'is', $id,$version);
		if ($all) {
			$rev= $all[0];
		} else {
			if (!$create) return null;
			$rev = ChunkRevision::make();
			$rev->setParent($id);
			$rev->setCount(0);
		}
		if ($rev->getStatus() == 'inactive') {
			$rev->setStatus('draft');
			$rev->save();
		}
		return $rev;
	}

	function getRawContent($status, $follow = true,$version='single') {return $this->getRevision($status, true, $follow,$version)->getContent();}
	function getCount($status, $follow = true) {return $this->getRevision($status, true, $follow)->getCount();}
	function getContent($status, $follow = true,$version='single') {return DBRow::fromDB($this->getType(), $this->getRawContent($status, $follow,$version));}

	static $countQuery = null;
	function countRevisions($follow = true) { // $follow means use canonical chunk of appropriate
		if (!self::$countQuery) self::$countQuery = new Query ("select count(*) as count from chunk_revision where parent=?", 'i');
		$c = $follow ? $this->getActualChunk() : $this;
		$id = $c->getId();
		$sql = "d";
		$result = self::$countQuery->fetch($c->getId());
		return $result['count'];
	}

	static function loadChunk() { // Load the chunk from $_REQUEST and update draft
		// CHUNKS: Response to AJAX request only.
		if(!empty($_REQUEST['role']))$role = e($_REQUEST['role']);
		else $role = '';
		if(!empty($_REQUEST['name']))$name = e($_REQUEST['name']);
		else $name = '';
		if(!empty($_REQUEST['section']))$parent_class = e($_REQUEST['section']);
		else $parent_class = '';
		if(!empty($_REQUEST['id']))$parent = e($_REQUEST['id']);
		else $parent = '';
		if(!empty($_REQUEST['sort']))$sort = e($_REQUEST['sort']);
		else $sort = '';
		if(!empty($_REQUEST['i']))$count = e($_REQUEST['i']);
		else $count = '';
		
		$status = $count ? $count : 'draft';
		if ($role && $name) $result = ChunkRevision::getNamedChunkFormField($role, $name, $status);
		else if ($parent_class && $parent) $result = ChunkRevision::getChunkFormField ($parent_class, $parent, $sort, $status);
		else trigger_error ('Bad AJAX request for loadChunk');
		return json_encode ($result);
	}
}

class ChunkList { // Just so that the template doesn't need to pass in an iterating index
	private $list, $ptr=0;
	function __construct($list) {$this->list = $list;}
	function get($ignored_string=null) {return $this->list[$this->ptr++];}
}

DBRow::init('Chunk');
