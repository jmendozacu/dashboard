<?php

class User extends DBRow {
	function createTable() {
		self::$__CLASS__ = __CLASS__;
		$cols = array(
			'id?',
			DBColumn::make('!text', 'username', 'Username'),
			DBColumn::make('password', 'password', 'Password'),
			DBColumn::make('//text', 'salt', 'Salt'),
			DBColumn::make('select', 'group', 'Group', Group::toArray()),
			DBColumn::make('timestamp', 'timestamp', 'Timestamp'),
			DBColumn::make('text', 'name', 'First Name'),
			DBColumn::make('text', 'last_name', 'Last Name'),
			DBColumn::make('!email', 'email', 'Email'),
			DBColumn::make('status', 'status', 'Status'),
			);
		return new DBTable("auth", __CLASS__, $cols);
	}
	static function make($id = null) {return parent::make($id, __CLASS__);}

	function quickformPrefix() {return 'user_';}
	
	public function hasPerm($class, $key) {
		$p = Permission::hasPerm($this->getGroup(), $class, $key);
		return $p;
	}

	private $oldPassword;
// David's version
	public function getAddEditFormBeforeSaveHook($form) {
		if ($this->getPassword() && $this->getPassword() != $this->oldPassword) {
			$salt = uniqid('norexcms', true);
			$this->set('salt', $salt);
			$this->setPassword(md5($this->get('password') . md5($salt)));
		} else $this->setPassword($this->oldPassword);
	}

	public function getAddEditForm($target = null) {
		$this->oldPassword = $this->get('password');
		return parent::getAddEditForm($target);
	}

/* Chris's version
	private $oldSalt;
	public function getAddEditFormSaveHook($form) {
		if (isset($_REQUEST[$this->quickformPrefix() . 'password']) && $_REQUEST[$this->quickformPrefix() . 'password'] != '') {
			$salt = uniqid('norexcms', true);
			$this->set('salt', $salt);
			$this->setPassword(md5($this->get('password') . md5($salt)));
		} else {
			$this->set('password', $this->oldPassword);
			$this->set('salt', $this->oldSalt);
		}
	}

	public function getAddEditForm($target = null) {
		$this->oldPassword = $this->get('password');
		$this->oldSalt = $this->get('salt');
		
		$form = parent::getAddEditForm($target);
		$p = $form->getElement($this->quickformPrefix() . 'password');
		$p->setValue('');
		return $form;
	}
	
*/

	public function toArray() {
		$array = array();
		foreach (self::getAll() as $s) {
			$array[$s->getId()] = $s->getName() . ' ' . $s->getLastName() . ' (' . $s->getUsername() . ')';
		}
		return $array;
	}
}
DBRow::init('User');

?>