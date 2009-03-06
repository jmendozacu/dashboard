<?php

class analytics extends DBRow {
	function createTable() {
		
		$cols = array(
			'id?',
			DBColumn::make('code', 'content', 'Content'),
			'timestamp'
			);
		return new DBTable("analytics", __CLASS__, $cols);
	}
	static function getAll() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getAllRows'), $args);
	}
	static function getCount() {
		$args = func_get_args();
		array_unshift($args, __CLASS__);
		return call_user_func_array(array('DBRow', 'getCountRows'), $args);
	}
	function quickformPrefix() {return 'analytics_';}

	static function getAllAnalyticss ($status = null) {
		if($status == 'active'){
			return self::getAll("where status=1", '');
		} else {
			return self::getAll();
		}
	}
}
DBRow::init('analytics');
