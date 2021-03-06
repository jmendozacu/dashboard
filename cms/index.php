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

/**
 * Require the site initialization file
 */

require_once (dirname(__FILE__) . "/../include/Site.php");
$auth_container = new CMSAuthContainer();
$auth = new Auth($auth_container, null, 'authHTML');
$auth->start();

SiteConfig::warnInstall();

if ($auth->checkAuth()) {
	if (!isset($_SESSION['authenticated_user']) || !$_SESSION['authenticated_user']->hasPerm('CMS', 'view')) {
		/* We need a way to for the programmer to see the admin interface anyway
		 * so she can switch emulation to another group.
		 */
		if (SiteConfig::programmer(true))
			$smarty->assign('programmerSneakingIn', true);
		else User::logout();
	}
	/* Aggressively clear cache just in case this admin request changes static web pages.
	 * 
	 */
	$pageCache->clean();
	
	// set templates dir to the admin templates location
	$smarty->template_dir = SITE_ROOT . '/cms/templates';
	// set a custom compile id to ensure Smarty doesent accidentally overwrite duplicate compiled files.
	$smarty->compile_id = 'admin';
	
	$smarty->addCSS('/css/screen.css', 'screen');
	$smarty->addCSS('/css/print.css', 'print');
	$smarty->addCSS('/css/liquid.css', 'screen');
	$smarty->addCSS('/css/admin_styles.css', 'screen');
	$smarty->addCSS('/css/admin_print.css', 'print');
	$smarty->addCSS('/css/facebox.css', 'screen');
	$smarty->addJS('/js/prototype.js');
	$smarty->addJS('/js/scriptaculous.js');
	$smarty->addJS('/js/facebox.js');
	$smarty->addJS('/js/help.js');
	$smarty->addJS('/js/admin.js');
	
	// This is currently a hack since my url-rewriting syntax keeps a trailing slash on the module name
	if(!empty($_GET['module']))$requestedModule = trim($_GET['module'], '/');
	else $requestedModule = '';

	// assign the requested module
	$smarty->assign('module', $requestedModule);
	$smarty->assign('programmer', SiteConfig::programmer());
	
	$config = Config::singleton();
	foreach($config->getActiveModules() as $m) {
		$name = $m['module'];
		
		if ($name != $requestedModule) {
			$m = Module::factory($name);
		}
	}

	// render the admin page
	require_once 'HTML/AJAX/Helper.php';
	$ajaxHelper = new HTML_AJAX_Helper ( );
	
	if ( $ajaxHelper->isAJAX () ){
		echo Module::factory($requestedModule, $smarty)->getAdminInterface();
		die();
	} else {
		$smarty->assign ('emulating', SiteConfig::emulating());
		if (!isset($_REQUEST['module'])) {
			$requestedModule = 'Dashboard';
			$smarty->assign ( 'module', $requestedModule );
			$smarty->assign ( 'module_title', "Dashboard");
		} else {
			$smarty->content[$requestedModule] = Module::factory($requestedModule, $smarty)->getAdminInterface();
			$smarty->assign ( 'module', $requestedModule );
			
			$sql = 'select display_name from modules where module="' . e($requestedModule) . '"';
			$r = Database::singleton()->query_fetch($sql);
			$smarty->assign ( 'module_title', $r['display_name'] );
		}
		
		$smarty->template_dir = SITE_ROOT . '/cms/templates';
		$smarty->compile_id = 'admin';
		$smarty->render('admin.tpl');
	}
}

?>
