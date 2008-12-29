-- MySQL dump 10.11
--
-- Host: localhost    Database: trunk
-- ------------------------------------------------------
-- Server version	5.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `street_address` varchar(128) NOT NULL default '',
  `city` varchar(64) NOT NULL default '',
  `postal_code` varchar(16) default NULL,
  `state` int(11) default NULL,
  `country` int(11) default NULL,
  `geocode` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2444 DEFAULT CHARSET=latin1 COMMENT='Generic Address Table';

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
CREATE TABLE `analytics` (
  `id` int(11) NOT NULL auto_increment,
  `content` text,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `analytics`
--

LOCK TABLES `analytics` WRITE;
/*!40000 ALTER TABLE `analytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth`
--

DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `username` varchar(32) NOT NULL default '',
  `password` varchar(32) NOT NULL default '',
  `salt` varchar(32) NOT NULL default '',
  `group` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `last_name` varchar(255) default NULL,
  `email` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auth`
--

LOCK TABLES `auth` WRITE;
/*!40000 ALTER TABLE `auth` DISABLE KEYS */;
INSERT INTO `auth` VALUES (1,'norex','0188127235a7cf49b79a46f31d77b135','norexcms49340bf2c7fff6.82647904',1,'2008-07-20 21:56:56','Norex','Development','bugs@norex.ca',1),(22,'admin','f93077a467ac40a77e4f89d8e6010e1c','norexcms495801d5e2aeb0.87084163',1,'2008-12-28 22:41:04','Norex','Administrator','wolfe@norex.ca',1);
/*!40000 ALTER TABLE `auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_groups`
--

DROP TABLE IF EXISTS `auth_groups`;
CREATE TABLE `auth_groups` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_groups`
--

LOCK TABLES `auth_groups` WRITE;
/*!40000 ALTER TABLE `auth_groups` DISABLE KEYS */;
INSERT INTO `auth_groups` VALUES (1,'Administrator');
/*!40000 ALTER TABLE `auth_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
CREATE TABLE `blocks` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `status` tinyint(1) NOT NULL default '1',
  `sort` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_options`
--

DROP TABLE IF EXISTS `config_options`;
CREATE TABLE `config_options` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `module` varchar(100) default NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `type` varchar(1000) default 'string',
  `value` varchar(10000) default '',
  `sort` int(11) NOT NULL default '10',
  `editable` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `name` USING HASH (`name`,`module`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `config_options`
--

LOCK TABLES `config_options` WRITE;
/*!40000 ALTER TABLE `config_options` DISABLE KEYS */;
INSERT INTO `config_options` VALUES (1,'Content','defaultPageTitle','Default Page Title','string','Edit Page Title Using Site Config',0,'1'),(2,'Blog','frontPage','Blogs to show on Front Page (list of user ids)','list','1',10,'1'),(3,'Blog','feedTitle','Title of RSS Feed','string','Green Party of Nova Scotia',10,'1'),(4,'Calendar','frontPage','Calendar ID to show as main calendar','string','1',10,'0'),(5,NULL,'linkables','Linkable modules','list','Content',0,'0'),(6,'Content','defaultPage','Sets default page fallback','string','Home',0,'0'),(9,NULL,'CMSname','Appears in admin titlebar','string','Norex Core Web Development',0,'0'),(10,'Content','restrictedPages','Are some pages restricted to certain users?','enum(true,false)','false',0,'0'),(11,'Menu','minimumNumber','Minimum number of menus','int','1',0,'0'),(12,'Menu','maximumNumber','Maximum number of menus','int','3',0,'0'),(13,'Menu','numberWithSubmenus','Number of main menus which have submenus','int','1',0,'0'),(14,'Menu','templates','Templates which are selectable by the Client','list','menu_rendertop',0,'0'),(15,NULL,'modules','Active modules in display order','list','Content, Menu, User, Block, Analytics',0,'0');
/*!40000 ALTER TABLE `config_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_page_data`
--

DROP TABLE IF EXISTS `content_page_data`;
CREATE TABLE `content_page_data` (
  `id` int(11) NOT NULL auto_increment,
  `parent` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `locale_id` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL default '0',
  `page_title` text NOT NULL,
  `meta_title` varchar(64) NOT NULL,
  `meta_description` text NOT NULL,
  `meta_keywords` varchar(128) NOT NULL,
  `page_template` varchar(128) default 'site.tpl',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `content_page_data`
--

LOCK TABLES `content_page_data` WRITE;
/*!40000 ALTER TABLE `content_page_data` DISABLE KEYS */;
INSERT INTO `content_page_data` VALUES (8,2,'<p>Etiam quis felis dictum sem commodo sagittis. Curabitur vel nisi eget ante tincidunt condimentum. Cras sit amet quam a ante malesuada pulvinar. Curabitur adipiscing pede sed tellus. Aliquam ullamcorper magna sit amet libero. Donec suscipit ipsum nec pede. Quisque placerat lorem sed nibh. Sed quam mauris, pellentesque ac, pulvinar ut, pellentesque sed, neque. Sed vel ligula a ante venenatis dignissim. Ut in sapien. Morbi convallis orci vitae tellus.</p>\r\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed aliquam nisi non lectus. Praesent dapibus magna pretium magna. Fusce et dolor nec purus volutpat malesuada. Nullam eu nisi a velit feugiat egestas. Nulla id lectus. Mauris auctor tortor ut mi. Sed quam. Nunc dui elit, sagittis et, iaculis vel, pellentesque vel, augue. Mauris gravida. Curabitur in arcu.</p>\r\n<p>Curabitur bibendum velit eu diam. Vivamus viverra libero a elit. Nullam tempor. Proin diam. Donec vitae dui nec est placerat hendrerit. Duis at magna sit amet diam sollicitudin malesuada. In hac habitasse platea dictumst. Sed pulvinar. Etiam turpis eros, hendrerit non, faucibus non, euismod et, velit. Nulla aliquet sodales lectus. Nam sit amet nibh eu mi rhoncus luctus. Cras sodales lacinia neque. Sed congue est eu metus. Nunc ante urna, fermentum sit amet, mollis et, posuere vitae, pede.</p>',0,'2008-11-21 21:47:21',0,'This is a test page','','','','site_no_blogs.tpl'),(6,1,'<p>Lorem ipsum <strong>dolor</strong> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risus i<a href=\\\"/file/13\\\">n quam iaculis e</a>uismod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br /> <br /> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br /> <br /> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-21 20:23:12',0,'The Green Party of Nova Scotia','','','','site_no_blogs.tpl'),(7,1,'<p>Lorem ipsum <strong>dolor</strong> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risus i<a href=\\\"/file/13\\\">n quam iaculis e</a>uismod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br /> <br /> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br /> <br /> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-21 20:46:10',0,'The Green Party of Nova Scotia','','','','site.tpl'),(9,1,'<p>Lorem ipsum <b>dolor</b> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risusmod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br> <br> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br> <br> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-24 19:46:42',0,'The Green Party of Nova Scotia','','','','site.tpl'),(12,1,'<p><strong>Lorem</strong> ipsum <strong>dolor</strong> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risusmod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\r\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\r\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\r\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br /> <br /> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br /> <br /> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-25 16:33:03',0,'The Green Party of Nova Scotia','','','','site.tpl'),(10,2,'<p>Etiam quis felis dictum sem commodo sagittis. Curabitur vel nisi eget ante tincidunt condimentum. Cras sit amet quam a ante malesuada pulvinar. Curabitur adipiscing pede sed tellus. Aliquam ullamcorper magna sit amet libero. Donec suscipit ipsum nec pede. Quisque placerat lorem sed nibh. Sed quam mauris, pellentesque ac, pulvinar ut, pellentesque sed, neque. Sed vel ligula a ante venenatis dignissim. Ut in sapien. Morbi convallis orci vitae tellus.</p>\r\n<p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed aliquam nisi non lectus. Praesent dapibus magna pretium magna. Fusce et dolor nec purus volutpat malesuada. Nullam eu nisi a velit feugiat egestas. Nulla id lectus. Mauris auctor tortor ut mi. Sed quam. Nunc dui elit, sagittis et, iaculis vel, pellentesque vel, augue. Mauris gravida. Curabitur in arcu.</p>\r\n<p>Curabitur bibendum velit eu diam. Vivamus viverra libero a elit. Nullam tempor. Proin diam. Donec vitae dui nec est placerat hendrerit. Duis at magna sit amet diam sollicitudin malesuada. In hac habitasse platea dictumst. Sed pulvinar. Etiam turpis eros, hendrerit non, faucibus non, euismod et, velit. Nulla aliquet sodales lectus. Nam sit amet nibh eu mi rhoncus luctus. Cras sodales lacinia neque. Sed congue est eu metus. Nunc ante urna, fermentum sit amet, mollis et, posuere vitae, pede.</p>',0,'2008-11-25 13:19:25',1,'This is a test page','','','','site_no_blogs.tpl'),(11,1,'<p>Lorem ipsum <strong>dolor</strong> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risusmod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\r\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\r\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\r\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br /> <br /> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br /> <br /> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-25 13:42:55',0,'The Green Party of Nova Scotia','','','','site.tpl'),(13,1,'<p><strong>Lorem</strong> ipsum <strong>dolor</strong> sit amet, consectetuer adipiscing elit. Mauris ultricies. Vivamus vel ante. Mauris ut leo. Curabitur ac risusmod. Praesent at felis. Phasellus in quam. Quisque laoreet leo venenatis erat tempor adipiscing. Cras dolor. Aenean ligula turpis, viverra eget, aliquet blandit, sodales sit amet, ligula. Maecenas bibendum euismod tortor. Phasellus aliquet augue in enim. Morbi id mi. Sed lacus. Vivamus consequat.</p>\r\n<p>Nullam aliquam dolor vitae odio. Donec vulputate varius turpis. Sed mollis consectetuer erat. Nulla non quam. Duis ac lorem. Aenean eu nisi id nisl suscipit pellentesque. Aenean aliquam elit eget nulla. Nunc porttitor ultricies velit. Nam sed massa. Mauris sit amet nisl. Aenean justo eros, laoreet id, sollicitudin vel, aliquam in, tortor. Praesent ornare. Nam imperdiet luctus tortor. Donec lobortis. Ut sodales, metus eu cursus egestas, nunc lacus vulputate lorem, non lacinia elit sem bibendum nulla. Curabitur dolor urna, eleifend semper, dictum eget, pulvinar vitae, nisi. Morbi lacinia.</p>\r\n<p>Praesent pharetra, urna non egestas ultricies, tellus ligula consectetuer nisl, eu adipiscing eros ante nec enim. Mauris ut metus vitae tellus blandit malesuada. Praesent hendrerit dui. Quisque tristique magna in urna. Phasellus tellus purus, euismod sed, porttitor eget, tempor et, purus. Quisque sed orci. Etiam nec ligula sit amet risus vulputate ultrices. Fusce a orci. Sed libero nisi, iaculis nec, mattis vel, malesuada vel, arcu. Sed et ante sit amet velit ultrices pulvinar. Quisque eget magna ut ligula fringilla consectetuer. Vestibulum lectus.</p>\r\n<p>In nibh elit, tristique sed, semper vitae, eleifend sit amet, leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec tortor. Fusce tortor metus, pretium sit amet, ornare imperdiet, vestibulum sit amet, erat. Nam dui. Suspendisse at felis vitae lectus congue hendrerit. Donec dictum neque in tortor eleifend placerat. Integer volutpat eros vitae felis. Integer porta pede sed libero. Nullam velit augue, consequat vel, vestibulum quis, egestas feugiat, erat. Phasellus quis mauris. Sed tincidunt imperdiet ipsum. Morbi aliquam, augue sed viverra mollis, quam neque vehicula pede, nec luctus enim magna at sem. Curabitur pharetra ante eleifend velit. Etiam eu est.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In eu mauris! Curabitur fermentum, lectus nec aliquet vehicula, mauris quam accumsan sapien, in sollicitudin erat mi sit amet purus. Phasellus pretium neque sollicitudin tellus. Sed in est. Morbi ac sem. Quisque ornare iaculis sapien. Donec eleifend aliquet nisl. Fusce dapibus ipsum nec metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas malesuada nibh id turpis. Aliquam erat volutpat. Etiam aliquet volutpat justo. Etiam at tortor.<br /> <br /> Donec a est. Nulla vitae mi. Fusce vehicula turpis eget mauris sodales pellentesque? Donec tempor! Aliquam malesuada urna sit amet purus. Duis quis purus ut est sollicitudin semper. Maecenas erat nisi, luctus sit amet, rutrum ac, malesuada ac; arcu? Donec at lacus. Duis ac eros vitae pede adipiscing placerat? Sed id nunc. Fusce justo eros, vehicula ac; elementum non, tristique eu, ligula. Etiam non sem quis neque placerat molestie. Mauris commodo purus eget pede.<br /> <br /> Aliquam ornare orci ut nulla. Integer in mauris. Vivamus erat. Pellentesque in eros. Curabitur eleifend metus et felis. Maecenas varius ante non enim. Aenean mollis ipsum id nisi. In iaculis. Nulla quis pede? In nisi? Praesent gravida, quam eu tincidunt lacinia, pede lacus scelerisque justo; et rutrum dolor eros id lorem. Quisque blandit rutrum mi. In hac habitasse platea dictumst. Donec eleifend pede quis nisi. Nam lectus ante, dapibus eget; molestie sit amet, pulvinar vitae, diam. Quisque nec leo et sapien sodales sollicitudin. Maecenas et mauris et erat viverra adipiscing. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam varius rutrum eros.</p>',0,'2008-11-26 14:51:27',1,'The Green Party of Nova Scotia','','','','site.tpl');
/*!40000 ALTER TABLE `content_page_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_pages`
--

DROP TABLE IF EXISTS `content_pages`;
CREATE TABLE `content_pages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL default '',
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL,
  `access` varchar(64) NOT NULL default 'public',
  `url_key` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `page_name` (`name`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `content_pages`
--

LOCK TABLES `content_pages` WRITE;
/*!40000 ALTER TABLE `content_pages` DISABLE KEYS */;
INSERT INTO `content_pages` VALUES (1,'Home','2007-12-15 23:23:33',1,'public','home'),(2,'Test Page','2008-11-21 21:47:14',1,'public','test_page');
/*!40000 ALTER TABLE `content_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_rel`
--

DROP TABLE IF EXISTS `content_rel`;
CREATE TABLE `content_rel` (
  `revision_id` int(11) NOT NULL,
  `child_type` enum('block','menu') default 'block',
  `child_id` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `module` varchar(100) default 'Content',
  KEY `revision_id` (`revision_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `content_rel`
--

LOCK TABLES `content_rel` WRITE;
/*!40000 ALTER TABLE `content_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `content_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL default '0',
  `codetwo` char(2) NOT NULL default '',
  `codethree` char(3) NOT NULL default '',
  `name` varchar(100) NOT NULL default '',
  `currency` varchar(5) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AF','AFG','Afghanistan','AFN'),(2,'AL','ALB','Albania','ALL'),(3,'DZ','DZA','Algeria','DZD'),(4,'AD','AND','Andorra','EUR'),(5,'AO','AGO','Angola','AOA'),(6,'AG','ATG','Antigua and Barbuda','XCD'),(7,'AR','ARG','Argentina','ARS'),(8,'AM','ARM','Armenia','AMD'),(9,'AU','AUS','Australia','AUD'),(10,'AT','AUT','Austria','EUR'),(11,'AZ','AZE','Azerbaijan','AZM'),(12,'BS','BHS','Bahamas, The','BSD'),(13,'BH','BHR','Bahrain','BHD'),(14,'BD','BGD','Bangladesh','BDT'),(15,'BB','BRB','Barbados','BBD'),(16,'BY','BLR','Belarus','BYR'),(17,'BE','BEL','Belgium','EUR'),(18,'BZ','BLZ','Belize','BZD'),(19,'BJ','BEN','Benin','XOF'),(20,'BT','BTN','Bhutan','BTN'),(21,'BO','BOL','Bolivia','BOB'),(22,'BA','BIH','Bosnia and Herzegovina','BAM'),(23,'BW','BWA','Botswana','BWP'),(24,'BR','BRA','Brazil','BRL'),(25,'BN','BRN','Brunei','BND'),(26,'BG','BGR','Bulgaria','BGN'),(27,'BF','BFA','Burkina Faso','XOF'),(28,'BI','BDI','Burundi','BIF'),(29,'KH','KHM','Cambodia','KHR'),(30,'CM','CMR','Cameroon','XAF'),(31,'CA','CAN','Canada','CAD'),(32,'CV','CPV','Cape Verde','CVE'),(33,'CF','CAF','Central African Republic','XAF'),(34,'TD','TCD','Chad','XAF'),(35,'CL','CHL','Chile','CLP'),(36,'CN','CHN','China, People\'s Republic of','CNY'),(37,'CO','COL','Colombia','COP'),(38,'KM','COM','Comoros','KMF'),(39,'CD','COD','Congo, Democratic Republic of the (Congo / Kinshasa)','CDF'),(40,'CG','COG','Congo, Republic of the (Congo / Brazzaville)','XAF'),(41,'CR','CRI','Costa Rica','CRC'),(42,'CI','CIV','Cote d\'Ivoire (Ivory Coast)','XOF'),(43,'HR','HRV','Croatia','HRK'),(44,'CU','CUB','Cuba','CUP'),(45,'CY','CYP','Cyprus','CYP'),(46,'CZ','CZE','Czech Republic','CZK'),(47,'DK','DNK','Denmark','DKK'),(48,'DJ','DJI','Djibouti','DJF'),(49,'DM','DMA','Dominica','XCD'),(50,'DO','DOM','Dominican Republic','DOP'),(51,'EC','ECU','Ecuador','USD'),(52,'EG','EGY','Egypt','EGP'),(53,'SV','SLV','El Salvador','USD'),(54,'GQ','GNQ','Equatorial Guinea','XAF'),(55,'ER','ERI','Eritrea','ERN'),(56,'EE','EST','Estonia','EEK'),(57,'ET','ETH','Ethiopia','ETB'),(58,'FJ','FJI','Fiji','FJD'),(59,'FI','FIN','Finland','EUR'),(60,'FR','FRA','France','EUR'),(61,'GA','GAB','Gabon','XAF'),(62,'GM','GMB','Gambia, The','GMD'),(63,'GE','GEO','Georgia','GEL'),(64,'DE','DEU','Germany','EUR'),(65,'GH','GHA','Ghana','GHC'),(66,'GR','GRC','Greece','EUR'),(67,'GD','GRD','Grenada','XCD'),(68,'GT','GTM','Guatemala','GTQ'),(69,'GN','GIN','Guinea','GNF'),(70,'GW','GNB','Guinea-Bissau','XOF'),(71,'GY','GUY','Guyana','GYD'),(72,'HT','HTI','Haiti','HTG'),(73,'HN','HND','Honduras','HNL'),(74,'HU','HUN','Hungary','HUF'),(75,'IS','ISL','Iceland','ISK'),(76,'IN','IND','India','INR'),(77,'ID','IDN','Indonesia','IDR'),(78,'IR','IRN','Iran','IRR'),(79,'IQ','IRQ','Iraq','IQD'),(80,'IE','IRL','Ireland','EUR'),(81,'IL','ISR','Israel','ILS'),(82,'IT','ITA','Italy','EUR'),(83,'JM','JAM','Jamaica','JMD'),(84,'JP','JPN','Japan','JPY'),(85,'JO','JOR','Jordan','JOD'),(86,'KZ','KAZ','Kazakhstan','KZT'),(87,'KE','KEN','Kenya','KES'),(88,'KI','KIR','Kiribati','AUD'),(89,'KP','PRK','Korea, Democratic People\'s Republic of (North Korea)','KPW'),(90,'KR','KOR','Korea, Republic of  (South Korea)','KRW'),(91,'KW','KWT','Kuwait','KWD'),(92,'KG','KGZ','Kyrgyzstan','KGS'),(93,'LA','LAO','Laos','LAK'),(94,'LV','LVA','Latvia','LVL'),(95,'LB','LBN','Lebanon','LBP'),(96,'LS','LSO','Lesotho','LSL'),(97,'LR','LBR','Liberia','LRD'),(98,'LY','LBY','Libya','LYD'),(99,'LI','LIE','Liechtenstein','CHF'),(100,'LT','LTU','Lithuania','LTL'),(101,'LU','LUX','Luxembourg','EUR'),(102,'MK','MKD','Macedonia','MKD'),(103,'MG','MDG','Madagascar','MGA'),(104,'MW','MWI','Malawi','MWK'),(105,'MY','MYS','Malaysia','MYR'),(106,'MV','MDV','Maldives','MVR'),(107,'ML','MLI','Mali','XOF'),(108,'MT','MLT','Malta','MTL'),(109,'MH','MHL','Marshall Islands','USD'),(110,'MR','MRT','Mauritania','MRO'),(111,'MU','MUS','Mauritius','MUR'),(112,'MX','MEX','Mexico','MXN'),(113,'FM','FSM','Micronesia','USD'),(114,'MD','MDA','Moldova','MDL'),(115,'MC','MCO','Monaco','EUR'),(116,'MN','MNG','Mongolia','MNT'),(117,'CS','SCG','Montenegro','EUR'),(118,'MA','MAR','Morocco','MAD'),(119,'MZ','MOZ','Mozambique','MZM'),(120,'MM','MMR','Myanmar (Burma)','MMK'),(121,'NA','NAM','Namibia','NAD'),(122,'NR','NRU','Nauru','AUD'),(123,'NP','NPL','Nepal','NPR'),(124,'NL','NLD','Netherlands','EUR'),(125,'NZ','NZL','New Zealand','NZD'),(126,'NI','NIC','Nicaragua','NIO'),(127,'NE','NER','Niger','XOF'),(128,'NG','NGA','Nigeria','NGN'),(129,'NO','NOR','Norway','NOK'),(130,'OM','OMN','Oman','OMR'),(131,'PK','PAK','Pakistan','PKR'),(132,'PW','PLW','Palau','USD'),(133,'PA','PAN','Panama','PAB'),(134,'PG','PNG','Papua New Guinea','PGK'),(135,'PY','PRY','Paraguay','PYG'),(136,'PE','PER','Peru','PEN'),(137,'PH','PHL','Philippines','PHP'),(138,'PL','POL','Poland','PLN'),(139,'PT','PRT','Portugal','EUR'),(140,'QA','QAT','Qatar','QAR'),(141,'RO','ROU','Romania','RON'),(142,'RU','RUS','Russia','RUB'),(143,'RW','RWA','Rwanda','RWF'),(144,'KN','KNA','Saint Kitts and Nevis','XCD'),(145,'LC','LCA','Saint Lucia','XCD'),(146,'VC','VCT','Saint Vincent and the Grenadines','XCD'),(147,'WS','WSM','Samoa','WST'),(148,'SM','SMR','San Marino','EUR'),(149,'ST','STP','Sao Tome and Principe','STD'),(150,'SA','SAU','Saudi Arabia','SAR'),(151,'SN','SEN','Senegal','XOF'),(153,'SC','SYC','Seychelles','SCR'),(154,'SL','SLE','Sierra Leone','SLL'),(155,'SG','SGP','Singapore','SGD'),(156,'SK','SVK','Slovakia','SKK'),(157,'SI','SVN','Slovenia','SIT'),(158,'SB','SLB','Solomon Islands','SBD'),(159,'SO','SOM','Somalia','SOS'),(160,'ZA','ZAF','South Africa','ZAR'),(161,'ES','ESP','Spain','EUR'),(162,'LK','LKA','Sri Lanka','LKR'),(163,'SD','SDN','Sudan','SDD'),(164,'SR','SUR','Suriname','SRD'),(165,'SZ','SWZ','Swaziland','SZL'),(166,'SE','SWE','Sweden','SEK'),(167,'CH','CHE','Switzerland','CHF'),(168,'SY','SYR','Syria','SYP'),(169,'TJ','TJK','Tajikistan','TJS'),(170,'TZ','TZA','Tanzania','TZS'),(171,'TH','THA','Thailand','THB'),(172,'TL','TLS','Timor-Leste (East Timor)','USD'),(173,'TG','TGO','Togo','XOF'),(174,'TO','TON','Tonga','TOP'),(175,'TT','TTO','Trinidad and Tobago','TTD'),(176,'TN','TUN','Tunisia','TND'),(177,'TR','TUR','Turkey','TRY'),(178,'TM','TKM','Turkmenistan','TMM'),(179,'TV','TUV','Tuvalu','AUD'),(180,'UG','UGA','Uganda','UGX'),(181,'UA','UKR','Ukraine','UAH'),(182,'AE','ARE','United Arab Emirates','AED'),(183,'GB','GBR','United Kingdom','GBP'),(184,'US','USA','United States','USD'),(185,'UY','URY','Uruguay','UYU'),(186,'UZ','UZB','Uzbekistan','UZS'),(187,'VU','VUT','Vanuatu','VUV'),(188,'VA','VAT','Vatican City','EUR'),(189,'VE','VEN','Venezuela','VEB'),(190,'VN','VNM','Viet Nam','VND'),(191,'YE','YEM','Yemen','YER'),(192,'ZM','ZMB','Zambia','ZMK'),(193,'ZW','ZWE','Zimbabwe','ZWD'),(195,'TW','TWN','China, Republic of (Taiwan)','TWD'),(202,'CX','CXR','Christmas Island','AUD'),(203,'CC','CCK','Cocos (Keeling) Islands','AUD'),(205,'HM','HMD','Heard Island and McDonald Islands',''),(206,'NF','NFK','Norfolk Island','AUD'),(207,'NC','NCL','New Caledonia','XPF'),(208,'PF','PYF','French Polynesia','XPF'),(209,'YT','MYT','Mayotte','EUR'),(210,'PM','SPM','Saint Pierre and Miquelon','EUR'),(211,'WF','WLF','Wallis and Futuna','XPF'),(212,'TF','ATF','French Southern and Antarctic Lands',''),(214,'BV','BVT','Bouvet Island',''),(215,'CK','COK','Cook Islands','NZD'),(216,'NU','NIU','Niue','NZD'),(217,'TK','TKL','Tokelau','NZD'),(218,'GG','GGY','Guernsey','GGP'),(219,'IM','IMN','Isle of Man','IMP'),(220,'JE','JEY','Jersey','JEP'),(221,'AI','AIA','Anguilla','XCD'),(222,'BM','BMU','Bermuda','BMD'),(223,'IO','IOT','British Indian Ocean Territory',''),(224,'VG','VGB','British Virgin Islands','USD'),(225,'KY','CYM','Cayman Islands','KYD'),(226,'FK','FLK','Falkland Islands (Islas Malvinas)','FKP'),(227,'GI','GIB','Gibraltar','GIP'),(228,'MS','MSR','Montserrat','XCD'),(229,'PN','PCN','Pitcairn Islands','NZD'),(230,'SH','SHN','Saint Helena','SHP'),(231,'GS','SGS','South Georgia and the South Sandwich Islands',''),(232,'TC','TCA','Turks and Caicos Islands','USD'),(233,'MP','MNP','Northern Mariana Islands','USD'),(234,'PR','PRI','Puerto Rico','USD'),(235,'AS','ASM','American Samoa','USD'),(236,'UM','UMI','Baker Island',''),(237,'GU','GUM','Guam','USD'),(245,'VI','VIR','U.S. Virgin Islands','USD'),(247,'HK','HKG','Hong Kong','HKD'),(248,'MO','MAC','Macau','MOP'),(249,'FO','FRO','Faroe Islands','DKK'),(250,'GL','GRL','Greenland','DKK'),(251,'GF','GUF','French Guiana','EUR'),(252,'GP','GLP','Guadeloupe','EUR'),(253,'MQ','MTQ','Martinique','EUR'),(254,'RE','REU','Reunion','EUR'),(255,'AX','ALA','Aland','EUR'),(256,'AW','ABW','Aruba','AWG'),(257,'AN','ANT','Netherlands Antilles','ANG'),(258,'SJ','SJM','Svalbard','NOK'),(259,'AC','ASC','Ascension','SHP'),(260,'TA','TAA','Tristan da Cunha','SHP'),(261,'AQ','ATA','Antarctica',''),(263,'PS','PSE','Palestinian Territories (Gaza Strip and West Bank)','ILS'),(264,'EH','ESH','Western Sahara','MAD');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datastorage`
--

DROP TABLE IF EXISTS `datastorage`;
CREATE TABLE `datastorage` (
  `id` int(11) NOT NULL auto_increment,
  `data` longblob NOT NULL,
  `content_type` varchar(128) NOT NULL,
  `filename` varchar(128) NOT NULL,
  `filesize` int(11) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `datastorage`
--

LOCK TABLES `datastorage` WRITE;
/*!40000 ALTER TABLE `datastorage` DISABLE KEYS */;
/*!40000 ALTER TABLE `datastorage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datastorage_search`
--

DROP TABLE IF EXISTS `datastorage_search`;
CREATE TABLE `datastorage_search` (
  `id` int(11) NOT NULL auto_increment,
  `file_id` int(11) NOT NULL,
  `tags` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `datastorage_search`
--

LOCK TABLES `datastorage_search` WRITE;
/*!40000 ALTER TABLE `datastorage_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `datastorage_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbtable`
--

DROP TABLE IF EXISTS `dbtable`;
CREATE TABLE `dbtable` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `table` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `label` varchar(50) NOT NULL,
  `type` varchar(1000) NOT NULL,
  `modifier` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dbtable`
--

LOCK TABLES `dbtable` WRITE;
/*!40000 ALTER TABLE `dbtable` DISABLE KEYS */;
/*!40000 ALTER TABLE `dbtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `filename` varchar(255) default NULL,
  `type` varchar(255) default NULL,
  `description` text,
  `permission` enum('public','private') default 'public',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups_permissions`
--

DROP TABLE IF EXISTS `groups_permissions`;
CREATE TABLE `groups_permissions` (
  `group_id` int(11) NOT NULL,
  `perm_id` int(11) NOT NULL,
  UNIQUE KEY `group_id_2` (`group_id`,`perm_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_permissions`
--

LOCK TABLES `groups_permissions` WRITE;
/*!40000 ALTER TABLE `groups_permissions` DISABLE KEYS */;
INSERT INTO `groups_permissions` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
/*!40000 ALTER TABLE `groups_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help`
--

DROP TABLE IF EXISTS `help`;
CREATE TABLE `help` (
  `helpid` varchar(32) NOT NULL,
  `title` tinytext,
  `body` text,
  PRIMARY KEY  (`helpid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `help`
--

LOCK TABLES `help` WRITE;
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` VALUES ('addmenuitem','Add Menu Item','\"Add Menu Item\" will guide you through the process of adding links to your site\'s menu structure');
/*!40000 ALTER TABLE `help` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` int(11) NOT NULL auto_increment,
  `data` mediumblob NOT NULL,
  `content_type` varchar(32) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `filesize` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images_cache`
--

DROP TABLE IF EXISTS `images_cache`;
CREATE TABLE `images_cache` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `image_id` int(11) NOT NULL,
  `hash` varchar(40) NOT NULL,
  `data` mediumblob NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `hash_2` (`hash`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `images_cache`
--

LOCK TABLES `images_cache` WRITE;
/*!40000 ALTER TABLE `images_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `images_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locale`
--

DROP TABLE IF EXISTS `locale`;
CREATE TABLE `locale` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(16) NOT NULL,
  `display_name` varchar(128) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `locale`
--

LOCK TABLES `locale` WRITE;
/*!40000 ALTER TABLE `locale` DISABLE KEYS */;
INSERT INTO `locale` VALUES (1,'en_CA','English (Canada)'),(2,'fr_CA','Fran&ccedil;ais (Canada)'),(3,'ja_JP','Japanese (&#x65e5;&#x672c;&#x8a9e;)'),(4,'ar_OM','Arabic (Oman)\r\n(&#x0627;&#x0644;&#x0639;&#x0631;&#x0628;&#x064a;&#x0629;)'),(5,'el_GR','Greek\r\n(&#x0395;&#x03bb;&#x03bb;&#x03b7;&#x03bd;&#x03b9;&#x03ba;&#x03ac;)'),(6,'ar_SY','Arabic (Syria)\r\n(&#x0627;&#x0644;&#x0639;&#x0631;&#x0628;&#x064a;&#x0629;)'),(7,'id_ID','Bahasa Indonesia'),(8,'bs_BA','Bosanski'),(9,'bg_BG','Bulgarian\r\n(&#x0411;&#x044a;&#x043b;&#x0433;&#x0430;&#x0440;&#x0441;&#x043a;&#x0438;)'),(10,'ca_ES','Catal&agrave;'),(11,'zh_CN','Chinese (Simplified)\r\n(&#x7b80;&#x4f53;&#x4e2d;&#x6587;)'),(12,'zh_TW','Chinese (Traditional)\r\n(&#x6b63;&#x9ad4;&#x4e2d;&#x6587;)'),(13,'cs_CZ','Czech (&#x010c;esky)'),(14,'da_DK','Dansk'),(15,'de_DE','Deutsch'),(16,'en_US','English (American)'),(17,'en_GB','English (British)'),(18,'es_ES','Espa&ntilde;ol'),(19,'et_EE','Eesti'),(20,'gl_ES','Galego'),(21,'he_IL','Hebrew (&#x05E2;&#x05D1;&#x05E8;&#x05D9;&#x05EA;)'),(22,'is_IS','&Iacute;slenska'),(23,'it_IT','Italiano'),(24,'km_KH','Khmer (&#x1781;&#x17d2;&#x1798;&#x17c2;&#x179a;)'),(25,'ko_KR','Korean (&#xd55c;&#xad6d;&#xc5b4;)'),(26,'lv_LV','Latvie&#x0161;u'),(27,'lt_LT','Lietuvi&#x0173;'),(28,'mk_MK','Macedonian\r\n(&#x041c;&#x0430;&#x043a;&#x0435;&#x0434;&#x043e;&#x043d;&#x0441;&#x043a;&#x0438;)'),(29,'hu_HU','Magyar'),(30,'nl_NL','Nederlands'),(31,'nb_NO','Norsk bokm&aring;l'),(32,'nn_NO','Norsk nynorsk'),(33,'fa_IR','Persian (&#x0641;&#x0627;&#x0631;&#x0633;&#x0649;)'),(34,'pl_PL','Polski'),(35,'pt_PT','Portugu&ecirc;s'),(36,'pt_BR','Portugu&ecirc;s Brasileiro'),(37,'ro_RO','Rom&acirc;n&auml;'),(38,'ru_RU','Russian\r\n(&#x0420;&#x0443;&#x0441;&#x0441;&#x043a;&#x0438;&#x0439;)'),(39,'sk_SK','Slovak (Sloven&#x010d;ina)'),(40,'sl_SI','Slovenian (Sloven&#x0161;&#x010d;ina)'),(41,'fi_FI','Suomi'),(42,'sv_SE','Svenska'),(43,'th_TH','Thai (&#x0e44;&#x0e17;&#x0e22;)'),(44,'tr_TR','T&uuml;rk&ccedil;e'),(45,'uk_UA','Ukrainian\r\n(&#x0423;&#x043a;&#x0440;&#x0430;&#x0457;&#x043d;&#x0441;&#x044c;&#x043a;&#x0430;)');
/*!40000 ALTER TABLE `locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL auto_increment,
  `parentid` int(11) NOT NULL,
  `display` tinytext NOT NULL,
  `link` text NOT NULL,
  `module` tinytext NOT NULL,
  `target` enum('same','new') NOT NULL,
  `status` tinyint(1) NOT NULL default '1',
  `sort` tinyint(3) unsigned NOT NULL,
  `menuid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `parentid` (`parentid`),
  KEY `sort` (`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `template` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Main Navigation Menu','menu_rendertop.tpl'),(2,'Sub Navigation','menu_rendertop.tpl');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `module` varchar(32) NOT NULL,
  `display_name` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `module` (`module`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'Content','Site Content'),(5,'Menu','Menu Management'),(8,'User','User'),(17,'Block','Blocks Management'),(21,'Gallery','Photo Gallery'),(22,'Templater','Templater'),(23,'Analytics','Google Analytics'),(24,'SiteConfig','Site Config'),(25,'SEO','SEO'),(26,'Search','Search');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `key` text,
  `class` text,
  `name` text,
  `description` text,
  `group_id` int(11) default NULL,
  `status` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'admin','CMS','Admin Access',NULL,1,1),(2,'view','Permission','View Permissions',NULL,1,1),(3,'addedit','Permission','Add/Edit Permissions',NULL,1,1),(4,'delete','Permission','Delete Permissions','',1,1),(5,'view','User','View Users','',1,1),(6,'addedit','User','Add/Edit Users','',1,1),(7,'delete','User','Delete Users','',1,1),(8,'view','Group','View Groups','',1,1),(9,'addedit','Group','Add/Edit Groups','',1,1),(10,'delete','Group','Delete Groups','',1,1),(11,'addedit','Block','Add/Edit Blocks','',1,1),(12,'view','Block','View Blocks','',1,1),(13,'delete','Block','Delete Blocks',NULL,1,1),(14,'view','ContentPage','View Content Pages','',1,1),(15,'addedit','ContentPage','Add / Edit Content Pages','',1,1),(16,'delete','ContentPage','Delete Content Pages','',1,1),(17,'view','ContentPageRevision','View Content Page Revisions','',1,1),(18,'addedit','ContentPageRevision','Add / Edit Content Page Revisions','',1,1),(19,'delete','ContentPageRevision','Delete Content Page Revisions','',1,1);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE `states` (
  `id` int(10) unsigned NOT NULL default '0',
  `country` int(10) unsigned NOT NULL default '0',
  `code` varchar(5) NOT NULL default '',
  `name` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `states`
--

LOCK TABLES `states` WRITE;
/*!40000 ALTER TABLE `states` DISABLE KEYS */;
INSERT INTO `states` VALUES (72,31,'NU','Nunavut'),(1,31,'AB','Alberta'),(2,31,'BC','British Columbia'),(3,31,'MB','Manitoba'),(4,31,'NB','New Brunswick'),(5,31,'NF','Newfoundland'),(6,31,'NT','Northwest Territories'),(7,31,'NS','Nova Scotia'),(8,31,'ON','Ontario'),(9,31,'PE','Prince Edward Island'),(10,31,'QC','Quebec'),(11,31,'SK','Saskatchewan'),(12,31,'YT','Yukon'),(13,184,'AL','Alabama'),(14,184,'AK','Alaska'),(15,184,'AS','American Samoa'),(16,184,'AZ','Arizona'),(17,184,'AR','Arkansas'),(18,184,'CA','California'),(19,184,'CO','Colorado'),(20,184,'CT','Connecticut'),(21,184,'DE','Delaware'),(22,184,'DC','District of Columbia'),(23,184,'FM','Fed. States of Micronesia'),(24,184,'FL','Florida'),(25,184,'GA','Georgia'),(26,184,'GU','Guam'),(27,184,'HI','Hawaii'),(28,184,'ID','Idaho'),(29,184,'IL','Illinois'),(30,184,'IN','Indiana'),(31,184,'IA','Iowa'),(32,184,'KS','Kansas'),(33,184,'KY','Kentucky'),(34,184,'LA','Louisiana'),(35,184,'ME','Maine'),(36,184,'MH','Marshall Islands'),(37,184,'MD','Maryland'),(38,184,'MA','Massachusetts'),(39,184,'MI','Michigan'),(40,184,'MN','Minnesota'),(41,184,'MS','Mississippi'),(42,184,'MO','Missouri'),(43,184,'MT','Montana'),(44,184,'NE','Nebraska'),(45,184,'NV','Nevada'),(46,184,'NH','New Hampshire'),(47,184,'NJ','New Jersey'),(48,184,'NM','New Mexico'),(49,184,'NY','New York'),(50,184,'NC','North Carolina'),(51,184,'ND','North Dakota'),(52,184,'MP','Northern Mariana Is.'),(53,184,'OH','Ohio'),(54,184,'OK','Oklahoma'),(55,184,'OR','Oregon'),(56,184,'PW','Palau'),(57,184,'PA','Pennsylvania'),(58,184,'PR','Puerto Rico'),(59,184,'RI','Rhode Island'),(60,184,'SC','South Carolina'),(61,184,'SD','South Dakota'),(62,184,'TN','Tennessee'),(63,184,'TX','Texas'),(64,184,'UT','Utah'),(65,184,'VT','Vermont'),(66,184,'VA','Virginia'),(67,184,'VI','Virgin Islands'),(68,184,'WA','Washington'),(69,184,'WV','West Virginia'),(70,184,'WI','Wisconsin'),(71,184,'WY','Wyoming');
/*!40000 ALTER TABLE `states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `module` varchar(32) NOT NULL default '',
  `path` varchar(64) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `id` int(11) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  PRIMARY KEY  (`id`),
  KEY `path` (`path`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES ('Module_Content','content.tpl','<script type=\"text/javascript\">genFlash(\'/flash/leftCol.swf?pagetitle={$content->getPageTitle()}\', 615, 35, \'\', \'transparent\');</script>\r\n{$content->getContent()}','2008-07-28 23:26:32',33,'Content Page'),('CMS','site.tpl','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" />\r\n<meta name=\"keywords\" content=\"{$metaKeywords}\" />\r\n<meta name=\"description\" content=\"{$metaDescription}\" />\r\n<meta name=\"title\" content=\"{$metaTitle}\" />\r\n<title>{$title}</title>\r\n<link rel=\"stylesheet\" href=\"/css/style.css,/css/cssMenus.css{foreach from=$css item=cssUrl},{$cssUrl}{/foreach}\" type=\"text/css\" />\r\n\r\n\r\n<script type=\"text/javascript\" src=\"/js/prototype.js{foreach from=$js item=jsUrl},{$jsUrl}{/foreach}\"></script>\r\n\r\n</head>\r\n\r\n<body>\r\n\r\n<h1>{$title}</h1>\r\n\r\n{module class=\"Menu\"}\r\n	\r\n{if $user}<a href=\"/user/logout\">Logout</a>{else}<a href=\"/user/login\">Login</a>{/if}\r\n\r\n{module class=$module}\r\n\r\n</body>\r\n</html>','2008-08-05 14:35:40',37,'Default Site Template'),('CMS','css/cssMenus.css','','2008-07-29 03:42:33',53,'Menu Styles'),('CMS','css/style.css','ol {\r\n	list-style-type: none;\r\n	padding-left: 0px;\r\n	margin-left: 0px;\r\n}\r\n\r\nfieldset {\r\n	border: none;\r\n	padding-left: 0px;\r\n	margin-left: 0px;\r\n}\r\n','2008-07-29 03:44:53',55,'Site Styles'),('Module_Menu','menu_rendertop.tpl','<div id=\"nav\">\r\n	<ul id=\"navUl\">\r\n	{assign var=menuCount value=0}\r\n	{foreach from=$menu item=item}\r\n		{assign var=menuCount value=$menuCount+1}\r\n		{strip}<li><a href=\"{$item->link}\"{if $item->target == \"new\"} target=\"_blank\"{/if}>{$item->display}</a>\r\n		{if $item->children}{assign var=\"children\" value=true}<ul>{else}{assign var=\"children\" value=false}{/if}\r\n		{foreach from=$item->children item=item}\r\n		{assign var=\"depth\" value=1}\r\n		{include file=db:menu_renderitems.tpl menu=item}\r\n		{/foreach}\r\n		{if $children}</ul>{/if}\r\n		</li>\r\n		{if $menuCount < $menu|@count}\r\n			<li class=\"menuDivider\">?</li>\r\n		{/if}{/strip}\r\n		{/foreach}\r\n	</ul>\r\n</div>','2008-07-29 04:43:02',57,'Main Menu Template');
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-12-29 16:28:17
