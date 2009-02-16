<?php
/*
NOTE:  modules/Content/chunk.sql has the chunk tables and the dbtable.  LOAD AFTER buildtools/sql/dbtable.sql
   
DATA MODEL:  A chunk which has both a name and role is linked to a canonical parentless chunk.  This is the chunk that represents the actual content.  Example:

+----+---------+------+-------+--------------+--------+------+
| id | type    | role | name  | parent_class | parent | sort |
+----+---------+------+-------+--------------+--------+------+
| 28 | text    | NULL | NULL  | ContentPage  |      2 |    0 | 
| 29 | tinymce | col  | test1 | ContentPage  |      2 |    1 | 
| 30 | tinymce | col  | NULL  | ContentPage  |      2 |    2 | 
| 32 | tinymce | col  | test1 | NULL         |   NULL | NULL | 
| 33 | tinymce | col  | test1 | ContentPage  |      8 |    1 | 

Chunks 28 and 30 are chunks which display the (active) revision (from chunk_revision table) with parent 28 and 30, respectively.
Chunks 29 and 33, however, are named chunks with role/name of col/test1.  The role/name points to the parentless chunk 32.  So
So the relevant revisions are those with parent 32!  However, there may be orphaned revisions pointing to 29 and 33 which would
be un-orphaned if the user were to unname these chunks.

DONE:
	Template is parsed, and chunks are filled in.  Chunks can specify a type, a role, and a preview code
	Admin interface presents correct fields, though no "name" select and edit
	Form fields are populated
	Add select to select those "named" which have a matching role.
	Can select a new text name if the the field has a role
	Nixed PageContentRevision
	When naming a chunk, make a parentless canonical version.  That's the one that gets updated.
	Update the associated text field on change to existing name
	Draft model implemented
	Small buttons to tranverse revision history
TODO:
    I removed the checkForHomeName in Content.php; rewrite as needed.
	Check for name collisions for new names
	AJAX calls to auto-save tinymce chunks --- keyclick starts timer; auto-save happens 1 minute later?
    Once working, do a grep 'CHUNK' to find methods which need to be promoted to Module, DBRow, Page classes
  */
class ChunkManager {
	private $fields = array(); // Fields are of type DBColumn
	private $roles = array();
	private $previews = array();
	private $chunks = array();
	private $object = null;

	function __construct($obj) {$this->object = $obj;}
	
	function insertFormFields($form) {
		$this->chunks = Chunk::getAllFor($this->object);
		$i=-1;
		foreach ($this->fields as $field) {
			$i++;
			$label = $field->label();
			$chunk = @$this->chunks[$i];
			if ($role = $this->roles[$i]) {
				$form->addElement('html', "\n<div id=_select_text_$i>");
				$el = array();
				$el[] = $s = $form->createElement('select', "select", "", self::getSelection($role));
				if ($chunk && $chunk->getRole() && $chunk->getName()) {
					$s->setValue($chunk->getName());
					$chunk = $chunk->getActualChunk();
				}
				$el[] = $form->createElement('text', "text", ""); // THESE FIELDS ARE HIDDEN AND/OR HANDLED BY chunks.js
				$el[] = $form->createElement('image', 'prev', "/images/admin/arrow_left.gif", array('onclick' => 'return false', 'id'=>"_chunk_prev_".$i));
				$el[] = $form->createElement('image', 'next', "/images/admin/arrow_right.gif", array('onclick' => 'return false', 'id'=>"_chunk_next_".$i));
				$form->addGroup($el, "_chunk_name_$i", $label, '&nbsp;&nbsp;&nbsp;');
				$form->addElement('html', "\n</div>");
				$class = get_class($this->object);
				$parent = $this->object->getId();
				$total = $chunk ? $chunk->countRevisions() : 0;
				$count = $chunk ? $chunk->getCount('draft') : 0;
				$form->addElement('html', "\n<script type='text/javascript'>watchChunkSelect($i, '$role', '$class', $parent, $total, $count);</script>\n");
				$field->setLabel(""); // Inspect the add edit form, add an appropriate class, use JavaScript to watch for change and update content
			}
			$el = $field->addElementTo(array ('form' => $form, 'id' => "_chunk_$i"));
			$field->setLabel($label);
			if ($chunk && ($chunk->getId() || $chunk->getContent('draft'))) {
				$el->setValue(DBRow::toForm($chunk->getType(), $chunk->getContent('draft')));
			} else {
				$el->setValue($this->previews[$i]);
			}
		}
		return ++$i; // Returns the number of form fields which were added
	}

	private $form;
	private function getName ($i, &$isNew) { // TODO: make second arg optional
		$isNew = false;
		if ($this->roles[$i]) {
			$pair = $this->form->exportValue("_chunk_name_$i");
			$isNew = $pair['select'] == '__new__';
			return $isNew ? $pair['text'] : $pair['select'];
		}
		else return '';
	}

