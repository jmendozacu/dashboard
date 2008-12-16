<?php

require_once 'core/DBColumns.php';

require_once 'core/PEAR/PHPUnit/Framework/TestCase.php';

/**
 * DBColumnText test case.
 */
class DBColumnTest extends PHPUnit_Framework_TestCase {

	/**
	 * @var DBColumnText
	 */
	private $DBColumnText;

	/**
	 * Prepares the environment before running a test.
	 */
	protected function setUp() {
		parent::setUp ();
		$this->DBColumn = DBColumn::make('text','Test', 'TEST');
	
	}

	/**
	 * Cleans up the environment after running a test.
	 */
	protected function tearDown() {
		$this->DBColumnText = null;
		parent::tearDown ();
	}

	/**
	 * Tests DBColumnText->addElementTo()
	 */
	public function testAddElementTo() {
		$form = new Form();
		$this->assertEquals(count($form->_elements), 0);
		$this->DBColumn->addElementTo(array('form' => &$form, 'id' => 'testfield'));
		$this->assertNotEquals(count($form->_elements), 0);
		$this->assertType('HTML_QuickForm_text', $form->_elements[0]);
	}

	/**
	 * Tests DBColumnText->type()
	 */
	public function testType() {
		$this->assertEquals($this->DBColumn->type(), 'text');
	}
	
	public function testOptions() {
		$this->assertEquals(count($this->DBColumn->options()), 1);
	}

}