/*
SQLyog Enterprise - MySQL GUI v6.0
Host - 5.0.37-community-nt : Database - geneon
*********************************************************************
Server version : 5.0.37-community-nt
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `geneon`;

USE `geneon`;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `app_dict` */

DROP TABLE IF EXISTS `app_dict`;

CREATE TABLE `app_dict` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(100) default NULL,
  `value` varchar(100) default NULL,
  `type` varchar(100) default NULL,
  `pinyin` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_dict` */

insert  into `app_dict`(`id`,`key`,`value`,`type`,`pinyin`) values (1,'article.state.normal','普通','article.state','putong'),(2,'article.state.recommand','推荐','article.state','tuijian'),(3,'article.state.top','置顶','article.state','zhiding'),(4,'ascii','ACSII码','regex','acsii'),(10,'boolean.false','否','boolean','fou'),(11,'boolean.true','是','boolean','shi'),(20,'chinese','中文','regex','zhengwen'),(24,'content.mode.more','多项','content.mode','duoxiang'),(25,'content.mode.none','空项','content.mode','kongxiang'),(26,'content.mode.one','单项','content.mode','danxiang'),(28,'decmal','浮点数','regex','fudianshu'),(29,'email','邮箱','regex','youxiang'),(39,'id','标识','regex','biaoshi'),(40,'idcard','身份证','regex','shenfenzheng'),(41,'integer','整数','regex','zhengshu'),(42,'letter','字母','regex','zimu'),(43,'loginId','登录标识','regex','denglubiaoshi'),(46,'node.condition.auth','权限','node.condition.model','qanxian'),(47,'node.condition.auth.department','组织机构','node.condition.auth','bumen'),(48,'node.condition.auth.role','角色','node.condition.auth','juese'),(49,'node.condition.auth.user','用户','node.condition.auth','yonghu'),(53,'notempty','非空','regex','feikong'),(54,'number','数字','regex','shuzi'),(55,'phone','手机电话','regex','shouji'),(56,'picture','图片','regex','tupian'),(57,'qq','QQ号','regex','qq'),(58,'rar','压缩文件','regex','yasuowenjian'),(59,'tel','座机电话','regex','zuoji'),(60,'url','URL','regex','url'),(61,'visible.false','隐藏','visible','yinchang'),(62,'visible.true','显示','visible','xianshi'),(63,'zipcode','邮编','regex','youbian'),(64,'只读','只读','node.state','zhidu'),(65,'必填','必填','node.state','bitian'),(66,'选填','选填','node.state','xuantian'),(67,'隐藏','隐藏','node.state','yincang'),(95,'女','女','gender','nv'),(96,'男','男','gender','nan'),(97,'是','是','easyboolean','shi'),(98,'否','否','easyboolean','fou'),(99,'message.state.false','未回复','message.state','weihuifu'),(100,'message.state.true','已回复','message.state','yihuifu');

/*Table structure for table `app_resources` */

DROP TABLE IF EXISTS `app_resources`;

CREATE TABLE `app_resources` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `path` varchar(100) default NULL,
  `parentId` varchar(100) default NULL,
  `sort` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `app_resources` */

insert  into `app_resources`(`id`,`name`,`path`,`parentId`,`sort`) values ('auth','管理权限',NULL,NULL,1),('auth.user','管理用户','/app/auth/user/showUsers.jsp','auth',2),('auth.role','管理角色','/app/auth/role/showRoles.jsp','auth',3),('auth.resource','管理资源','/app/auth/resource/showResources.jsp','auth',4),('configuration','管理基础配置','',NULL,6),('configuration.dict','管理数据字典','/app/system/dict/showDicts.jsp','configuration',7),('website','管理网站','',NULL,8),('website.content','管理目录','/app/website/content/show.jsp','website',14),('website.article','管理文章','/app/website/article/show.jsp','website',32),('auth.change.password','修改密码','/app/auth/user/changePassword.jsp',NULL,57),('website.message','管理留言','/app/website/message/show.jsp','website',103),('website.geneon','管理文章','/app/website/admin/main.jsp?cid=geneon','website',104),('website.geneonproduct','管理产品','/app/website/admin/main.jsp?cid=geneonproduct','website',105),('website.geneonhtml','管理代码','/app/website/admin/main.jsp?cid=geneonhtml','website',106);

/*Table structure for table `auth_re_role_resource` */

DROP TABLE IF EXISTS `auth_re_role_resource`;

CREATE TABLE `auth_re_role_resource` (
  `roleId` int(100) NOT NULL,
  `resourceId` varchar(100) character set gb2312 NOT NULL default '',
  PRIMARY KEY  (`roleId`,`resourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_role_resource` */

insert  into `auth_re_role_resource`(`roleId`,`resourceId`) values (1,'auth.change.password'),(1,'website'),(1,'website.content'),(1,'website.geneon'),(1,'website.geneonproduct'),(1,'website.message'),(5,'auth'),(5,'auth.change.password'),(5,'auth.resource'),(5,'auth.role'),(5,'auth.user'),(5,'configuration'),(5,'configuration.dict'),(5,'website'),(5,'website.content'),(5,'website.geneon'),(5,'website.geneonhtml'),(5,'website.geneonproduct'),(5,'website.message');

/*Table structure for table `auth_re_user_resource` */

DROP TABLE IF EXISTS `auth_re_user_resource`;

CREATE TABLE `auth_re_user_resource` (
  `userId` varchar(100) NOT NULL,
  `resourceId` varchar(100) NOT NULL,
  PRIMARY KEY  (`userId`,`resourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_user_resource` */

/*Table structure for table `auth_re_user_role` */

DROP TABLE IF EXISTS `auth_re_user_role`;

CREATE TABLE `auth_re_user_role` (
  `userId` varchar(100) character set gb2312 NOT NULL,
  `roleId` int(100) NOT NULL,
  PRIMARY KEY  (`userId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_user_role` */

insert  into `auth_re_user_role`(`userId`,`roleId`) values ('admin',1),('system',5);

/*Table structure for table `auth_roles` */

DROP TABLE IF EXISTS `auth_roles`;

CREATE TABLE `auth_roles` (
  `id` int(100) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_roles` */

