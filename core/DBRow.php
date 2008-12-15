<?
/* NOTE:  Class must be initialized by calling the static init() method. */

/*
 * TODO:
 * cache results of all loads
 * allow for default values for types
 */

/* DANGER: SPECIAL FUNCTIONS LIKE __serialize ARE INTERCEPTED BY __call. */
define ('DUMMY_INIT_ROW', -1);
include_once SITE_ROOT . '/modules/DBTable/include/TableColumn.php';

function underscore2uccamel($text) { // 'menu_item' => 'MenuItem'
	return implode (array_map ('ucfirst', explode ('_', $text)));
}

abstract class DBRow {
	protected static $tables = array();
	private $values = array();
	function createTable($table, $class, $customColumns = array()) {
		$cols = $customColumns;
		$columns = TableColumn::getAllRows($table);
		$done = array();
		foreach ($cols as $col) {
			$done[$col->name()] = true;
		}
		foreach ($columns as $col) {
			$name = $col->get('name');
			if (isset($done[$name])) {
				 error_log ("Warning: column $name is specified twice; check both in $class.php and in dbtable");
			} else {
				$cols[] = DBColumn::make ($col->get('type'), $name, $col->get('label'),
										  null, $col->get('modifier'));
				$done[$name] = true;
			}
		}
		$result = new DBTable($table, $class, $cols);
		return $result;
	}
	static function init($class) {
		if (!isset (self::$tables[$class])) {
			$dummy = new $class(DUMMY_INIT_ROW);
			self::$tables[$class] = $dummy->createTable();
		}
	}
	function values() {return $this->values; }
	function table() {return self::$tables[get_class($this)];}
	function column($name) {return $this->table()->column($name);} 
	function columns() {return $this->table()->columns();}
	function quickformPrefix() {return "";}
	function addElementTo($form, $id, $formValue) {
		switch ($id) {
		default: false;
		}
	}

	static function make($class, $id) {
		if ($id === null || $id === DUMMY_INIT_ROW) return new $class($id);
		$table = self::$tables[$class]; 
		$result = $table->getCache($id);
		if ($result) return $result;
		$result = new $class ($id);
		$table->setCache($id, $result);
		return $result;
	}
	
	function __construct($id = null) {
		if ($id === DUMMY_INIT_ROW) {return;}
		if (is_array ($id)) {
			$result = $id;
		} else if (is_null($id)) {
			$result = array();
		} else {
			$result = &$this->table()->fetchRow($id);
		}
		if ($result) {
			foreach ($result as $key => $value) {
				$column = @$this->column($key);
				if (!$column) {
					error_log ("Ignoring column ". $key);
					continue;
				}
				$this->set($key, $column->fromDB($value));
 			}
		}
		foreach ($this->columns() as $column) {
			$key = $column->name();
			if (!isset($this->values[$key])) $this->values[$key] = null; // TODO: SET TO DEFAULT VALUE
		}
	}
	
	function __call($name, $args) {
		$getset = $this->camel2getset ($name);
		switch ($getset[0]) {
			case 'get': return $this->get($getset[1]);
			case 'set': return $this->set($getset[1], $args[0]);
			default:
				$trace = debug_backtrace();
 				trigger_error(
					'Undefined property via __get(): ' . $name .
					' in ' . $trace[0]['file'] .
					' on line ' . $trace[0]['line'],
					E_USER_NOTICE);
				return null;
		}
	}
	function get($name) {
		$result = $this->values[$name];
		$column = @$this->column($name);
		if (is_null($result) && $column && $column->delayLoad() && $this->values['id']) {
			$result = $column->load($this->values['id']);
			$this->values[$name] = $result;
		}
		return $result;
	}
	function &set($name, $value) {
		if (isset($this->values[$name.'_id'])) { // Setting blah_id and blah
			$this->values[$name] = $value;
			$this->values[$name.'_id'] = $value->getId();
		} else if (substr($name, -3) === '_id') { // Setting blah_id and blah
			$column = $this->column ($name);
			$class = $column->type();
			$obj = new $class($value);
			$this->values[$name] = $value;
			$this->values[substr($name, 0, strlen($name)-3)] = $obj;
		} else {
			$this->values[$name] = $value;
		}
		return $this;
	}