	private function newChunk ($i, $canonical) {
		$field = $this->fields[$i];
		$chunk = Chunk::make();
		$chunk->setType ($field->type());
		$chunk->setLabel($field->label());
		$chunk->setRole($this->roles[$i]);
		if (!$canonical) {
			$chunk->setParentClass(get_class($this->object));
			$chunk->setParent($this->object->getId());
		}
		return $chunk;
	}

	private function createChunkIfNeeded ($i) {
		$chunk = @$this->chunks[$i];
		/* Canonical Chunk will be created by Chunk->getRevision() if needed */
		if (!$chunk) {
			$chunk = $this->newChunk($i, false);
			$this->chunks[$i] = $chunk;
		}
		$name = $this->getName($i, $new);
		$chunk->setName ($name);
		$chunk->setSort($i);
		$chunk->save();
	}
	
	function saveFormFields($form) {
		$this->form = $form;
		$i=-1;
		foreach ($this->fields as $field) {
			$i++;
			$this->createChunkIfNeeded ($i);
			$type = $field->type();
			$value = $form->exportValue("_chunk_$i");
			$chunk = $this->chunks[$i];
			$revs = $chunk->countRevisions();
			$old_rev = $chunk->getRevision('draft');
			if ((0 == $revs) && (0 == $old_rev->getCount())) { // Entirely new revision
				$rev = $old_rev;
				$rev->setCount(1);
				$rev->setContent(DBRow::toDB($field->type(), $value));
				$rev->setStatus('active');
				$rev->save();
			} else if (DBRow::toDB($type, $value) != $chunk->getRawContent('draft')) { // New revision of old content
				$rev = ChunkRevision::make();
				$rev->setCount(1+$revs);
				$rev->setParent($old_rev->getParent());
				$rev->setStatus('draft');
				// Need to reset the old status unless we're making a draft and the old one was active
				if ($old_rev && $old_rev->getStatus() == 'draft') {
					$old_rev->setStatus('inactive');
					$old_rev->save();
				}
				$rev->setContent(DBRow::toDB($field->type(), $value));
				$rev->save();
			} // else no change was made to the revision so do nothing.
		}
	}

	private static $previewCodes
		= array ("h1" => "<h1>Title</h1>",
				 "h2" => "<h2>Major Heading</h2>",
				 "h3" => "<h3>Heading</h3>",
				 "h4" => "<h4>Heading</h4>",
				 "h5" => "<h5>Heading</h5>",
				 "ul" => "<ul>\n<li>Item 1</li>\n<li>Item 2</li></ul>",
				 "jpg" => "/images/foo.jpg",
				 "p" => "<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc ligula nisl, egestas non, pharetra vel, scelerisque accumsan, lacus. Proin nibh. Aenean dapibus</p>");
	
	function convertPreview($preview) {
		if (!trim($preview)) return "";
		$list = array_map ("trim", split(",", $preview));
		foreach ($list as &$x) {
			$preview = self::$previewCodes[$x];
			if (!$preview) {trigger_error ("Preview code '$x' not recognized in ChunkManager.php");}
			$x = $preview;
		}
		return implode("\n",$list);
	}
	
	function setTemplate($template) {
		if (!$template) return array();
		if (is_object ($template)) $template = $template->getData();
		$titlechars = '[^"\']';
		$argchars = '[^"\']';
		if (!preg_match_all('/{\$chunks->get\("([^":]*):([^"]*)"\)}/',
							$template,
							$matches,
							PREG_SET_ORDER)) return array();
		foreach ($matches as $req) {
			$label = $req[1];
			$args = explode(';', trim($req[2]));
			$role = null;
			$type = null;
			$preview = "";
			foreach ($args as $arg) {
				$pair = explode('=', trim($arg));
				$var = $pair[0];
				if (in_array ($var, array ("type", "role", "preview")))
					$$var = $pair[1];
				else trigger_error ("Variable $var not recognized in ChunkManager::setTemplate()");
			}
			$this->fields[] = DBColumn::make($type, '', $label);
			$this->roles[] = $role;
			$this->previews[] = $this->convertPreview($preview);
		}
	}

	static private $selectQuery = null;
	static private function getSelection($role) {
		if (!self::$selectQuery) {
			self::$selectQuery = new Query('select name from chunk where role=? and !isnull(role) and !isnull(name) group by name order by name', 's');
		}
		$result = self::$selectQuery->fetchAll($role);
		$names = array();
		foreach ($result as $val) $names[$val['name']] = $val['name'];
		return array_merge (array(''=>'', '__new__'=>'Create Name for Reuse:'), $names);
	}

	static function fieldAdminRequest() {
		switch (@$_REQUEST['action']) { // CHUNKS
		case 'chunk_revertdrafts':
			Chunk::revertDrafts($_REQUEST['section'], $_REQUEST['id']);
			break;
		case 'chunk_makeactive':
			Chunk::makeDraftActive($_REQUEST['section'], $_REQUEST['id']);
			break;
		case 'chunk_load':  // Response to AJAX request only.
			echo Chunk::loadChunk();
			die();
		default: // Fall through
		}
	}
}