insert  into `auth_roles`(`id`,`name`,`description`) values (1,'管理员','拥有网站维护权限'),(5,'系统维护员','开发人员专用');

/*Table structure for table `auth_users` */

DROP TABLE IF EXISTS `auth_users`;

CREATE TABLE `auth_users` (
  `Id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) default NULL,
  `phone` varchar(100) default NULL,
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_users` */

insert  into `auth_users`(`Id`,`name`,`password`,`email`,`phone`) values ('admin','管理员','lueSGJZetyySpUndWjMBEg==','',''),('system','开发维护员','vBpUO9JAP1iAv567KS8XDw==','','');

/*Table structure for table `web_article` */

DROP TABLE IF EXISTS `web_article`;

CREATE TABLE `web_article` (
  `id` int(100) NOT NULL auto_increment,
  `cid` varchar(100) default NULL,
  `title` varchar(200) default NULL,
  `text` varchar(20000) default NULL,
  `type` varchar(100) default NULL,
  `typeName` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `stateName` varchar(100) default NULL,
  `count` int(11) default '0',
  `createTime` datetime default NULL,
  `operater` varchar(100) default NULL,
  `operaterName` varchar(100) default NULL,
  `image` varchar(500) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `web_article` */

insert  into `web_article`(`id`,`cid`,`title`,`text`,`type`,`typeName`,`state`,`stateName`,`count`,`createTime`,`operater`,`operaterName`,`image`) values (419,'geneon.about','公司简介','<p style=\"text-indent:2em;\">\r\n	<span style=\"line-height:2;color:#003399;\">长春市志昂生物科技有限公司</span><span style=\"line-height:2;\">（简称志昂生物）坐落于吉林省长春市高新区，是一家集研发、生产、销售、服务为一体的专业化生物技术公司。公司前身为长春市博坤生物科技有限公司（简称博坤生物）的生命科学部。2012年5月，博坤生物进行业务拆分，博坤生物专注于公安法检领域，新成立的志昂生物从事公安法检以外的生命科学领域。</span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	&nbsp;<span style=\"line-height:2;\">公司拥有雄厚的技术力量和科技实力，研发团队中具有博士学位者占50%以上。公司具备独立的研发体系和较强的研发能力，目前已成功研发具有国际先进水平的磁珠法核酸提取试剂盒数十种，包括全血、血浆、植物、动物、昆虫、病毒等核酸提取试剂盒。公司在重视产品质量的同时，结合客户需求，提供个性化的手工及自动化解决方案，以及全方位的技术支持和服务。</span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	&nbsp;<span style=\"line-height:2;\">志昂生物敢为人先，引领市场，秉承“产品关键，服务至上”的理念，愿与各界同仁携手合作，共创辉煌！</span> \r\n</p>\r\n<p style=\"text-indent:2em;\">\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-26 22:31:55','admin','管理员',''),(454,'geneonhtml.banner','广告位','imgUrl1=\"/geneon/attached/image/20121128/20121128105038_649.jpg\";\r\nimgtext1=\"#\"\r\nimgLink1=escape(\"#\");\r\nimgUrl2=\"/geneon/attached/image/20121128/20121128105101_434.jpg\";\r\nimgtext2=\"#\"\r\nimgLink2=escape(\"#\");\r\nimgUrl3=\"/geneon/attached/image/20121128/20121128105045_671.jpg\";\r\nimgtext3=\"#\"\r\nimgLink3=escape(\"#\");\r\nimgUrl4=\"/geneon/attached/image/20121128/20121128105109_827.jpg\";\r\nimgtext4=\"#\"\r\nimgLink4=escape(\"#\");\r\nimgUrl5=\"/geneon/attached/image/20121128/20121128104955_653.jpg\";\r\nimgtext5=\"#\"\r\nimgLink5=escape(\"#\");\r\n var focus_width=1003;\r\n var focus_height=270;\r\n var text_height=0;\r\n var swf_height = focus_height+text_height;\r\n var pics=imgUrl1+\"|\"+imgUrl2+\"|\"+imgUrl3+\"|\"+imgUrl4+\"|\"+imgUrl5;\r\n var links=imgLink1+\"|\"+imgLink2+\"|\"+imgLink3+\"|\"+imgLink4+\"|\"+imgLink5;\r\n var texts=imgtext1+\"|\"+imgtext2+\"|\"+imgtext3+\"|\"+imgtext4+\"|\"+imgtext5;\r\n','article.state.normal','普通','visible.true','显示',0,'2012-11-27 23:51:50','system','开发维护员',''),(455,'geneonhtml.cntact','推荐解决方案','<div class=\"part\">\r\n<div class=\"parta\">\r\n  <h1>推荐解决方案</h1>\r\n</div>\r\n  <div class=\"partb\">\r\n  	<div class=\"qh\">\r\n  	  <object id=\"FlashID2\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"266\" height=\"223\">\r\n  	    <param name=\"movie\" value=\"flash/bh.swf\" />\r\n  	    <param name=\"quality\" value=\"high\" />\r\n  	    <param name=\"wmode\" value=\"opaque\" />\r\n  	    <param name=\"swfversion\" value=\"6.0.65.0\" />\r\n  	    <!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->\r\n  	    <param name=\"expressinstall\" value=\"Scripts/expressInstall.swf\" />\r\n  	    <!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->\r\n  	    <!--[if !IE]>-->\r\n  	    <object type=\"application/x-shockwave-flash\" data=\"flash/bh.swf\" width=\"266\" height=\"223\">\r\n  	      <!--<![endif]-->\r\n  	      <param name=\"quality\" value=\"high\" />\r\n  	      <param name=\"wmode\" value=\"opaque\" />\r\n  	      <param name=\"swfversion\" value=\"6.0.65.0\" />\r\n  	      <param name=\"expressinstall\" value=\"Scripts/expressInstall.swf\" />\r\n  	      <!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->\r\n  	      <div>\r\n  	        <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>\r\n  	        <p><a href=\"http://www.adobe.com/go/getflashplayer\"><img src=\"http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif\" alt=\"获取 Adobe Flash Player\" width=\"112\" height=\"33\" /></a></p>\r\n	        </div>\r\n  	      <!--[if !IE]>-->\r\n	      </object>\r\n  	    <!--<![endif]-->\r\n	    </object>\r\n  	</div>\r\n      <div class=\"pc\"><img src=\"images/jqr.jpg\" width=\"266\" height=\"202\" /></div>\r\n      <div class=\"clear\"></div>\r\n  </div>\r\n  <div class=\"clear\"></div>\r\n  </div>','article.state.normal','普通','visible.true','显示',0,'2012-11-27 23:52:48','system','开发维护员',''),(456,'geneonhtml.contactme','联系我们','<div class=\"part\">\r\n<div class=\"parta\">\r\n  <h1>联系我们</h1>\r\n</div>\r\n  <div class=\"partb\">\r\n  	<div class=\"contant\">\r\n     	  <h2>长春市志昂生物科技有限公司</h2>\r\n          <div class=\"lxfs\">\r\n          <p>高新区锦湖大路1357号5楼516室</p>\r\n      	<p>0431-89251663</p>\r\n          <p>0431-89251665</p>\r\n          <p>info@geneonbio.com</p>\r\n          </div>\r\n      </div>\r\n  </div>\r\n  <div class=\"clear\"></div>\r\n  </div>','article.state.normal','普通','visible.true','显示',0,'2012-11-27 23:53:14','system','开发维护员',''),(457,'geneonhtml.foot','页尾','<p>\r\n	Copyright© 2012长春市志昂生的科技有限公司 All Rights Reseived\r\n</p>\r\n<p>\r\n	地址：高新区锦湖大路1357号5楼516室\r\n</p>\r\n<p>\r\n	网站备案:吉ICP备00000008</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-27 23:53:43','system','开发维护员',''),(458,'geneon.new','医学发展历程','sd','article.state.normal','普通','visible.true','显示',0,'2012-11-28 09:11:06','system','开发维护员',''),(459,'geneonproduct.chanpin1.chanpin15','病毒DNA/RNA磁珠法提取产品','<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130817_152.jpg\" />\r\n</p>\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>\r\n<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130834_656.jpg\" /> \r\n<p>\r\n	&nbsp;\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130847_914.jpg\" /> \r\n<p>\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 10:41:21','admin','管理员','/geneon/attached/appCar/20121128/20121128130713_296.jpg'),(460,'geneonproduct.chanpin1.chanpin11','血液DNARNA磁珠法提取产品','<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128124920_903.jpg\" /> \r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128125026_702.jpg\" /> \r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128125042_145.jpg\" /> \r\n</p>\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 12:46:47','admin','管理员','/geneon/attached/appCar/20121128/20121128124734_502.jpg'),(461,'geneonproduct.chanpin1.chanpin12','动物组织和培养细胞DNARNA磁珠法提取产品','<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128125812_262.jpg\" /> \r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128125843_391.jpg\" /> \r\n</p>\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p>\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128125902_244.jpg\" /> \r\n</p>\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 12:52:34','admin','管理员','/geneon/attached/appCar/20121128/20121128125302_771.jpg'),(462,'geneonproduct.chanpin1.chanpin13','植物DNA/RNA磁珠法提取产品','<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130047_364.jpg\" />\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130108_707.jpg\" />\r\n</p>\r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130132_7.jpg\" />\r\n</p>\r\n&nbsp;\r\n<p>\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 12:59:47','admin','管理员','/geneon/attached/appCar/20121128/20121128130027_886.jpg'),(463,'geneonproduct.chanpin1.chanpin14','磁珠法DNA片段回收纯化产品','<p align=\"center\">\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130239_141.jpg\" />\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<p>\r\n	<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130305_902.jpg\" />\r\n</p>\r\n<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />\r\n<img alt=\"\" src=\"/geneon/attached/image/20121128/20121128130320_27.jpg\" /> \r\n<p align=\"center\">\r\n	&nbsp;\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 13:02:00','admin','管理员','/geneon/attached/appCar/20121128/20121128130226_132.jpg'),(464,'geneon.contact','联系我们','<p>\r\n	<span style=\"font-size:16px;\"><strong></strong></span>&nbsp;\r\n</p>\r\n<p>\r\n	<span style=\"line-height:2;font-size:16px;\"><strong>　　　　　　　　　长春市志昂生物科技有限公司 </strong></span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:2;\">　　　　　　　　　地址：高新区锦湖大路1357号5楼516室</span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:2;\">　　　　　　　　　电话：0431-89251663</span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:2;\">　　　　　　　　　传真：0431-89251665</span>\r\n</p>\r\n<p>\r\n	<span style=\"line-height:2;\">　　　　　　　　　E-mail:&nbsp;&nbsp;info@geneonbio.com&nbsp;</span>\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-11-28 13:14:14','admin','管理员',''),(465,'geneon.product','精密仪器','在科学发展历史上，精密仪器作为治疗疾病的工具为人类的发展迈向了更高的一个台阶。','article.state.normal','普通','visible.true','显示',0,'2012-12-15 12:18:16','admin','管理员','/geneon/attached/appCar/20121215/20121215122052_604.jpg'),(466,'geneon.new','科学发展的重要性','<p>\r\n	科学的发展，精密仪器的发展对未来医学界有着显著的重要意义。\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-12-15 13:25:15','admin','管理员','/geneon/attached/appCar/20121215/20121215132541_881.jpg'),(467,'geneon.technology','先进技术的可行性方案','先进技术大大提高了医疗的效率，为大力开展开创了一个新纪元。','article.state.normal','普通','visible.true','显示',0,'2012-12-15 13:37:39','admin','管理员','/geneon/attached/appCar/20121215/20121215133851_278.jpg'),(468,'geneon.reserve','购买仪器需要主要什么','<p>\r\n	&nbsp;\r\n</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 为了保证机器的质量问题一定不要选择价格低廉没有安全保证的。\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-12-15 14:45:23','admin','管理员','/geneon/attached/appCar/20121215/20121215144601_40.jpg'),(469,'geneon.technology','此信息作为测试','<p>\r\n	&nbsp;&nbsp;&nbsp;\r\n</p>\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 此信息作为测试用。\r\n</p>','article.state.normal','普通','visible.true','显示',0,'2012-12-16 09:56:02','admin','管理员','/geneon/attached/appCar/20121216/20121216095626_937.png');

/*Table structure for table `web_content` */

DROP TABLE IF EXISTS `web_content`;

CREATE TABLE `web_content` (
  `id` varchar(100) NOT NULL,
  `name` varchar(100) default NULL,
  `english` varchar(100) default NULL,
  `path` varchar(200) default NULL,
  `parentId` varchar(100) default NULL,
  `sort` int(11) NOT NULL auto_increment,
  `hasShow` varchar(100) default NULL,
  `hasShowName` varchar(100) default NULL,
  `mode` varchar(100) default 'content.mode.one',
  `modeName` varchar(100) default '单一',
  PRIMARY KEY  (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `web_content` */

insert  into `web_content`(`id`,`name`,`english`,`path`,`parentId`,`sort`,`hasShow`,`hasShowName`,`mode`,`modeName`) values ('geneon','志昂生物','zhi ang','',NULL,432,'visible.true','显示','content.mode.none','空项'),('geneon.home','首页','Home','index.jsp','geneon',433,'visible.true','显示','content.mode.none','空项'),('geneon.about','公司简介','About','','geneon',434,'visible.true','显示','content.mode.one','单项'),('geneon.product','产品展示','Product','product.jsp','geneon',435,'visible.false','显示','content.mode.more','多项'),('geneon.new','新闻中心','New','','geneon',436,'visible.true','显示','content.mode.more','多项'),('geneon.technology','技术中心','Technology','','geneon',437,'visible.true','显示','content.mode.more','多项'),('geneonproduct','志昂产品','ZhiAng Product','',NULL,444,'visible.true','显示','content.mode.none','空项'),('geneonproduct.chanpin1','磁珠法核酸提取产品','Chan Pin 1','','geneonproduct',445,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin2','磁珠法蛋白提取产品','Chan Pin 2','','geneonproduct',446,'visible.true','显示','content.mode.more','多项'),('geneon.reserve','订购中心','Reserve','','geneon',447,'visible.true','显示','content.mode.more','多项'),('geneon.speak','留言板','Speak','message.jsp','geneon',448,'visible.true','显示','content.mode.none','空项'),('geneon.contact','联系我们','Contact','','geneon',449,'visible.true','显示','content.mode.one','单项'),('geneonproduct.chanpin3','技术服务','Chan Pin 3','','geneonproduct',450,'visible.true','显示','content.mode.none','空项'),('geneonproduct.chanpin1.chanpin11','血液DNA/RNA磁珠法提取产品','','product.jsp','geneonproduct.chanpin1',451,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin1.chanpin12','动物组织和培养细胞DNA/RNA磁珠法提取','','product.jsp','geneonproduct.chanpin1',452,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin1.chanpin13','植物DNA/RNA磁珠法提取产品','','product.jsp','geneonproduct.chanpin1',453,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin1.chanpin14','磁珠法DNA片段回收纯化产品','','product.jsp','geneonproduct.chanpin1',454,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin1.chanpin15','病毒DNA/RNA磁珠法提取产品','','product.jsp','geneonproduct.chanpin1',455,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin2.chanpin21','质谱样品制备用产品','','product.jsp','geneonproduct.chanpin2',456,'visible.true','显示','content.mode.more','多项'),('geneonproduct.chanpin3.chanpin31','核酸提取解决方案','','product.jsp','geneonproduct.chanpin3',457,'visible.true','显示','content.mode.more','多项'),('geneonhtml','管理代码','Dai Ma','',NULL,458,'visible.true','显示','content.mode.none','空项'),('geneonhtml.banner','广告位','Banner','','geneonhtml',459,'visible.true','显示','content.mode.one','单项'),('geneonhtml.contact','推荐解决方案','Cntact','','geneonhtml',460,'visible.true','显示','content.mode.one','单项'),('geneonhtml.contactme','联系我们','Contactme','','geneonhtml',461,'visible.true','显示','content.mode.one','单项'),('geneonhtml.foot','页尾','Foot','','geneonhtml',462,'visible.true','显示','content.mode.one','单项');

/*Table structure for table `web_message` */

DROP TABLE IF EXISTS `web_message`;

CREATE TABLE `web_message` (
  `id` int(11) NOT NULL auto_increment,
  `cid` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `stateName` varchar(100) default NULL,
  `hasShow` varchar(100) default NULL,
  `hasShowName` varchar(100) default NULL,
  `sendTime` datetime default NULL,
  `sendText` varchar(1000) default NULL,
  `sendEmail` varchar(100) default NULL,
  `sendPhone` varchar(100) default NULL,
  `sendName` varchar(100) default NULL,
  `receiveTime` varchar(100) default NULL,
  `receiveText` varchar(1000) default NULL,
  `receiveOperater` varchar(100) default NULL,
  `receiveOperaterName` varchar(100) default NULL,
  `type` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `web_message` */

insert  into `web_message`(`id`,`cid`,`state`,`stateName`,`hasShow`,`hasShowName`,`sendTime`,`sendText`,`sendEmail`,`sendPhone`,`sendName`,`receiveTime`,`receiveText`,`receiveOperater`,`receiveOperaterName`,`type`) values (1,'geneon','message.state.false','未回复','visible.true','显示','2012-12-15 11:17:07','磁珠法蛋白提取产品都有哪些特点和疗效呢？','zhangsan@sina.com','13022225555','张三','','','','','留言');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
