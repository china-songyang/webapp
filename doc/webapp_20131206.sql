/*
SQLyog Enterprise - MySQL GUI v6.0
Host - 5.0.37-community-nt : Database - webapp
*********************************************************************
Server version : 5.0.37-community-nt
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `webapp`;

USE `webapp`;

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

insert  into `app_dict`(`id`,`key`,`value`,`type`,`pinyin`) values (1,'article.state.normal','普通','article.state','putong'),(2,'article.state.recommand','推荐','article.state','tuijian'),(3,'article.state.top','置顶','article.state','zhiding'),(4,'ascii','ACSII码','regex','acsii'),(10,'boolean.false','否','boolean','fou'),(11,'boolean.true','是','boolean','shi'),(20,'chinese','中文','regex','zhengwen'),(24,'content.mode.more','多项','content.mode','duoxiang'),(25,'content.mode.none','空项','content.mode','kongxiang'),(26,'content.mode.one','单项','content.mode','danxiang'),(28,'decmal','浮点数','regex','fudianshu'),(29,'email','邮箱','regex','youxiang'),(39,'id','标识','regex','biaoshi'),(40,'idcard','身份证','regex','shenfenzheng'),(41,'integer','整数','regex','zhengshu'),(42,'letter','字母','regex','zimu'),(43,'loginId','登录标识','regex','denglubiaoshi'),(46,'node.condition.auth','权限','node.condition.model','qanxian'),(47,'node.condition.auth.department','组织机构','node.condition.auth','bumen'),(48,'node.condition.auth.role','角色','node.condition.auth','juese'),(49,'node.condition.auth.user','用户','node.condition.auth','yonghu'),(53,'notempty','非空','regex','feikong'),(54,'number','数字','regex','shuzi'),(55,'phone','手机电话','regex','shouji'),(56,'picture','图片','regex','tupian'),(57,'qq','QQ号','regex','qq'),(58,'rar','压缩文件','regex','yasuowenjian'),(59,'tel','座机电话','regex','zuoji'),(60,'url','URL','regex','url'),(61,'visible.false','隐藏','visible','yinchang'),(62,'visible.true','显示','visible','xianshi'),(63,'zipcode','邮编','regex','youbian'),(64,'只读','只读','node.state','zhidu'),(65,'必填','必填','node.state','bitian'),(66,'选填','选填','node.state','xuantian'),(67,'隐藏','隐藏','node.state','yincang'),(95,'女','女','gender','nv'),(96,'男','男','gender','nan'),(97,'是','是','easyboolean','shi'),(98,'否','否','easyboolean','fou'),(99,'message.state.false','未回复','message.state','weihuifu'),(100,'message.state.true','已回复','message.state','yihuifu'),(101,'1','普通','mobile.message.state','putong'),(102,'2','重要','mobile.message.state','zhongyao'),(103,'1','普通员工','user.level','putong'),(104,'2','领导','user.level','lingdao'),(105,'4','管理员','user.level','guanliyuan'),(106,'3','开发维护员','user.level','weihuyuan'),(107,'5','超级管理员','user.level','chaoji');

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

insert  into `app_resources`(`id`,`name`,`path`,`parentId`,`sort`) values ('auth','管理权限',NULL,NULL,1),('auth.user','管理用户','/app/auth/user/showUsers.jsp','auth',2),('auth.role','管理角色','/app/auth/role/showRoles.jsp','auth',3),('auth.resource','管理资源','/app/auth/resource/showResources.jsp','auth',4),('configuration','管理基础配置','',NULL,6),('configuration.dict','管理数据字典','/app/system/dict/showDicts.jsp','configuration',7),('website','管理网站','',NULL,8),('website.content','管理目录','/app/website/content/show.jsp','website',14),('website.article','管理文章','/app/website/article/show.jsp','website',32),('mobile','移动办公','',NULL,57),('website.message','管理留言','/app/website/message/show.jsp','website',103),('website.geneon','管理文章','/app/website/admin/main.jsp?cid=geneon','website',104),('website.geneonproduct','管理产品','/app/website/admin/main.jsp?cid=geneonproduct','website',105),('website.geneonhtml','管理代码','/app/website/admin/main.jsp?cid=geneonhtml','website',106),('auth.change.password','修改密码','/app/auth/user/changePassword.jsp',NULL,107),('mobile.meg','消息中心','/app/mobile/office/message/show.jsp','mobile',108),('mobile.meeting','会议管理','/app/mobile/office/meeting/show.jsp','mobile',109),('auth.organization','管理部门','/app/auth/organization/showOrganizations.jsp','auth',110),('mobile.apkfile','下载中心','/app/mobile/office/apkfile/show.jsp','mobile',111),('mobile.news','管理新闻','/app/website/admin/main.jsp?cid=webapp','mobile',112),('mobile.meetings','发布会议管理','/app/mobile/office/meeting/showMeeting.jsp','mobile',113);

/*Table structure for table `auth_organizations` */

DROP TABLE IF EXISTS `auth_organizations`;

CREATE TABLE `auth_organizations` (
  `id` int(100) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) default NULL,
  `responsible` varchar(50) default '否',
  `parentId` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_organizations` */

insert  into `auth_organizations`(`id`,`name`,`description`,`responsible`,`parentId`) values (4,'董事长','','否','3'),(5,'总经理','','是','3'),(6,'销售副总','','否','3'),(7,'售后副总','','否','3'),(8,'财务副总','','否','3'),(9,'人事副总','','否','3'),(10,'人事部','','否','3'),(11,'人事部长','','是','10'),(12,'人事部副部长','','否','10'),(13,'人事部助理','','否','10'),(14,'人事部成员','','否','10'),(15,'销售部','','否','3'),(16,'销售部长','','是','15'),(17,'长春市宽城区政府','','否',NULL),(18,'宣传科','','否','17'),(19,'领导班子','','否',NULL),(20,'IT部','','否','19');

/*Table structure for table `auth_re_organization_resource` */

DROP TABLE IF EXISTS `auth_re_organization_resource`;

CREATE TABLE `auth_re_organization_resource` (
  `organizationId` int(100) NOT NULL,
  `resourceId` varchar(100) NOT NULL,
  PRIMARY KEY  (`organizationId`,`resourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_organization_resource` */

/*Table structure for table `auth_re_organization_user` */

DROP TABLE IF EXISTS `auth_re_organization_user`;

CREATE TABLE `auth_re_organization_user` (
  `organizationId` int(100) NOT NULL,
  `userId` varchar(100) NOT NULL,
  PRIMARY KEY  (`organizationId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_organization_user` */

insert  into `auth_re_organization_user`(`organizationId`,`userId`) values (5,'admin'),(11,'zhangsan'),(12,'admin'),(16,'lisi'),(18,'liyang'),(18,'songyang'),(18,'yangshuangjia'),(18,'yonghu'),(20,'admin'),(20,'yonghu'),(20,'zhaoxy');

/*Table structure for table `auth_re_role_resource` */

DROP TABLE IF EXISTS `auth_re_role_resource`;

CREATE TABLE `auth_re_role_resource` (
  `roleId` int(100) NOT NULL,
  `resourceId` varchar(100) character set gb2312 NOT NULL default '',
  PRIMARY KEY  (`roleId`,`resourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_role_resource` */

insert  into `auth_re_role_resource`(`roleId`,`resourceId`) values (1,'auth.change.password'),(1,'website'),(1,'website.content'),(1,'website.geneon'),(1,'website.geneonproduct'),(1,'website.message'),(5,'auth'),(5,'auth.change.password'),(5,'auth.organization'),(5,'auth.resource'),(5,'auth.role'),(5,'auth.user'),(5,'configuration'),(5,'configuration.dict'),(5,'website'),(5,'website.content');

/*Table structure for table `auth_re_user_resource` */

DROP TABLE IF EXISTS `auth_re_user_resource`;

CREATE TABLE `auth_re_user_resource` (
  `userId` varchar(100) NOT NULL,
  `resourceId` varchar(100) NOT NULL,
  PRIMARY KEY  (`userId`,`resourceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_user_resource` */

insert  into `auth_re_user_resource`(`userId`,`resourceId`) values ('admin','auth'),('admin','auth.change.password'),('admin','auth.organization'),('admin','auth.resource'),('admin','auth.role'),('admin','auth.user'),('admin','configuration'),('admin','configuration.dict'),('admin','mobile'),('admin','mobile.meeting'),('admin','mobile.meg'),('admin','website'),('admin','website.article'),('admin','website.content'),('admin','website.geneon'),('admin','website.geneonhtml'),('admin','website.geneonproduct'),('admin','website.message'),('system','auth'),('system','auth.change.password'),('system','auth.organization'),('system','auth.resource'),('system','auth.role'),('system','auth.user'),('system','configuration'),('system','configuration.dict'),('system','mobile'),('system','mobile.apkfile'),('system','mobile.meeting'),('system','mobile.meetings'),('system','mobile.meg'),('system','mobile.news'),('yangshuangjia','auth'),('yangshuangjia','auth.change.password'),('yangshuangjia','auth.organization'),('yangshuangjia','auth.resource'),('yangshuangjia','auth.role'),('yangshuangjia','auth.user'),('yangshuangjia','configuration'),('yangshuangjia','configuration.dict'),('yangshuangjia','mobile'),('yangshuangjia','mobile.apkfile'),('yangshuangjia','mobile.meetings'),('yangshuangjia','mobile.meg'),('yangshuangjia','mobile.news'),('yangshuangjia','website');

/*Table structure for table `auth_re_user_role` */

DROP TABLE IF EXISTS `auth_re_user_role`;

CREATE TABLE `auth_re_user_role` (
  `userId` varchar(100) character set gb2312 NOT NULL,
  `roleId` int(100) NOT NULL,
  PRIMARY KEY  (`userId`,`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_re_user_role` */

insert  into `auth_re_user_role`(`userId`,`roleId`) values ('system',5);

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
  `level` varchar(100) default NULL,
  `tel` varchar(100) default NULL,
  `post` varchar(100) default NULL,
  `point` varchar(100) default NULL,
  `fax` varchar(100) default NULL,
  PRIMARY KEY  (`Id`),
  UNIQUE KEY `id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_users` */

insert  into `auth_users`(`Id`,`name`,`password`,`email`,`phone`,`level`,`tel`,`post`,`point`,`fax`) values ('admin','管理员','57776e0d16954c2b839f963c9cb0bc71',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('liyang','李洋','57776e0d16954c2b839f963c9cb0bc71','liyang@cc.com','13812345678','5','043188884444','项目经理','6',''),('system','开发维护员','57776e0d16954c2b839f963c9cb0bc71','130545111@qq.com','13174455805','5','','','',''),('yangshuangjia','杨霜佳','57776e0d16954c2b839f963c9cb0bc71','ysj@qq.com','13877778888','2','0431-89009009','主任','','0431-89009009'),('yonghu','测试用户','57776e0d16954c2b839f963c9cb0bc71','yonghu@qq.com','','2','','','4',''),('zhangna','娜姐','57776e0d16954c2b839f963c9cb0bc71','zn@yahoo.cn','13845553666','3','','','',''),('zhaoxy','赵宇','57776e0d16954c2b839f963c9cb0bc71','zxy@cc.cn','18611118888','5','043155558888','组长','5','');

/*Table structure for table `met_re_user` */

DROP TABLE IF EXISTS `met_re_user`;

CREATE TABLE `met_re_user` (
  `userId` varchar(50) default NULL,
  `metId` varchar(50) default NULL,
  `sendTime` varchar(100) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `met_re_user` */

insert  into `met_re_user`(`userId`,`metId`,`sendTime`) values ('yangshuangjia','12','2013-08-14 00:04:55'),('yonghu','12','2013-08-15 14:53:30'),('ceshi','13','2013-08-15 14:55:30'),('liyang','15','1378219930204'),('liyang','16','1378219954937'),('yangshuangjia','16','1378219954937'),('yangshuangjia','15','2013-09-03 22:53:05'),('liyang','17','1378687746029'),('yangshuangjia','17','1378687746029'),('liyang','18','1378687781818'),('liyang','19','1378688288663'),('yangshuangjia','19','1378688288663'),('liyang','20','1378690315613'),('liyang','21','1378690522631');

/*Table structure for table `mobile_base` */

DROP TABLE IF EXISTS `mobile_base`;

CREATE TABLE `mobile_base` (
  `id` int(20) NOT NULL auto_increment,
  `command` varchar(50) default NULL,
  `platformType` varchar(100) default NULL,
  `deviceId` varchar(100) default NULL,
  `osVersion` varchar(100) default NULL,
  `mobileType` varchar(100) default NULL,
  `softVersion` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mobile_base` */

