/*
Navicat MySQL Data Transfer

Source Server         : 120.55.100.149
Source Server Version : 50537
Source Host           : 120.55.100.149:3306
Source Database       : carshop

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2015-04-13 21:56:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for car_admin_users
-- ----------------------------
DROP TABLE IF EXISTS `car_admin_users`;
CREATE TABLE `car_admin_users` (
  `user_id` mediumint(8) unsigned NOT NULL COMMENT '后台用户ID',
  `status` enum('0','1') NOT NULL DEFAULT '0' COMMENT '启用',
  `name` varchar(30) DEFAULT NULL COMMENT '姓名',
  `lastlogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `truename` varchar(30) DEFAULT NULL COMMENT '真实姓名',
  `config` longtext COMMENT '配置信息',
  `favorite` longtext COMMENT '爱好',
  `super` enum('0','1') NOT NULL DEFAULT '0' COMMENT '超级管理员',
  `lastip` varchar(20) DEFAULT NULL COMMENT '上次登录ip',
  `logincount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false',
  `op_no` varchar(50) DEFAULT NULL COMMENT '操作员no',
  `password` varchar(128) DEFAULT NULL,
  `memo` text COMMENT '备注',
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of car_admin_users
-- ----------------------------
INSERT INTO `car_admin_users` VALUES ('1', '1', 'admin', '1416965007', null, null, null, '1', null, '323', 'false', null, '14e1b600b1fd579f47433b88e8d85291', null, '1');
