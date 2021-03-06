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

class Module_Analytics extends Module {
	
	public $icon = '/modules/Analytics/images/google.png';
	
	public function __construct() {
		$this->page = new Page();
		$this->page->with('Analytics')
			 ->show(array(
					'Code' => 'content',
					'Last Updated' => 'timestamp',
			 		'Status' => 'status'
			 ))
			 ->Pre('<div>
			 <p>To view Analytics for your site, visit <a href="http://google.com/analytics" target="new">The Google Analytics </a> page. </p>
			 <h4>Initial Setup:</h4>
			 <ul>
			 	<li> Sign Up for a Google Account, if you don`t have one already | <a href="http://google.com/" target="new">here.</a>
			 	<li> Step 1 - General Information | <a href="http://img.skitch.com/20090323-kkpygktagf5jauuk2sx187yke3.jpg" rel="facebox">pic</a> </li>
			 	<li> Step 2 - Agree to the Terms of Service </li>
			 	<li> Step 3 - Copy the google tracking code  | <a href="http://img.skitch.com/20090323-eexf4ypd139tu5p41eyki6h79m.png" rel="facebox">pic</a></li>
			 	<li> Step 4 - Create the object in the CMS | <a href="http://img.skitch.com/20090323-r6pie5bmx59bjy4g6pn7k1j9r5.png" rel="facebox">pic</a></li>
			 	<li> Step 5 - Paste the code and save | <a href=http://img.skitch.com/20090323-r3375fj2iruh1ineja468rp9yj.png" rel="facebox">pic</a></li>
			 	<li> Step 6 - Profit. </li>
			 </ul>
			 </div>')
			 ->Post('<p>At any time, you can edit the code and it will update site-wide.</p>')
			 ->name('Analytics Script')
			 ->showCreate(false);
			 
		$this->page->with('Analytics'); 
	}

	function getAdminInterface() {
		return $this->page->render();
	}
	
	function getUserInterface($params) {
		include_once ('include/Analytics.php');
		$s = Analytics::getAllAnalyticss('active');
		
		$this->smarty->assign('scripts', $s);
		return $this->smarty->fetch('analy.tpl');
	}
	
	function topLevelAdmin() {
		$s = Analytics::getAllAnalyticss();
		$this->smarty->assign('scripts', $s);
		
		return $this->smarty->fetch( 'admin/adminanaly.tpl' );
	}

}