insert  into `mobile_base`(`id`,`command`,`platformType`,`deviceId`,`osVersion`,`mobileType`,`softVersion`) values (1,'6001','android','355031','4.1.2','LG','3'),(2,'6001','android','355031050644919','4.1.2','LG-F240K','2'),(3,'6001','android','358882044481249','4.1.2','GT-I9220','3'),(4,'6001','android','355105050188513','4.1.1','HTC 603e','2'),(5,'6001','android','862726012063407','2.3.6','ZTE V889D','2'),(6,'6001','android','000000000000000','2.3.3','sdk','2'),(7,'6001','android','353867052286445','4.1.2','GT-N7102','2'),(8,'6001','android','353701042433579','2.3.6','SHW-M130K','2'),(9,'6001','android','355065058980966','4.0.4','GT-I9308','2'),(10,'6001','android','861462010141661','4.2.1','Newman K1','3'),(11,'6001','android','860806027828671','4.1.1','M040','2'),(12,'6001','android','869421017047661','4.1.1','X909','2'),(13,'6001','android','358071041115774','2.3.5','HTC Rhyme S510b','2'),(14,'6001','android','868652013339105','4.0.4','AMOI N821','2'),(15,'6001','android','352993053278016','4.1.1','GT-I9300','3');

/*Table structure for table `mobile_meeting` */

DROP TABLE IF EXISTS `mobile_meeting`;