	function &delete(&$notification = null) {
		if($notification != null){
			$obj = &$notification->getNotificationObject();
		} else {
			$obj = &$this;
		}
		if (!$obj->get('id')) return $this;
		fb(get_class($obj). ' pre-delete', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onPreDelete');
		if ($n->isNotificationCancelled()) {
			return $this;
		}
		
		$obj->table()->deleteRow($obj->get('id'));
		fb(get_class($obj). ' delete', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onDelete');

		return $this;
	}
	
	public function &toggle(&$notification = null) {
		if($notification != null){
			$obj = &$notification->getNotificationObject();
		} else {
			$obj = &$this;
		}
		fb(get_class($obj). ' pre-toggle', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onPreToggle');
		if ($n->isNotificationCancelled()) {
			return $this;
		}
		
		if ($obj->get('status') == 1) {
			$obj->set('status', 0)->save();
		} else {
			$obj->set('status', 1)->save();
		}
		fb(get_class($obj). ' toggle', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onToggle');
		
		return $this;
	}

	function &save(&$notification = null) {
		// This version creates the query on a per-call basis.
		// This is useful if some entries of an object to "update" haven't been loaded.
		// TODO:  Implement a version that caches the prepared statement in other cases.
		if($notification != null){
			$obj = &$notification->getNotificationObject();
		} else {
			$obj = &$this;
		}
		$update = false;
		$sql = "";
		$types = '';
		$params = array();
		/* Build up sql prepared statement and type string in parallel */
		foreach ($obj->columns() as $column) {
			$name = $column->name();
			$value = &$obj->values[$name];
			if ($value === null) continue;
			if ($column->ignored()) continue;
			if ($name == 'id' && $value) {
				$update = $value;
			} else {
				$params[] = &$column->toDB($value);
				$sql .= " `$name`=?,";
				$types .= $column->prepareCode();
			}
		}
		$sql = trim ($sql, ',');
		if (!$sql) {trigger_error ("NO DATA IN DBRow! Class was " . get_class($this) . ":", E_USER_NOTICE); return;} // Maybe wanted to just create an empty row?
		
		fb(get_class($obj). ' pre-save', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onPreSave');
		if ($n->isNotificationCancelled()) {
			return $this;
		}
		
		$table = $obj->table()->name();
		if ($update === false) {
			$sql = "insert into `$table` set" . $sql;
			$query = new Query ($sql, $types);
			$id = $query->insert($params);
			$obj->values['id'] = $id;
			return $id;
		} else {
			$sql = "update `$table` set" . $sql . " where id=?";
			$params[] = $update;
			$types .= 'i';
			$query = new Query ($sql, $types);
			$query->query($params);
		}
		fb(get_class($obj). ' save', 'Event Notification', FirePHP::INFO);
		$n = Event_Dispatcher::getInstance(get_class($obj))->post(&$obj, 'onSave');
		return $this;
	}

	function getAddEditFormHook($form) {}
	
	function getAddEditForm($target = null) {
		if (!$target){
			$target = '/admin/' . get_class($this);
		}
		$formName = get_class($this) . '_addedit';
		$els = array();
		
		$form = new Form($formName, 'post', $target);
		$form->setConstants (array ('action' => @$_REQUEST['action'], 'section' => @$_REQUEST['section']));
		$form->addElement ('hidden', 'action');
		$form->addElement ('hidden', 'section');

		foreach ($this->columns() as $column) {
			if ($column->noForm()) continue;
			$name = $column->name();
			$value = &$this->get($name);
			$id = $this->quickformPrefix() . $name;
			$formValue = $column->toForm($value);
			if ($column->hidden()) {
				$el = $form->addElement("hidden", $id);
				$el->setValue ($formValue);
			} else if ($this->addElementTo($form, $id, $formValue)) {
				// Do nothing				
			} else {
				$el = $column->addElementTo(array(
						'form' => $form,
						'id' => $id,
						'value' => $formValue));
			}
			if ($column->required()) {
				$form->addRule($id, "Please enter the " . $column->label(), 'required', null, 'client');
			}
			$els[$name] = $el;
		}
		$this->getAddEditFormHook($form);
		$form->addElement('submit', $this->quickformPrefix() . 'submit', 'Submit');
		if ($form->isSubmitted() && isset($_REQUEST[$this->quickformPrefix() . 'submit']) && $form->validate()) {
			foreach ($this->columns() as $column) {
				if ($column->noForm()) continue;
				$name = $column->name();
				$value = $form->exportValue($this->quickformPrefix() . $name);
				if ($column->type() == 'checkbox' || $column->type() == 'status') {
					$value = @$_REQUEST[$this->quickformPrefix() . $name] ? 1 : 0;
					$this->set($name, $value);
				} else {
					$this->set($name, $column->fromForm($value));
				}
				
			}
			$this->save();
			$form->setProcessed();
		}
		return $form;
	}
	private static function camel2getset($text) {
		// camel2getset('getThisVar') => array('get', this_var);
		$initial = substr ($text, 0, 3);
		switch ($initial) {
			case "get":
			case "set":
				$text = substr ($text, 3);
				$text = ucfirst(preg_replace('/([a-z])([A-Z])/', '\1 \2', $text));
				return array ($initial, implode ('_', array_map ('strtolower', explode (' ', $text))));
			default: return null;
		}
	}
}