CREATE TABLE `mobile_meeting` (
  `id` int(10) NOT NULL auto_increment,
  `userId` varchar(50) default NULL,
  `title` varchar(100) default NULL,
  `time` varchar(100) default NULL,
  `address` varchar(200) default NULL,
  `unit` varchar(300) default NULL,
  `text` varchar(3000) default NULL,
  `createTime` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `stateName` varchar(50) default NULL,
  `point` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mobile_meeting` */

insert  into `mobile_meeting`(`id`,`userId`,`title`,`time`,`address`,`unit`,`text`,`createTime`,`state`,`stateName`,`point`) values (12,'admin','开会啦开会啦','2013年8月10日下午3点','宽城区政府2楼会议室','宽城区政府办公室','研讨政府机关下发信息化建设方案实施','2013-08-10 10:00:00','visible.true','显示',NULL),(13,'宋阳','测试偶','2013年8月20日上午8点','长春宽城区政府','宽城区政府办','测试内容哦','2013-08-15 14:54:25','visible.true','显示',NULL),(15,'liyang','啊啊啊','吧','得得','啊啊啊','啊啊啊啊啊','1378219930204','visible.true','显示',NULL),(16,'yangshuangjia','3号手机测试发布','4号上午10点','会议室','研发部','测试手机发布通知','1378219954937','visible.true','显示',NULL),(17,'yangshuangjia','8号手机测试发布','10号','北京','研发部','测试版我国','1378687746029','visible.true','显示',NULL),(18,'liyang','啦啦啦','呃呃呃','哈哈哈','兔兔','我一直','1378687781818','visible.true','显示',NULL),(19,'yangshuangjia','9号手机测试','上海会议室','上海','北京','测试手机测试','1378688288663','visible.true','显示',NULL),(20,'liyang','啊啊啊','呃呃呃','哈哈哈哈','哦哦哦','收拾收拾','1378690315613','visible.true','显示',NULL),(21,'liyang','啊啊啊','啊啊啊','啊','啊啊啊','哦哦哦','1378690522631','visible.true','显示',NULL);

/*Table structure for table `mobile_message` */

DROP TABLE IF EXISTS `mobile_message`;

CREATE TABLE `mobile_message` (
  `id` int(10) NOT NULL auto_increment,
  `title` varchar(2000) default NULL,
  `text` varchar(3000) default NULL,
  `state` varchar(45) default NULL,
  `statename` varchar(45) default NULL,
  `createtime` varchar(45) default NULL,
  `creater` varchar(45) default NULL,
  `creatername` varchar(45) default NULL,
  `levelname` varchar(45) default NULL,
  `level` varchar(45) default NULL,
  `type` varchar(45) default NULL,
  `point` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mobile_message` */

insert  into `mobile_message`(`id`,`title`,`text`,`state`,`statename`,`createtime`,`creater`,`creatername`,`levelname`,`level`,`type`,`point`) values (15,'长春市政府红头文件下发','长春市政府要求各个地区各个机关单位积极配合','visible.true','显示','2013-07-09 20:08:57','system','开发维护员','普通','1','2','1'),(16,'联通混战','为什么联通用户为联通内部管理买单','visible.true','显示','2013-07-09 20:09:54','system','开发维护员','普通','1','2','2'),(18,'测试数据第一条','测试数据第一条','visible.true','显示','2013-07-28 23:33:53','yangshuangjia','杨霜佳','普通','2','1','1'),(19,'第二条测试数据','注意啦，这是第二条测试数据','visible.true','显示','2013-07-28 23:27:26','yangshuangjia','杨霜佳','重要','2','1','2'),(20,'测试数据第三条','测试数据第三条','visible.true','显示','2013-12-01 20:00:53','yangshuangjia','杨霜佳','普通','','1','3'),(21,'11.4日测试','测试内容如下','visible.true','显示','2013-11-04 21:39:24','yangshuangjia','杨霜佳','普通','1','1','4'),(22,'测试时测试杨','测试时测试杨aaaa<br />','visible.true','显示','2013-12-01 19:59:27','yangshuangjia','杨霜佳','普通','2','1','5');

/*Table structure for table `msg_re_user` */

DROP TABLE IF EXISTS `msg_re_user`;

CREATE TABLE `msg_re_user` (
  `userId` varchar(100) default NULL,
  `msgId` varchar(100) default NULL,
  `msgType` varchar(100) default NULL,
  `sendTime` varchar(100) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `msg_re_user` */

insert  into `msg_re_user`(`userId`,`msgId`,`msgType`,`sendTime`) values ('yangshuangjia','3','1','2013-07-04 16:32:56'),('yangshuangjia','6','1','2013-07-04 16:44:06'),('yangshuangjia','5','1','2013-07-04 16:44:17'),('yangshuangjia','16','2','2013-07-09 20:11:36'),('yangshuangjia','15','2','2013-07-09 20:13:55'),('yangshuangjia','19','1','2013-07-28 23:30:23'),('yangshuangjia','20','1','2013-07-28 23:32:03'),('yangshuangjia','18','1','2013-07-28 23:32:11'),('yonghu','20','1','2013-10-31 21:42:06'),('admin','18','1','2013-11-04 10:06:24'),('zhaoxy','21','1','2013-11-04 21:40:01'),('yangshuangjia','21','1','2013-11-04 21:40:01'),('admin','22','1','2013-11-04 22:02:57'),('system','22','1','2013-11-04 22:02:57'),('yangshuangjia','22','1','2013-11-04 22:02:57'),('zhaoxy','22','1','2013-11-04 22:12:36'),('zhangna','22','1','2013-11-04 22:12:36'),('yonghu','22','1','2013-11-04 22:12:36'),('liyang','22','1','2013-11-04 22:12:36');

/*Table structure for table `ofextcomponentconf` */

DROP TABLE IF EXISTS `ofextcomponentconf`;

CREATE TABLE `ofextcomponentconf` (
  `subdomain` varchar(255) NOT NULL,
  `wildcard` tinyint(4) NOT NULL,
  `secret` varchar(255) default NULL,
  `permission` varchar(10) NOT NULL,
  PRIMARY KEY  (`subdomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofextcomponentconf` */

/*Table structure for table `ofgroup` */

DROP TABLE IF EXISTS `ofgroup`;

CREATE TABLE `ofgroup` (
  `groupName` varchar(50) NOT NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`groupName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofgroup` */

/*Table structure for table `ofgroupprop` */

DROP TABLE IF EXISTS `ofgroupprop`;

CREATE TABLE `ofgroupprop` (
  `groupName` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY  (`groupName`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofgroupprop` */

/*Table structure for table `ofgroupuser` */

DROP TABLE IF EXISTS `ofgroupuser`;

CREATE TABLE `ofgroupuser` (
  `groupName` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `administrator` tinyint(4) NOT NULL,
  PRIMARY KEY  (`groupName`,`username`,`administrator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofgroupuser` */

/*Table structure for table `ofid` */

DROP TABLE IF EXISTS `ofid`;

CREATE TABLE `ofid` (
  `idType` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  PRIMARY KEY  (`idType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofid` */

insert  into `ofid`(`idType`,`id`) values (18,6),(19,1),(23,1),(26,2);

/*Table structure for table `ofmucaffiliation` */

DROP TABLE IF EXISTS `ofmucaffiliation`;

CREATE TABLE `ofmucaffiliation` (
  `roomID` bigint(20) NOT NULL,
  `jid` text NOT NULL,
  `affiliation` tinyint(4) NOT NULL,
  PRIMARY KEY  (`roomID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucaffiliation` */

/*Table structure for table `ofmucconversationlog` */

DROP TABLE IF EXISTS `ofmucconversationlog`;

CREATE TABLE `ofmucconversationlog` (
  `roomID` bigint(20) NOT NULL,
  `sender` text NOT NULL,
  `nickname` varchar(255) default NULL,
  `logTime` char(15) NOT NULL,
  `subject` varchar(255) default NULL,
  `body` text,
  KEY `ofMucConversationLog_time_idx` (`logTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucconversationlog` */

/*Table structure for table `ofmucmember` */

DROP TABLE IF EXISTS `ofmucmember`;

CREATE TABLE `ofmucmember` (
  `roomID` bigint(20) NOT NULL,
  `jid` text NOT NULL,
  `nickname` varchar(255) default NULL,
  `firstName` varchar(100) default NULL,
  `lastName` varchar(100) default NULL,
  `url` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `faqentry` varchar(100) default NULL,
  PRIMARY KEY  (`roomID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucmember` */

/*Table structure for table `ofmucroom` */

DROP TABLE IF EXISTS `ofmucroom`;

CREATE TABLE `ofmucroom` (
  `serviceID` bigint(20) NOT NULL,
  `roomID` bigint(20) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `naturalName` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `lockedDate` char(15) NOT NULL,
  `emptyDate` char(15) default NULL,
  `canChangeSubject` tinyint(4) NOT NULL,
  `maxUsers` int(11) NOT NULL,
  `publicRoom` tinyint(4) NOT NULL,
  `moderated` tinyint(4) NOT NULL,
  `membersOnly` tinyint(4) NOT NULL,
  `canInvite` tinyint(4) NOT NULL,
  `roomPassword` varchar(50) default NULL,
  `canDiscoverJID` tinyint(4) NOT NULL,
  `logEnabled` tinyint(4) NOT NULL,
  `subject` varchar(100) default NULL,
  `rolesToBroadcast` tinyint(4) NOT NULL,
  `useReservedNick` tinyint(4) NOT NULL,
  `canChangeNick` tinyint(4) NOT NULL,
  `canRegister` tinyint(4) NOT NULL,
  PRIMARY KEY  (`serviceID`,`name`),
  KEY `ofMucRoom_roomid_idx` (`roomID`),
  KEY `ofMucRoom_serviceid_idx` (`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucroom` */

/*Table structure for table `ofmucroomprop` */

DROP TABLE IF EXISTS `ofmucroomprop`;

CREATE TABLE `ofmucroomprop` (
  `roomID` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY  (`roomID`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucroomprop` */

/*Table structure for table `ofmucservice` */

DROP TABLE IF EXISTS `ofmucservice`;

CREATE TABLE `ofmucservice` (
  `serviceID` bigint(20) NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `isHidden` tinyint(4) NOT NULL,
  PRIMARY KEY  (`subdomain`),
  KEY `ofMucService_serviceid_idx` (`serviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucservice` */

insert  into `ofmucservice`(`serviceID`,`subdomain`,`description`,`isHidden`) values (1,'conference',NULL,0);

/*Table structure for table `ofmucserviceprop` */

DROP TABLE IF EXISTS `ofmucserviceprop`;

CREATE TABLE `ofmucserviceprop` (
  `serviceID` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY  (`serviceID`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofmucserviceprop` */

/*Table structure for table `ofoffline` */

DROP TABLE IF EXISTS `ofoffline`;

CREATE TABLE `ofoffline` (
  `username` varchar(64) NOT NULL,
  `messageID` bigint(20) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `messageSize` int(11) NOT NULL,
  `stanza` text NOT NULL,
  PRIMARY KEY  (`username`,`messageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofoffline` */

/*Table structure for table `ofpresence` */

DROP TABLE IF EXISTS `ofpresence`;

CREATE TABLE `ofpresence` (
  `username` varchar(64) NOT NULL,
  `offlinePresence` text,
  `offlineDate` char(15) NOT NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpresence` */

insert  into `ofpresence`(`username`,`offlinePresence`,`offlineDate`) values ('liyang',NULL,'001379389312673'),('system',NULL,'001379396426105');

/*Table structure for table `ofprivacylist` */

DROP TABLE IF EXISTS `ofprivacylist`;

CREATE TABLE `ofprivacylist` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `isDefault` tinyint(4) NOT NULL,
  `list` text NOT NULL,
  PRIMARY KEY  (`username`,`name`),
  KEY `ofPrivacyList_default_idx` (`username`,`isDefault`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofprivacylist` */

/*Table structure for table `ofprivate` */

DROP TABLE IF EXISTS `ofprivate`;

CREATE TABLE `ofprivate` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `namespace` varchar(200) NOT NULL,
  `privateData` text NOT NULL,
  PRIMARY KEY  (`username`,`name`,`namespace`(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofprivate` */

/*Table structure for table `ofproperty` */

DROP TABLE IF EXISTS `ofproperty`;

CREATE TABLE `ofproperty` (
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofproperty` */

insert  into `ofproperty`(`name`,`propValue`) values ('admin.authorizedJIDs','admin@127.0.0.1'),('cache.KrakenRegistrationCache.maxLifetime','-1'),('cache.KrakenRegistrationCache.min','-1'),('cache.KrakenRegistrationCache.size','-1'),('cache.KrakenRegistrationCache.type','optimistic'),('cache.KrakenSessionLocationCache.maxLifetime','-1'),('cache.KrakenSessionLocationCache.min','-1'),('cache.KrakenSessionLocationCache.size','-1'),('cache.KrakenSessionLocationCache.type','optimistic'),('fastpath.database.setup','true'),('jdbcAuthProvider.passwordSQL','select password from auth_users where id = ?'),('jdbcAuthProvider.passwordType','md5'),('jdbcAuthProvider.useConnectionProvider','true'),('jdbcProvider.connectionString','jdbc:db2://localhost:3306/webapp?user=root&password=mobile@123'),('jdbcProvider.driver','com.mysql.jdbc.Driver'),('jdbcUserProvider.allUsersSQL','select id  from auth_users'),('jdbcUserProvider.emailField','EMAIL'),('jdbcUserProvider.loadUserSQL','SELECT name,email  FROM auth_users WHERE  id= ?'),('jdbcUserProvider.nameField','name'),('jdbcUserProvider.searchSQL','select NAME from auth_users  where id=?'),('jdbcUserProvider.useConnectionProvider','true'),('jdbcUserProvider.userCountSQL','SELECT COUNT(*) FROM auth_users'),('jdbcUserProvider.usernameField','id'),('passwordKey','LLBHQBySA4y0ifx'),('provider.admin.className','org.jivesoftware.openfire.admin.DefaultAdminProvider'),('provider.auth.className','org.jivesoftware.openfire.auth.JDBCAuthProvider'),('provider.group.className','org.jivesoftware.openfire.group.JDBCGroupProvider'),('provider.lockout.className','org.jivesoftware.openfire.lockout.DefaultLockOutProvider'),('provider.securityAudit.className','org.jivesoftware.openfire.security.DefaultSecurityAuditProvider'),('provider.user.className','org.jivesoftware.openfire.user.JDBCUserProvider'),('provider.vcard.className','org.jivesoftware.openfire.vcard.DefaultVCardProvider'),('update.lastCheck','1386164238060'),('xmpp.auth.anonymous','true'),('xmpp.domain','127.0.0.1'),('xmpp.offline.type','store_and_bounce'),('xmpp.session.conflict-limit','0'),('xmpp.socket.ssl.active','true');

/*Table structure for table `ofpubsubaffiliation` */

DROP TABLE IF EXISTS `ofpubsubaffiliation`;

CREATE TABLE `ofpubsubaffiliation` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `affiliation` varchar(10) NOT NULL,
  PRIMARY KEY  (`serviceID`,`nodeID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubaffiliation` */

insert  into `ofpubsubaffiliation`(`serviceID`,`nodeID`,`jid`,`affiliation`) values ('pubsub','','127.0.0.1','owner');

/*Table structure for table `ofpubsubdefaultconf` */

DROP TABLE IF EXISTS `ofpubsubdefaultconf`;

CREATE TABLE `ofpubsubdefaultconf` (
  `serviceID` varchar(100) NOT NULL,
  `leaf` tinyint(4) NOT NULL,
  `deliverPayloads` tinyint(4) NOT NULL,
  `maxPayloadSize` int(11) NOT NULL,
  `persistItems` tinyint(4) NOT NULL,
  `maxItems` int(11) NOT NULL,
  `notifyConfigChanges` tinyint(4) NOT NULL,
  `notifyDelete` tinyint(4) NOT NULL,
  `notifyRetract` tinyint(4) NOT NULL,
  `presenceBased` tinyint(4) NOT NULL,
  `sendItemSubscribe` tinyint(4) NOT NULL,
  `publisherModel` varchar(15) NOT NULL,
  `subscriptionEnabled` tinyint(4) NOT NULL,
  `accessModel` varchar(10) NOT NULL,
  `language` varchar(255) default NULL,
  `replyPolicy` varchar(15) default NULL,
  `associationPolicy` varchar(15) NOT NULL,
  `maxLeafNodes` int(11) NOT NULL,
  PRIMARY KEY  (`serviceID`,`leaf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubdefaultconf` */

insert  into `ofpubsubdefaultconf`(`serviceID`,`leaf`,`deliverPayloads`,`maxPayloadSize`,`persistItems`,`maxItems`,`notifyConfigChanges`,`notifyDelete`,`notifyRetract`,`presenceBased`,`sendItemSubscribe`,`publisherModel`,`subscriptionEnabled`,`accessModel`,`language`,`replyPolicy`,`associationPolicy`,`maxLeafNodes`) values ('pubsub',0,0,0,0,0,1,1,1,0,0,'publishers',1,'open','English',NULL,'all',-1),('pubsub',1,1,5120,0,-1,1,1,1,0,1,'publishers',1,'open','English',NULL,'all',-1);

/*Table structure for table `ofpubsubitem` */

DROP TABLE IF EXISTS `ofpubsubitem`;

CREATE TABLE `ofpubsubitem` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `payload` mediumtext,
  PRIMARY KEY  (`serviceID`,`nodeID`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubitem` */

/*Table structure for table `ofpubsubnode` */

DROP TABLE IF EXISTS `ofpubsubnode`;

CREATE TABLE `ofpubsubnode` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `leaf` tinyint(4) NOT NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  `parent` varchar(100) default NULL,
  `deliverPayloads` tinyint(4) NOT NULL,
  `maxPayloadSize` int(11) default NULL,
  `persistItems` tinyint(4) default NULL,
  `maxItems` int(11) default NULL,
  `notifyConfigChanges` tinyint(4) NOT NULL,
  `notifyDelete` tinyint(4) NOT NULL,
  `notifyRetract` tinyint(4) NOT NULL,
  `presenceBased` tinyint(4) NOT NULL,
  `sendItemSubscribe` tinyint(4) NOT NULL,
  `publisherModel` varchar(15) NOT NULL,
  `subscriptionEnabled` tinyint(4) NOT NULL,
  `configSubscription` tinyint(4) NOT NULL,
  `accessModel` varchar(10) NOT NULL,
  `payloadType` varchar(100) default NULL,
  `bodyXSLT` varchar(100) default NULL,
  `dataformXSLT` varchar(100) default NULL,
  `creator` varchar(255) NOT NULL,
  `description` varchar(255) default NULL,
  `language` varchar(255) default NULL,
  `name` varchar(50) default NULL,
  `replyPolicy` varchar(15) default NULL,
  `associationPolicy` varchar(15) default NULL,
  `maxLeafNodes` int(11) default NULL,
  PRIMARY KEY  (`serviceID`,`nodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubnode` */

insert  into `ofpubsubnode`(`serviceID`,`nodeID`,`leaf`,`creationDate`,`modificationDate`,`parent`,`deliverPayloads`,`maxPayloadSize`,`persistItems`,`maxItems`,`notifyConfigChanges`,`notifyDelete`,`notifyRetract`,`presenceBased`,`sendItemSubscribe`,`publisherModel`,`subscriptionEnabled`,`configSubscription`,`accessModel`,`payloadType`,`bodyXSLT`,`dataformXSLT`,`creator`,`description`,`language`,`name`,`replyPolicy`,`associationPolicy`,`maxLeafNodes`) values ('pubsub','',0,'001379388425947','001379388425947',NULL,0,0,0,0,1,1,1,0,0,'publishers',1,0,'open','','','','127.0.0.1','','English','',NULL,'all',-1);

/*Table structure for table `ofpubsubnodegroups` */

DROP TABLE IF EXISTS `ofpubsubnodegroups`;

CREATE TABLE `ofpubsubnodegroups` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `rosterGroup` varchar(100) NOT NULL,
  KEY `ofPubsubNodeGroups_idx` (`serviceID`,`nodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubnodegroups` */

/*Table structure for table `ofpubsubnodejids` */

DROP TABLE IF EXISTS `ofpubsubnodejids`;

CREATE TABLE `ofpubsubnodejids` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `associationType` varchar(20) NOT NULL,
  PRIMARY KEY  (`serviceID`,`nodeID`,`jid`(70))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubnodejids` */

/*Table structure for table `ofpubsubsubscription` */

DROP TABLE IF EXISTS `ofpubsubsubscription`;

CREATE TABLE `ofpubsubsubscription` (
  `serviceID` varchar(100) NOT NULL,
  `nodeID` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `jid` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `state` varchar(15) NOT NULL,
  `deliver` tinyint(4) NOT NULL,
  `digest` tinyint(4) NOT NULL,
  `digest_frequency` int(11) NOT NULL,
  `expire` char(15) default NULL,
  `includeBody` tinyint(4) NOT NULL,
  `showValues` varchar(30) default NULL,
  `subscriptionType` varchar(10) NOT NULL,
  `subscriptionDepth` tinyint(4) NOT NULL,
  `keyword` varchar(200) default NULL,
  PRIMARY KEY  (`serviceID`,`nodeID`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofpubsubsubscription` */

/*Table structure for table `ofremoteserverconf` */

DROP TABLE IF EXISTS `ofremoteserverconf`;

CREATE TABLE `ofremoteserverconf` (
  `xmppDomain` varchar(255) NOT NULL,
  `remotePort` int(11) default NULL,
  `permission` varchar(10) NOT NULL,
  PRIMARY KEY  (`xmppDomain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofremoteserverconf` */

/*Table structure for table `ofroster` */

DROP TABLE IF EXISTS `ofroster`;

CREATE TABLE `ofroster` (
  `rosterID` bigint(20) NOT NULL,
  `username` varchar(64) NOT NULL,
  `jid` varchar(1024) NOT NULL,
  `sub` tinyint(4) NOT NULL,
  `ask` tinyint(4) NOT NULL,
  `recv` tinyint(4) NOT NULL,
  `nick` varchar(255) default NULL,
  PRIMARY KEY  (`rosterID`),
  KEY `ofRoster_unameid_idx` (`username`),
  KEY `ofRoster_jid_idx` (`jid`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofroster` */

insert  into `ofroster`(`rosterID`,`username`,`jid`,`sub`,`ask`,`recv`,`nick`) values (1,'system','admin@127.0.0.1',1,-1,-1,'管理员'),(2,'admin','system@127.0.0.1',2,-1,-1,NULL);

/*Table structure for table `ofrostergroups` */

DROP TABLE IF EXISTS `ofrostergroups`;

CREATE TABLE `ofrostergroups` (
  `rosterID` bigint(20) NOT NULL,
  `rank` tinyint(4) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  PRIMARY KEY  (`rosterID`,`rank`),
  KEY `ofRosterGroup_rosterid_idx` (`rosterID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofrostergroups` */

insert  into `ofrostergroups`(`rosterID`,`rank`,`groupName`) values (1,0,'Friends');

/*Table structure for table `ofsaslauthorized` */

DROP TABLE IF EXISTS `ofsaslauthorized`;

CREATE TABLE `ofsaslauthorized` (
  `username` varchar(64) NOT NULL,
  `principal` text NOT NULL,
  PRIMARY KEY  (`username`,`principal`(200))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofsaslauthorized` */

/*Table structure for table `ofsecurityauditlog` */

DROP TABLE IF EXISTS `ofsecurityauditlog`;

CREATE TABLE `ofsecurityauditlog` (
  `msgID` bigint(20) NOT NULL,
  `username` varchar(64) NOT NULL,
  `entryStamp` bigint(20) NOT NULL,
  `summary` varchar(255) NOT NULL,
  `node` varchar(255) NOT NULL,
  `details` text,
  PRIMARY KEY  (`msgID`),
  KEY `ofSecurityAuditLog_tstamp_idx` (`entryStamp`),
  KEY `ofSecurityAuditLog_uname_idx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofsecurityauditlog` */

/*Table structure for table `ofuser` */

DROP TABLE IF EXISTS `ofuser`;

CREATE TABLE `ofuser` (
  `username` varchar(64) NOT NULL,
  `plainPassword` varchar(32) default NULL,
  `encryptedPassword` varchar(255) default NULL,
  `name` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `creationDate` char(15) NOT NULL,
  `modificationDate` char(15) NOT NULL,
  PRIMARY KEY  (`username`),
  KEY `ofUser_cDate_idx` (`creationDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofuser` */

insert  into `ofuser`(`username`,`plainPassword`,`encryptedPassword`,`name`,`email`,`creationDate`,`modificationDate`) values ('admin',NULL,'1d578b437c5e8de60efd63c252ccdffb6e59293e7ac8d145','Administrator','admin@example.com','001379388405369','0');

/*Table structure for table `ofuserflag` */

DROP TABLE IF EXISTS `ofuserflag`;

CREATE TABLE `ofuserflag` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `startTime` char(15) default NULL,
  `endTime` char(15) default NULL,
  PRIMARY KEY  (`username`,`name`),
  KEY `ofUserFlag_sTime_idx` (`startTime`),
  KEY `ofUserFlag_eTime_idx` (`endTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofuserflag` */

/*Table structure for table `ofuserprop` */

DROP TABLE IF EXISTS `ofuserprop`;

CREATE TABLE `ofuserprop` (
  `username` varchar(64) NOT NULL,
  `name` varchar(100) NOT NULL,
  `propValue` text NOT NULL,
  PRIMARY KEY  (`username`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofuserprop` */

/*Table structure for table `ofvcard` */

DROP TABLE IF EXISTS `ofvcard`;

CREATE TABLE `ofvcard` (
  `username` varchar(64) NOT NULL,
  `vcard` mediumtext NOT NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofvcard` */

/*Table structure for table `ofversion` */

DROP TABLE IF EXISTS `ofversion`;

CREATE TABLE `ofversion` (
  `name` varchar(50) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ofversion` */

insert  into `ofversion`(`name`,`version`) values ('openfire',21);

/*Table structure for table `user_re_meeting` */

DROP TABLE IF EXISTS `user_re_meeting`;

CREATE TABLE `user_re_meeting` (
  `meetingId` varchar(20) default NULL,
  `userPoint` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_re_meeting` */

insert  into `user_re_meeting`(`meetingId`,`userPoint`) values ('9','1'),('9','2'),('9','3');

/*Table structure for table `web_apkfile` */

DROP TABLE IF EXISTS `web_apkfile`;

CREATE TABLE `web_apkfile` (
  `id` int(100) NOT NULL auto_increment,
  `title` varchar(200) default NULL,
  `apkfile` varchar(500) default NULL,
  `createTime` datetime default NULL,
  `operater` varchar(100) default NULL,
  `operaterName` varchar(100) default NULL,
  `softVersion` varchar(100) default NULL,
  `content` varchar(500) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `web_apkfile` */

insert  into `web_apkfile`(`id`,`title`,`apkfile`,`createTime`,`operater`,`operaterName`,`softVersion`,`content`) values (7,'宽城移动办公','/webapp/attached/file/20130909/20130909090806_299.apk','2013-09-09 09:00:49','yangshuangjia','杨霜佳','3','宽城移动办公测试第二版');

/*Table structure for table `web_article` */

DROP TABLE IF EXISTS `web_article`;

CREATE TABLE `web_article` (
  `id` int(100) NOT NULL auto_increment,
  `cid` varchar(100) default NULL,
  `title` varchar(1000) default NULL,
  `text` mediumtext,
  `type` varchar(100) default NULL,
  `typeName` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `stateName` varchar(100) default NULL,
  `count` int(11) default '0',
  `createTime` datetime default NULL,
  `operater` varchar(100) default NULL,
  `operaterName` varchar(100) default NULL,
  `image` varchar(500) default NULL,
  `summary` mediumtext,
  `point` int(100) default NULL,
  `author` varchar(500) default NULL,
  `imageUrl` varchar(3000) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `web_article` */

insert  into `web_article`(`id`,`cid`,`title`,`text`,`type`,`typeName`,`state`,`stateName`,`count`,`createTime`,`operater`,`operaterName`,`image`,`summary`,`point`,`author`,`imageUrl`) values (15,'webapp.xmtz','科威特酝酿鼓励国际和本国公司投资BOT项','科威特酝酿鼓励国际和本国公司投资项目','webapp.xmtz','项目投资','visible.true','显示',0,'2013-07-14 11:19:23','system','开发维护员','/webapp/attached/appCar/20130712/20130712164406_460.jpg','科威特酝酿鼓励国际和本国公司投资BOT项',1,'詹晓飞',NULL),(16,'webapp.xmtz','中石化第三次与跨国石油巨头大规模合作','近两年来中石化与跨国巨头的<a href=\"/SCHART/%BA%CF%D7%F7.HTM\"><b>合作</b></a>频频。以其中规模最大的三次而言，第一次合资发生在2001年9月，中石化旗下的扬子石化与巴斯福合资生产乙烯，合资金额29亿美元。第二次是不久前上海石化、中国石化、BP三方合资成立的上海赛科乙烯项目，总投资达27.5亿美元。此次与埃克森美孚的合作是第三次。中石化的这种战略与其自身的实力和未来的发展战略有关。','webapp.xmtz','项目投资','visible.true','显示',0,'2013-07-14 11:19:08','system','开发维护员','/webapp/attached/appCar/20130712/20130712164356_605.jpg','中石化第三次与跨国石油巨头大规模合作',2,'大成网',NULL),(17,'webapp.twxx','图文测试数据','<p>\r\n	图文信息内容数据测试版本\r\n</p>','webapp.twxx','图文信息','visible.true','显示',0,'2013-07-14 11:20:21','system','开发维护员','/webapp/attached/appCar/20131120/20131120214645_181.jpg','图文概要信息',1,'宋阳',''),(18,'webapp.twxx','图文信息','<p>\r\n	长春市绿园区街道办事处\r\n</p>','webapp.twxx','图文信息','visible.true','显示',0,'2013-07-14 11:23:15','system','开发维护员','/webapp/attached/appCar/20131120/20131120214618_342.jpg','简单概要对数据的要点',2,'腾讯网',''),(19,'webapp.twxx','新闻政策法规','啊受到法啊斯蒂芬爱的色放阿杜','webapp.twxx','图文信息','visible.true','显示',0,'2013-07-14 11:23:56','system','开发维护员','/webapp/attached/appCar/20131120/20131120214505_308.jpg','政治 历史文化',3,'张晓亮',''),(24,'webapp.xmtj','区住建系统举办“道德讲堂”活动','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 活动由办公室主任刘娜主持，包括开场三问、唱歌曲、学模范、诵经典、发善心、送吉祥六个环节。活动开始时，大家对本职工作是否尽职尽责、是否问心无愧、是否精益求精三个问题进行了深思。在学唱了《公民道德歌》之后，大家又对闫淑芬、杨伟明、熊辉等人的先进事迹和《道德经》中的五段名句进行了学习，通过先进事迹和名句的学习，部分职工畅谈了个人的学习感想。活动最后，为参与活动人员每人分发了一张吉祥卡。','webapp.xmtj','项目推介','visible.true','显示',0,'1899-11-30 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20121128/20121128124734_502.jpg',' 为了促使广大干部职工增强自身道德修养，提升住建人文明形象，凝聚更多正能量，促进幸福宽城和谐发展。7月19日上午，宽城区住建系统在区公园管理处举办了“道德讲堂”活动。',1,'',NULL),(25,'webapp.xmtj','人机结合开展雨中除尘作业','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 保洁处组织抽派400余名环卫保洁员，出动6台小型皮卡车、4台洗扫车、2台高压式冲洗车，对城区主次街路路面、马路边石、交通隔离防护栏下的灰带进行全面水刷清洗工作。皮卡车与洗扫车相互配合，清洗马路边石；高压式冲洗车主要对交通隔离防护栏下的灰带进行冲刷。环卫保洁员配合机械化车来辆，负责将道路积水推入下水井口，确保路面不积存污水。降灰除尘作业一直持续到下午2点，按照“人休车不休”的原则，不间断来连续作业，基本完成城区主要街路的降灰降尘工作。<br />\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 下一步，保洁处将继续利用夏季雨多的优势，按照“中雨以上天气开展道路水刷降尘工作”的原则，定时对街路开展水洗，全面提升道路整体水平，有效缓解车辆行驶中尘土飞扬。（付&nbsp; 强&nbsp; 王姣音）\r\n</p>','webapp.xmtj','项目推介','visible.true','显示',0,'2013-07-23 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20130708/20130708130850_673.jpg','由于市区降雨频繁，为城区开展除尘作业提供了便利条件。宽城区环卫保洁处按照区市容胡环卫局的要求，迅速组织人员，出动各类机械化车辆，从上午10时开始，冒雨对城区街路开展雨中水刷除尘工作，有效减少了道路灰尘，明显提高了街路整体的环境卫生水平。',2,'',NULL),(26,'webapp.xmtj','人机结合开展雨中除尘作业','&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 保洁处组织抽派400余名环卫保洁员，出动6台小型皮卡车、4台洗扫车、2台高压式冲洗车，对城区主次街路路面、马路边石、交通隔离防护栏下的灰带进行全面水刷清洗工作。皮卡车与洗扫车相互配合，清洗马路边石；高压式冲洗车主要对交通隔离防护栏下的灰带进行冲刷。环卫保洁员配合机械化车来辆，负责将道路积水推入下水井口，确保路面不积存污水。降灰除尘作业一直持续到下午2点，按照“人休车不休”的原则，不间断来连续作业，基本完成城区主要街路的降灰降尘工作。<br />\r\n<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 下一步，保洁处将继续利用夏季雨多的优势，按照“中雨以上天气开展道路水刷降尘工作”的原则，定时对街路开展水洗，全面提升道路整体水平，有效缓解车辆行驶中尘土飞扬。（付&nbsp; 强&nbsp; 王姣音）\r\n</p>','webapp.xmtj','项目推介','visible.true','显示',0,'2013-07-23 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20130708/20130708130850_673.jpg','由于市区降雨频繁，为城区开展除尘作业提供了便利条件。宽城区环卫保洁处按照区市容胡环卫局的要求，迅速组织人员，出动各类机械化车辆，从上午10时开始，冒雨对城区街路开展雨中水刷除尘工作，有效减少了道路灰尘，明显提高了街路整体的环境卫生水平。',3,'',NULL),(27,'webapp.fzdt','凯旋街道: 社区做好汛期防范工作 确保居民安全','<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 针对社区三大平房区域，一心街社区做到早安排、早部署、早落实。在汛期来临之前对辖区平房区域张贴通知，各网格负责人和社区主任逐门逐户走访排查，确保不留死角；同时开通社区防汛值班电话，工作人员保证手机24小时开机，随时待命；社区编排防汛值班表，值班人员每天巡查平房区至少两次，确保做好每日防汛值班记录，对突发事件做到及时汇报，及时处理。按照“防大汛、抗大洪、抢大险”的要求，提高警惕，防抢并重，全力做好今年的防汛工作。（曲&nbsp; 爽）\r\n</p>','webapp.fzdt','发展动态','visible.true','显示',0,'2013-07-23 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20130712/20130712164343_991.jpg','   自从进入主汛期以来，降水明显偏多，防汛任务非常艰巨。为了确保居民安全度过汛期，宽城区凯旋街道一心街社区定期对平房区进行排查，全力做好汛期防范工作。',1,'',NULL),(29,'webapp.kcdt','东亚杯-曾诚数次救险张琳芃错失良机 国足0-0韩国','<p>\r\n	新浪体育讯　北京时间7月24日，2013东亚杯男足比赛展开第二比赛日的争夺，中国男足挑战东道主韩国队。第39分钟，张琳芃[微博]禁区内摆脱防守后可惜没有打门，错失良机。曾诚半场四次扑救化解险情。下半场曾诚又是多次化解险情。第81分钟，杨昊远射完成国足[微博]第一脚打门。90分钟战罢，中国队0-0打平韩国队，东亚杯两连平。\r\n</p>\r\n<p>\r\n	中国队首战在两球落后的情况下3-3追平日本。此战先发阵容有所调整，郑智回撤与杜威[微博]搭档中后卫，杨昊与黄博文组成双后腰，首战打入扳平球的孙可[微博]先发出场。韩国队首战0-0战平澳大利亚。尽管韩国队此战有着为洪明浦争取执教首胜的意义，其阵容较之首战仍是大幅调整，更换了9位先发。3年前的东亚杯上，高家军3-0痛斩韩国队，韩国舆论表示此战的目标就是向中国队复仇。\r\n</p>\r\n<p>\r\n	开场后韩国队形成连续控球，比赛进行1分钟后杨昊前场抢断，但郜林[微博]横传失误；第3分钟，杨昊又在后场铲断，并被对手犯规侵犯。第6分钟，杜威中场传递失误，郑智在与尹日禄竞速后抢先将球破坏。第9分钟，中国队快攻中王永珀[微博]被包夹传球失误，韩国队快速反击造成杜威在禁区前手球，来自乌兹别克斯坦的主裁判瓦伦丁-科瓦连科向杜威出示黄牌；朴钟佑任意球攻门被中国队人墙挡出。较之首战对澳大利亚时，韩国队本场有意识在控制节奏，但快速前传的特色仍有体现，比赛前10分钟也数次出现越位。中国队在防守中也很谨慎，采取了回撤半场的防守姿态。\r\n</p>\r\n<p>\r\n	第11分钟，中国队前场右侧小氛围传递配合受阻，但孙可脚后跟妙传郜林给出了亮点。1分钟后，韩国队右路传中给中国队禁区制造混乱，尹日禄将球回传后，朴钟佑迎上大力攻门，曾诚侧扑中单手将球封出。比赛一刻钟左右韩国队形成了持续中前场压制，数分钟时段内中国队都没有通过半场。第18分钟，李镕右翼前插远射被曾诚连续扑救将球没收。随着于大宝[微博]边路内切传中给韩国禁区施加压力，中国队也形成连续中前场渗透，但面对韩国队严密防守未能捕捉到实质战机。<br />\r\n第24分钟，孙可与王永珀在右路配合后冲刺拼抢赢得角球；王永珀将球传至前点，郜林头球摆渡未能有队友接应，皮球划过韩国队禁区。第27分钟，王永珀中场右侧斜传韩国队禁区，于大宝前插中飞身接应未能碰到皮球。1分钟后韩国队左路传中形成威胁攻势，徐东炫将球挡入禁区，尹日禄大力攻门被曾诚快速侧扑挡出。第30分钟，曹永哲右路斜传中国队门前，曾诚奋不顾身地前扑将球击出，被徐东炫重重地蹬踏到了脸部，主裁判向徐东炫出示黄牌；经伤停处理，曾诚头部贴上了多个止血贴。\r\n</p>\r\n<p>\r\n	第36分钟，郜林为中国队赢得前场左侧任意球，黄博文传中被韩国门将郑成龙出击破坏。2分钟后，于大宝右路过人后被金民友拉拽侵犯，后者领到黄牌；黄博文任意球传中被封堵，中国队继续组织冲击，张琳芃左侧突入韩国队禁区，并扣球摆脱了追防球员，但传中时被挡出底线。这一时段，中国队借连续的前场定位球对韩国队形成了持续压制，只可惜未能形成实质攻门。第44分钟，韩国队角球攻势被曾诚出击破坏，韩国队外围再射又被中国防线用身体封堵。1分钟后，曹永哲右翼内切后劲射打偏。补时阶段韩国队快攻中左路传中至中国队门前，徐东炫未能包抄到落点。上半场双方战为0-0。\r\n</p>\r\n<p>\r\n	易边后双方拉开阵型对峙。第49分钟，韩国队右翼传中穿透中国队防线，徐东炫禁区中路调整时被杜威拦截破坏；1分钟后韩国队快速防转攻又给中国队禁区制造混乱，不过其战术角球配合被中国队拦截。第53分钟，于大宝与张琳芃右路配合赢得角球；杨昊传中也被对手控制了落点。此后中国队相继用武磊[微博]、张稀哲[微博]换下王永珀、孙可。韩国队也派出了K联赛新人王李承琪以及中国球迷很熟悉的高中锋金信煜。\r\n</p>\r\n<p>\r\n	第64分钟，中国队后防线在争顶高点时于身后露出空档，徐东炫获得了禁区线内面对门将攻门的机会，但其挑射失误被曾诚没收。第69分钟，黄博文长传右路，郜林一挑三强突入禁区后摔倒；为破坏韩国队快攻，黄博文犯规领到黄牌。随着金信煜的出场，韩国队长距离斜传冲吊明显增多，曾诚再度给出了前冲中飞身击球的动作。第73分钟，郑智禁区前上抢侵犯李承琪，韩国队获得了位置极佳的任意球良机；廉基勋任意球攻门快速穿透人墙，曾诚反应神速侧扑将球封出！\r\n</p>\r\n<p>\r\n	<br />\r\n进入收官阶段中国队再用曲波换下于大宝。第81分钟，中国队前场界外球掷入后，张琳芃沿底线突入传中，韩国队将球顶出，杨昊远距离攻门被郑成龙没收。1分钟后韩国队右路传中，替补出场的高武烈头球顶高。韩国队持续高球冲击均被中国队积极化解。第88分钟，张琳芃边路侵犯高武烈，中国队化解韩国队任意球冲击后展开快攻，韩国队\r\n</p>','webapp.kcdt','宽城动态','visible.true','显示',0,'1899-11-30 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131113/20131113230409_946.jpg','',7,'',''),(31,'webapp.xmtj','广州农业局长回应与王林蛇缠脖合影','<p>\r\n	“气功大师”王林无疑是当下的网络红人，与他交往的各界知名人士和各级政府官员近日被媒体逐一曝光。现任广州市农业局党委书记、局长的汤锦华昨日也被网友爆料称曾面见王林，并以蛇缠脖与其合影。昨日傍晚，汤锦华回应称是13年前任增城市委书记时的旧事，蛇缠脖合影“只是玩游戏”。\r\n</p>\r\n<p>\r\n	7月23日23时许，网友“伊莲娜月光手帕”在新浪微博发帖称，“大师又跟哪个广州市的官员合照了？农业局局长，我认得你，我可不想吃转基因食品哦。”截至记者昨晚发稿时止，该微博被转发93次、评论22次。\r\n</p>\r\n<p>\r\n	该微博配图为一名男子与“大师”王林的合影。图中“大师”站在右侧，上身着黑色透视装，下身仅穿白色三角内裤。图中“大师”面带笑容，左手叉腰，右臂搭在男子左肩上，右手抓住三条蛇，蛇身缠绕在男子脖子上。该图图说还称，广东省增城市委书记汤锦华到深圳看望“大师”，并目睹了“大师”的神奇表演后连连称奇，赞不绝口。而图中男子为现任广州市农业局党委书记、局长的汤锦华。\r\n</p>\r\n<p>\r\n	记者查阅公开资料获悉，汤锦华2000年至2006年曾任增城市委书记。现任广州市农业局党委书记、局长。\r\n</p>\r\n<p>\r\n	昨日傍晚，在接受南都记者电话采访时，汤锦华说，网友微博中展示的照片是2000年与朋友一起去深圳，应邀去见王林时所拍的。“几十个人在一起，也不知道谁拍的”。对于为何要蛇绕脖拍照，汤锦华解释，“只是玩游戏”。\r\n</p>','webapp.xmtj','项目推介','visible.true','显示',0,'2013-07-25 00:00:00','yangshuangjia','杨霜佳','','“气功大师”王林无疑是当下的网络红人，与他交往的各界知名人士和各级政府官员近日被媒体逐一曝光。现任广州市农业局党委书记、局长的汤锦华昨日也被网友爆料称曾面见王林，并以蛇缠脖与其合影。昨日傍晚，汤锦华回应称是13年前任增城市委书记时的旧事，蛇缠脖合影“只是玩游戏”。',4,'中安在线',NULL),(32,'webapp.kcdt','北京：男子与人争执 当街将2岁女童抱起摔死','<p>\r\n	女童熟睡被摔在地\r\n</p>\r\n<p>\r\n	事发大兴区旧宫镇庑殿路西侧，729路公交车成和园小区开往焦庄桥北方向，科技路公交站站牌旁。昨天上午，事发地多名商户证实，前晚8点多，公交站旁曾有人殴打一名女子，女子推车上的孩子被重摔在地。事发公交站处，已无相关痕迹。\r\n</p>\r\n<p>\r\n	事发当晚，周先生在距事发地近十米距离的一家面馆外经营大排档。他介绍，事发晚上8点50分左右，他正在照顾生意，突然听见公交站牌传来“啪啪”声，一名年纪约30岁穿深色上衣的男子正殴打一名中长发白衣女子，一辆白色轿车和一儿童推车停在路旁。\r\n</p>\r\n<p>\r\n	“那男人下手很重，我在大排档都听见了声响”，周先生称，男子打了没几下，便转向儿童推车，将推车上的孩子抱起，“举起来，然后就重重摔下来”。\r\n</p>\r\n<p>\r\n	周先生称，推车内的孩子原本在睡觉，男子抱起时并未挣扎，“摔下去后就更没有动静，连正常的感到疼痛的哭声都没有”。周先生说，男子摔下孩子后，另一名与动手男子年纪相仿的男子从白色轿车驾驶员位置走下，“也去打了那个女的几下”。\r\n</p>\r\n<p>\r\n	停车问题引发争执\r\n</p>\r\n<p>\r\n	周先生称，整个事发过程不足3分钟，事发后他配合警方调取了监控录像。监控显示，女子手推儿童推车路过公交站时，“可能是小孩出现了什么情况，那女的就弯腰查看，白色轿车随后开过来，车里的人好像示意他们要在那里停车，让女子离开”。周先生称，女子并未同意，双方言语几句后，副驾位置的男子便下车打人。\r\n</p>\r\n<p>\r\n	多名目击者称，事发后，白色轿车快速沿庑殿路向南驶去。不久，警方赶至现场，对公交站进行了封锁，开始调查取证。\r\n</p>','webapp.kcdt','宽城动态','visible.true','显示',0,'2013-07-25 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131113/20131113230200_555.jpg','前晚8点50分左右，大兴区庑殿路西侧一公交站旁，两名驾车男子与一手推载有两岁女童的童车的女子发生争执，一男子动手殴打该女子，随后，男子又将女童从推车中抱出，重摔在地，并随后驾车逃离现场。事发后，女童在送医路上被确认死亡。',9,'京华时报',''),(34,'webapp.kcdt','德国费森尤斯医药用品公司','<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	8月14日下午，德国费森尤斯医药用品公司高管一行4人，在省经合局欧美处副处长庞皓然陪同下到宽城区进行考察，副区长李维彬代表区主要领导出席会见，区经合局、区卫生局和区医院相关领导一同参与会见。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	一、领导重视，确保会谈效果显著。区领导非常重视此次接待工作，李维彬副区长代表区主要领导出席接见，并召集区经合局、区卫生局和区医院等相关部门领导一同参会。期间，李维彬副区长就宽城区的投资环境及发展规划向考察团进行了详细的介绍。针对宽城区医疗领域项目建设情况、区医院内的肾透析设备使用情况和目前医院就诊患者\r\n</p>','webapp.kcdt','宽城动态','visible.true','显示',0,'2013-08-20 00:00:00','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131113/20131113225617_965.jpg','8月14日下午，德国费森尤斯医药用品公司高管一行4人，在省经合局欧美处副处长庞皓然陪同下到宽城区进行考察，副区长李维彬代表区主要领导出席会见，区经合局、区卫生局和区医院相关领导一同参与会见。\r\n\r\n\r\n',11,'区经合局',''),(35,'webapp.twxx','长春宽城万达广场盛大开业','<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	8月16日上午，宽城区首席超大型城市商业综合体——宽城万达广场隆重开业。这是继重庆路、红旗街万达广场后长春市迎来的第三座万达广场，标志着长春城市新中心正式启幕！开业当天，逾30万的人潮不断涌向宽城万达广场，建筑面积16万平方米的主商场炫彩亮丽、玻璃幕墙宽视宏景，给市民带来全新的购物体验。扣动人心的商家优惠掀起了一波又一波的开业热潮，有业内人士指出：宽城万达广场的开业将提升整个城市的商业格局，并带动火车站商圈再一次升级。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n长春宽城万达广场是宽城区城市重点形象工程，备受政府和投资者关注。项目位于宽城区凯旋路与铁北二路交汇，对临火车站北出口，火车站商圈门户，集合铁路、公路、地铁、轻轨等多重资源，是宽城区投资最大、规模最大、档次最高的一站式商业中心。长春宽城万达广场从规划设计、建筑品质、业态分布、招商层级、购物环境等各方面都成为了春城购物中心的标杆。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n2013年，万达集团将在全国开业19座万达广场，宽城万达广场总建筑面积约45万平方米，总投资逾30亿元，由大型购物中心、商业步行街、高级影院、高端住宅组成，购物中心引入万达百货、万达影城、大歌星KTV、大玩家超乐场、永辉超市、C&amp;A、优衣库七大主力店，H&amp;B快时尚品牌，室内精品街引进Shine Accessories、LNO mothercare、Westlink、DEALUNA等国际知名品牌，有16个品牌首次进驻长春市，67个品牌首次进驻我市万达广场。宽城万达广场实现企业效益与社会效益的高度统一，可为宽城区新增上万个稳定就业岗位，每年创造上亿元税收，实现万达集团“共创财务，公益社会”的企业使命。\r\n</p>','webapp.twxx','图文信息','visible.true','显示',0,'2013-08-20 12:48:16','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131120/20131120214355_630.jpg','　8月16日上午，宽城区首席超大型城市商业综合体——宽城万达广场隆重开业。这是继重庆路、红旗街万达广场后长春市迎来的第三座万达广场，标志着长春城市新中心正式启幕！开业当天，逾30万的人潮不断涌向宽城万达广场，建筑面积16万平方米的主商场炫彩亮丽、玻璃幕墙宽视宏景，给市民带来全新的购物体验。扣动人心的商家优惠掀起了一波又一波的开业热潮，有业内人士指出：宽城万达广场的开业将提升整个城市的商业格局，并带动火车站商圈再一次升级。',4,'区发改局',''),(36,'webapp.twxx','宽城区迎接国家创建公共文化服务体系示范区检查组全面检查','<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	8月11日上午，文化部创建国家公共文化服务体系示范区验收检查组对长春市创建示范区工作进行了验收检查，宽城区文化馆是此次代表我市迎检的单位之一。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n2011年，长春市入围全国首批国家公共文化服务体系示范区创建城市。在两年的创建期间，宽城区委、区政府高度重视示范区创建工作，紧紧把握这个难得的发展机遇，以“文化惠民、文化利民、文化便民”为宗旨，以着眼大局、紧贴实际、立足长远为原则，把示范区建设工作作为推动宽城发展的强劲动力、提升宽城品质的重大举措、惠及民生的重要内容来抓，不断满足了人民群众日益增长的公共文化需求，使宽城区深厚历史文化底蕴得以挖掘和发扬，公共文化发展基础进一步夯实。并形成了“设施网络化、供给多元化、城乡一体化、服务普惠化、活动品牌化、机制长效化”的公共文化服务“宽城模式”，一举从全市创建工作中脱颖而出。在此次迎检中，宽城人更是以积极的斗智和饱满的热情，信心十足地迎接着领导的检阅，为我市示范区创建工作勇立头功。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n副市长张晶莹，市文广新局局长崔永泉、区长左毅、副区长李维彬等领导和相关同志陪同检查。（由剑梅）\r\n</p>','webapp.twxx','图文信息','visible.true','显示',0,'2013-08-20 12:51:36','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131114/20131114102511_390.jpg','　8月11日上午，文化部创建国家公共文化服务体系示范区验收检查组对长春市创建示范区工作进行了验收检查，宽城区文化馆是此次代表我市迎检的单位之一。',5,'区文体局',''),(37,'webapp.kcdt','常万全：希望美国亚太再平衡战略不要针对中国','<p>\r\n	常万全当日在与美国国防部长哈格尔会谈后举行的联合记者会上两次被问及美国亚太再平衡战略的相关问题。\r\n</p>\r\n<p>\r\n	在回答美国记者提问时，常万全引用中国国家主席习近平的话说：“太平洋足够大，可以容纳中国和美国”，中国欢迎美国在亚太发挥建设性的作用。\r\n</p>\r\n<p>\r\n	常万全指出，美国关于亚太再平衡，是考虑到政治、经济、军事等方面。但是，现在，亚太各国已注意到，美军在亚太再平衡方面，也凸显了军事方面的存在，包括加强在亚太地区的军事部署，加强和同盟国的一些军演和合作等。另外，最近一段时期，美军在亚太地区的军演频率和强度不断加大，从一定程度上使亚太地区的局势进一步复杂化。\r\n</p>\r\n<p>\r\n	“我们中国是爱好和平的，希望美国亚太再平衡战略不要针对中国并对中国进行‘弱化’。”常万全站在哈格尔身边说：“中国的发展不仅对中国有利，对亚太地区有利，对美国同样有利。我们和美国及其它亚洲国家共同生活在太平洋地区，大家的夙愿是需要太平，我们希望美国的亚太再平衡战略能给太平洋地区带来太平。”\r\n</p>\r\n<p>\r\n	常万全补充说：“不过，我们也注意到，这种平衡应注意方方面面、各个国家的平衡。再平衡的要旨在于‘平衡’，如果出现失衡将事与愿违。”\r\n</p>\r\n<p>\r\n	在回答中方记者提问时，常万全进一步谈了自己的五点看法。他表示，当前亚太形势总体上是稳定的，但是也存在一些热点、敏感问题。有的热点问题越来越热，有的敏感问题越来越敏感，如果处理不好可能对整个亚太地区安全形势乃至整个国际形势造成很大的冲击。\r\n</p>\r\n<p>\r\n	“中国人民一向爱好和平，中方始终是亚太和平稳定的坚定维护者，始终坚持通过对话谈判解决有关争端。”\r\n</p>\r\n<p>\r\n	但是，常万全话锋一转，提高声调说：“任何人不用幻想中方会拿核心利益作交易，不用低估我们维护国家领土主权和海洋权益的决心和意志。”\r\n</p>','webapp.kcdt','宽城动态','visible.true','显示',0,'2013-08-20 12:52:14','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131113/20131113225957_830.jpg','正在美国访问的中国国防部长常万全19日在华盛顿表示，希望美国的亚太再平衡战略不要针对中国，并且能给太平洋地区带来“太平”。他同时强调，中国始终是亚太和平稳定的坚定维护者，但是，任何人都不用幻想中方会拿核心利益作交易。',12,'中国新闻网',''),(38,'webapp.twxx','全国“法律进机关”专场推进会在吉林省长春市宽城区召开','<span style=\"padding-bottom:0px;widows:2;text-transform:none;background-color:#ffffff;text-indent:0px;margin:0px;padding-left:0px;padding-right:0px;font:14px/25px Simsun;white-space:normal;orphans:2;letter-spacing:normal;color:#000000;word-spacing:0px;text-decoration:none;padding-top:0px;-webkit-text-size-adjust:auto;-webkit-text-stroke-width:0px;\" id=\"Zoom\" class=\"j_wenzi14\"> \r\n<p style=\"text-align:left;padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\">\r\n	8月7日上午，司法部、全国普及法律常识办公室组织的全国“深化‘法律六进’推进依法治国”法制宣传教育主题活动“法律进机关”专场推进会，在宽城区顺利召开。区委书记李忠斌，区人大主任梁振亚，区委常委、区委政法委书记靳明，以及五个机关部门和五个街道分管领导代表全区参加了会议。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n会议围绕“六五”普法，特别是党的十八大以来，各地按照司法部、全国普法办的部署要求，在创新载体，提升公务员特别是领导干部运用法治思维、法治方式服务科学发展和推进“依法治国”方面，对深化“法律六进”，扎实开展“法律进机关”法制宣传教育主题活动，进行广泛交流和推广。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n会议由司法部法制宣传司司长查庆九主持，吉林省司法厅厅长、省依法治省领导小组办公室主任王进义在会上致辞。吉林、山东、广东、长春市宽城区等地代表在会上交流发言，司法部副部长、全国普法办副主任张苏军做总结讲话。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n中共长春市宽城区委书记李忠斌作了题为《推进机关法治建设促进宽城和谐发展》的发言，详细介绍了“六五”普法以来，紧紧围绕幸福宽城和法治宽城建设，以决策科学化、机制长效化、管理网格化、服务信息化为依托，深化“法律进机关”活动，促进各级干部学法、守法、用法，为加快全区经济社会发展营造良好的法制环境所做的一些有益探索和实践。一是突出领导干部这个重点，构建“法律进机关”长效机制；二是围绕加快发展这个大局，提升“法律进机关”服务实效；三是强化主题实践这个载体，形成“法律进机关”工作合力。\r\n</p>\r\n<p style=\"text-align:left;padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\">\r\n	<br style=\"padding-bottom:0px;margin:0px;padding-left:0px;padding-right:0px;padding-top:0px;\" />\r\n李忠斌介绍：“六五”普法以来，制定了依法行\r\n</p>\r\n</span>','webapp.twxx','图文信息','visible.true','显示',0,'2013-08-20 12:53:22','yangshuangjia','杨霜佳','/webapp/attached/appCar/20131114/20131114102340_519.jpg','8月7日上午，司法部、全国普及法律常识办公室组织的全国“深化‘法律六进’推进依法治国”法制宣传教育主题活动“法律进机关”专场推进会，在宽城区顺利召开。区委书记李忠斌，区人大主任梁振亚，区委常委、区委政法委书记靳明，以及五个机关部门和五个街道分管领导代表全区参加了会议。\r\n',6,'区司法局','');

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

insert  into `web_content`(`id`,`name`,`english`,`path`,`parentId`,`sort`,`hasShow`,`hasShowName`,`mode`,`modeName`) values ('webapp','移动办公','ydbg','',NULL,463,'visible.true','显示','content.mode.none','空项'),('webapp.kcdt','宽城动态','kcdt','/app/website/admin/news/kcdt.jsp','webapp',464,'visible.true','显示','content.mode.more','多项'),('webapp.xmtz','项目投资','xmtz','','webapp',465,'visible.true','显示','content.mode.more','多项'),('webapp.twxx','图文信息','twxx','','webapp',466,'visible.true','显示','content.mode.more','多项'),('webapp.xmtj','项目推介','xmtj','','webapp',467,'visible.true','显示','content.mode.more','多项'),('webapp.fzdt','发展动态','fzdt','','webapp',468,'visible.true','显示','content.mode.more','多项');

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
