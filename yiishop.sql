/*
Navicat MySQL Data Transfer

Source Server         : 120.55.100.149
Source Server Version : 50537
Source Host           : 120.55.100.149:3306
Source Database       : carshop

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2015-04-12 17:44:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for car_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `car_admin_group`;
CREATE TABLE `car_admin_group` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `group_name` varchar(50) NOT NULL COMMENT '组名称',
  `acl` text NOT NULL COMMENT '权限',
  `status_is` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '录入时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员组';

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
-- Table structure for car_advertisement
-- ----------------------------
DROP TABLE IF EXISTS `car_advertisement`;
CREATE TABLE `car_advertisement` (
  `advert_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统编号主键  自增',
  `channel` enum('APP','WAP','WEB') NOT NULL COMMENT '所属渠道',
  `advert_name` varchar(200) NOT NULL,
  `header` text,
  `footer` text,
  `css_path` int(11) DEFAULT NULL,
  `status` enum('D','A') NOT NULL DEFAULT 'A' COMMENT 'A activity  D dead',
  `create_time` int(11) NOT NULL,
  `create_user` int(11) NOT NULL,
  `edit_user` int(11) DEFAULT NULL,
  `edit_time` int(11) DEFAULT NULL,
  `disabled` enum('false','true') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`advert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_advertisement_items
-- ----------------------------
DROP TABLE IF EXISTS `car_advertisement_items`;
CREATE TABLE `car_advertisement_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `advert_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL COMMENT '货号',
  `priority` int(5) NOT NULL COMMENT '显示优先级',
  `introduction` varchar(255) DEFAULT NULL,
  `is_recommond` enum('false','true') NOT NULL,
  `mktprice` decimal(20,3) NOT NULL,
  `disabled` enum('false','true') NOT NULL DEFAULT 'false',
  `create_time` int(11) NOT NULL,
  `create_user` int(11) NOT NULL,
  `edit_time` int(11) DEFAULT NULL,
  `edit_user` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_brand
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_brand`;
CREATE TABLE `car_b2c_brand` (
  `brand_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '品牌id',
  `brand_name` varchar(50) NOT NULL COMMENT '品牌名称',
  `brand_url` varchar(255) DEFAULT NULL COMMENT '品牌网址',
  `brand_desc` longtext COMMENT '品牌介绍',
  `brand_logo` varchar(255) DEFAULT NULL COMMENT '品牌图片标识',
  `brand_keywords` longtext COMMENT '品牌别名',
  `brand_setting` enum('3','2','1') DEFAULT NULL COMMENT '品牌设置 1:首页底部推荐',
  `ordernum` mediumint(8) unsigned DEFAULT NULL COMMENT '排序',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '失效',
  PRIMARY KEY (`brand_id`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_ordernum` (`ordernum`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_cart
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_cart`;
CREATE TABLE `car_b2c_cart` (
  `cart_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `member_ident` varchar(50) NOT NULL COMMENT '会员ident',
  `params` longtext NOT NULL COMMENT '购物车对象参数',
  PRIMARY KEY (`cart_id`,`member_ident`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_cart_objects
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_cart_objects`;
CREATE TABLE `car_b2c_cart_objects` (
  `obj_ident` varchar(255) NOT NULL COMMENT '对象ident',
  `member_ident` varchar(50) NOT NULL COMMENT '会员ident,会员信息和serssion生成的唯一值',
  `member_id` int(8) NOT NULL DEFAULT '-1' COMMENT '会员 id',
  `obj_type` varchar(20) NOT NULL COMMENT '购物车对象类型',
  `params` longtext NOT NULL COMMENT '购物车对象参数',
  `quantity` float unsigned NOT NULL COMMENT '数量',
  `time` int(10) unsigned DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`obj_ident`,`member_ident`,`member_id`),
  KEY `ind_member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_delivery
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_delivery`;
CREATE TABLE `car_b2c_delivery` (
  `delivery_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '配送流水号',
  `order_id` varchar(100) DEFAULT NULL COMMENT '订单号',
  `delivery_bn` varchar(32) DEFAULT NULL COMMENT '配送流水号',
  `member_id` mediumint(8) unsigned DEFAULT NULL COMMENT '订货会员ID',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '配送费用',
  `is_protect` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否保价',
  `delivery` mediumint(8) unsigned DEFAULT NULL COMMENT '配送方式(货到付款、EMS...)',
  `logi_id` varchar(50) DEFAULT NULL COMMENT '物流公司ID',
  `logi_name` varchar(100) DEFAULT NULL COMMENT '物流公司名称',
  `logi_no` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `ship_name` varchar(50) DEFAULT NULL COMMENT '收货人姓名',
  `ship_area` varchar(255) DEFAULT NULL COMMENT '收货人地区',
  `ship_addr` text COMMENT '收货人地址',
  `ship_zip` varchar(20) DEFAULT NULL COMMENT '收货人邮编',
  `ship_tel` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `ship_mobile` varchar(50) DEFAULT NULL COMMENT '收货人手机',
  `ship_email` varchar(200) DEFAULT NULL COMMENT '收货人Email',
  `t_begin` int(10) unsigned DEFAULT NULL COMMENT '单据生成时间',
  `t_send` int(10) unsigned DEFAULT NULL COMMENT '单据结束时间',
  `t_confirm` int(10) unsigned DEFAULT NULL COMMENT '单据确认时间',
  `op_name` varchar(50) DEFAULT NULL COMMENT '操作者',
  `status` enum('succ','failed','cancel','lost','progress','timeout','ready') NOT NULL DEFAULT 'ready' COMMENT '状态',
  `memo` longtext COMMENT '备注',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '无效',
  PRIMARY KEY (`delivery_id`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_logi_no` (`logi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=142881657299535611 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_delivery_items
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_delivery_items`;
CREATE TABLE `car_b2c_delivery_items` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `delivery_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发货单号',
  `order_item_id` mediumint(8) unsigned DEFAULT '0' COMMENT '发货明细订单号',
  `item_type` enum('goods','gift','pkg','adjunct') NOT NULL DEFAULT 'goods' COMMENT '商品类型',
  `product_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '货品ID',
  `product_bn` varchar(30) DEFAULT NULL COMMENT '货品号',
  `product_name` varchar(200) DEFAULT NULL COMMENT '货品名称',
  `number` float NOT NULL DEFAULT '0' COMMENT '发货数量',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_dlycorp
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_dlycorp`;
CREATE TABLE `car_b2c_dlycorp` (
  `corp_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '物流公司ID',
  `type` varchar(6) DEFAULT NULL COMMENT '类型',
  `corp_code` varchar(200) DEFAULT NULL COMMENT '物流公司代码',
  `name` varchar(200) DEFAULT NULL COMMENT '物流公司',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '失效',
  `ordernum` smallint(4) unsigned DEFAULT NULL COMMENT '排序',
  `website` varchar(200) DEFAULT NULL COMMENT '物流公司网址',
  `request_url` varchar(200) DEFAULT NULL COMMENT '查询接口网址',
  PRIMARY KEY (`corp_id`),
  KEY `ind_type` (`type`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_ordernum` (`ordernum`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_dlytype
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_dlytype`;
CREATE TABLE `car_b2c_dlytype` (
  `dt_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '配送ID',
  `dt_name` varchar(50) DEFAULT NULL COMMENT '配送方式',
  `has_cod` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '货到付款',
  `firstunit` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '首重',
  `continueunit` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '续重',
  `is_threshold` enum('0','1') DEFAULT '0' COMMENT '临界值',
  `threshold` longtext COMMENT '临界值配置参数',
  `protect` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '物流保价',
  `protect_rate` float(6,3) DEFAULT NULL COMMENT '报价费率',
  `minprice` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '保价费最低值',
  `setting` enum('0','1') DEFAULT '1' COMMENT '地区费用类型',
  `def_area_fee` enum('true','false') DEFAULT 'false' COMMENT '按地区设置配送费用时,是否启用默认配送费用',
  `firstprice` float(10,2) DEFAULT '0.00' COMMENT '首重费用',
  `continueprice` float(10,2) DEFAULT '0.00' COMMENT '续重费用',
  `dt_discount` float(10,2) DEFAULT '0.00' COMMENT '折扣值',
  `dt_expressions` longtext COMMENT '配送费用计算表达式',
  `dt_useexp` enum('true','false') DEFAULT 'false' COMMENT '是否使用公式',
  `corp_id` mediumint(8) unsigned DEFAULT NULL COMMENT '物流公司ID',
  `dt_status` enum('0','1') DEFAULT '1' COMMENT '是否开启',
  `detail` longtext COMMENT '详细描述',
  `area_fee_conf` longtext COMMENT '指定地区配置的一系列参数',
  `ordernum` smallint(4) DEFAULT '0' COMMENT '排序',
  `disabled` enum('true','false') DEFAULT 'false',
  PRIMARY KEY (`dt_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods`;
CREATE TABLE `car_b2c_goods` (
  `goods_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `bn` varchar(200) DEFAULT NULL COMMENT '商品编号',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
  `type_id` mediumint(8) unsigned DEFAULT NULL COMMENT '类型',
  `cat_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `brand_id` mediumint(8) unsigned DEFAULT NULL COMMENT '品牌',
  `store` mediumint(8) unsigned DEFAULT '0' COMMENT '库存',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '销售价',
  `cost` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '成本价',
  `mktprice` decimal(20,3) DEFAULT NULL COMMENT '市场价',
  `weight` decimal(20,3) DEFAULT NULL COMMENT '重量',
  `unit` varchar(20) DEFAULT NULL COMMENT '单位',
  `goods_type` enum('normal','bind','gift') NOT NULL DEFAULT 'normal' COMMENT '销售类型',
  `image_default_id` varchar(32) DEFAULT NULL COMMENT '默认图片',
  `brief` varchar(255) DEFAULT NULL COMMENT '商品简介',
  `intro` longtext COMMENT '详细介绍',
  `goods_setting` longtext COMMENT '商品设置',
  `is_spec` enum('false','true') DEFAULT 'false' COMMENT '是否存在规格',
  `is_props` enum('false','true') DEFAULT NULL COMMENT '是否存在扩展属性',
  `spec_desc` longtext COMMENT '货品规格序列化',
  `params` longtext COMMENT '商品规格序列化',
  `marketable` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '上架',
  `p_order` mediumint(8) unsigned NOT NULL DEFAULT '30' COMMENT '排序',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '上架时间',
  `update_time` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`goods_id`),
  UNIQUE KEY `uni_bn` (`bn`),
  KEY `ind_frontend` (`disabled`,`goods_type`,`marketable`),
  KEY `idx_goods_type` (`goods_type`),
  KEY `idx_goods_type_d_order` (`goods_type`),
  KEY `idx_marketable` (`marketable`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_cat
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_cat`;
CREATE TABLE `car_b2c_goods_cat` (
  `cat_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` mediumint(8) unsigned DEFAULT NULL COMMENT '分类ID',
  `cat_path` varchar(100) DEFAULT ',' COMMENT '分类路径(从根至本结点的路径,逗号分隔,首部有逗号)',
  `is_leaf` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否叶子结点（true：是；false：否）',
  `type_id` mediumint(9) DEFAULT NULL COMMENT '类型序号',
  `cat_name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `gallery_setting` longtext COMMENT '商品分类设置',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否屏蔽（true：是；false：否）',
  `p_order` mediumint(8) unsigned DEFAULT '0' COMMENT '排序',
  `goods_count` mediumint(8) unsigned DEFAULT NULL COMMENT '商品数',
  `tabs` longtext COMMENT '子视图',
  `finder` longtext COMMENT '渐进式筛选容器',
  `addon` longtext COMMENT '附加项',
  `child_count` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '子类别数量',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  `img_url` varchar(256) DEFAULT NULL COMMENT '图片url',
  PRIMARY KEY (`cat_id`),
  KEY `ind_cat_path` (`cat_path`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_last_modify` (`last_modify`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_keywords
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_keywords`;
CREATE TABLE `car_b2c_goods_keywords` (
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `keyword` varchar(40) NOT NULL DEFAULT '' COMMENT '搜索关键字',
  `refer` varchar(255) DEFAULT '' COMMENT '来源',
  `res_type` enum('goods','article') NOT NULL DEFAULT 'goods' COMMENT '搜索结果类型',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`goods_id`,`keyword`,`res_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_lv_price
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_lv_price`;
CREATE TABLE `car_b2c_goods_lv_price` (
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `product_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '货品ID',
  `level_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员等级ID',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '会员价',
  PRIMARY KEY (`goods_id`,`product_id`,`level_id`),
  KEY `index_goods_id` (`goods_id`),
  KEY `index_product_id` (`product_id`),
  KEY `index_level_id` (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_props_index
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_props_index`;
CREATE TABLE `car_b2c_goods_props_index` (
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型ID',
  `props_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '扩展属性ID',
  `props_value_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '扩展属性值ID',
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`props_value_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_spec_index
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_spec_index`;
CREATE TABLE `car_b2c_goods_spec_index` (
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型ID',
  `spec_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '规格ID',
  `spec_value_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '规格值ID',
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `product_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '货品ID',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`spec_value_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_type`;
CREATE TABLE `car_b2c_goods_type` (
  `type_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '类型序号',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名称',
  `floatstore` enum('0','1') NOT NULL DEFAULT '0' COMMENT '小数型库存',
  `alias` longtext COMMENT '类型别名(|分隔,前后|)',
  `is_physical` enum('0','1') NOT NULL DEFAULT '1' COMMENT '实体商品',
  `schema_id` varchar(30) NOT NULL DEFAULT 'custom' COMMENT '供应商序号',
  `setting` longtext COMMENT '类型设置',
  `price` longtext COMMENT '设置价格区间，用于列表页搜索使用',
  `minfo` longtext COMMENT '用户购买时所需输入信息的字段定义序列化数组方式 array(字段名,字段含义,类型(input,select,radio))',
  `params` longtext COMMENT '参数表结构(序列化) array(参数组名=>array(参数名1=>别名1|别名2,参数名2=>别名1|别名2))',
  `tab` longtext COMMENT '商品详情页的自定义tab设置',
  `dly_func` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否包含发货函数',
  `ret_func` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否包含退货函数',
  `reship` enum('disabled','func','normal','mixed') NOT NULL DEFAULT 'normal' COMMENT '退货方式 disabled:不允许退货 func:函数式',
  `disabled` enum('true','false') DEFAULT 'false',
  `is_def` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否系统默认',
  `lastmodify` int(10) unsigned DEFAULT NULL COMMENT '上次修改时间',
  PRIMARY KEY (`type_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_type_props
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_type_props`;
CREATE TABLE `car_b2c_goods_type_props` (
  `props_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性序号',
  `type` varchar(20) NOT NULL COMMENT '展示类型',
  `search` varchar(20) NOT NULL DEFAULT 'select' COMMENT '搜索方式',
  `show` varchar(10) NOT NULL DEFAULT '' COMMENT '是否显示',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名称',
  `alias` longtext COMMENT '别名',
  `goods_p` smallint(6) DEFAULT NULL COMMENT '商品位置',
  `ordernum` int(10) DEFAULT '0' COMMENT '排序',
  `lastmodify` int(10) unsigned DEFAULT NULL COMMENT '供应商最后更新时间',
  PRIMARY KEY (`props_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_type_props_relation
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_type_props_relation`;
CREATE TABLE `car_b2c_goods_type_props_relation` (
  `relation_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `type_id` mediumint(8) unsigned NOT NULL COMMENT '商品类型id',
  `props_id` mediumint(8) unsigned NOT NULL COMMENT '属性序号',
  `last_modified` int(10) unsigned DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_type_props_value
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_type_props_value`;
CREATE TABLE `car_b2c_goods_type_props_value` (
  `props_value_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性值序号',
  `props_id` mediumint(8) unsigned NOT NULL COMMENT '属性序号',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名称',
  `order_by` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT '别名',
  `lastmodify` int(10) unsigned DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`props_value_id`),
  KEY `ind_props_id` (`props_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_goods_type_spec
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_goods_type_spec`;
CREATE TABLE `car_b2c_goods_type_spec` (
  `spec_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '规格ID',
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '类型ID',
  `spec_style` enum('select','flat','disabled') NOT NULL DEFAULT 'flat' COMMENT '渐进式搜索时的样式',
  `ordernum` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`spec_id`,`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_addrs
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_addrs`;
CREATE TABLE `car_b2c_member_addrs` (
  `addr_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '会员地址ID',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `name` varchar(50) DEFAULT NULL COMMENT '会员地址名称',
  `lastname` varchar(50) DEFAULT NULL COMMENT '姓名',
  `firstname` varchar(50) DEFAULT NULL COMMENT '姓名',
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `zip` varchar(20) DEFAULT NULL COMMENT '邮编',
  `tel` varchar(50) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `day` varchar(255) DEFAULT '任意日期' COMMENT '上门日期',
  `time` varchar(255) DEFAULT '任意时间段' COMMENT '上门时间',
  `def_addr` tinyint(1) DEFAULT '0' COMMENT '默认地址',
  PRIMARY KEY (`addr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_advance
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_advance`;
CREATE TABLE `car_b2c_member_advance` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志id',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '出入金额',
  `message` varchar(255) DEFAULT NULL COMMENT '管理备注',
  `mtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间',
  `payment_id` varchar(20) DEFAULT NULL COMMENT '支付单号',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单号',
  `paymethod` varchar(100) DEFAULT NULL COMMENT '支付方式',
  `memo` varchar(100) DEFAULT NULL COMMENT '业务摘要',
  `import_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '存入金额',
  `explode_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支出金额',
  `member_advance` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '当前余额',
  `shop_advance` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '商店余额',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '失效',
  PRIMARY KEY (`log_id`),
  KEY `ind_mtime` (`mtime`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_comments
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_comments`;
CREATE TABLE `car_b2c_member_comments` (
  `comment_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `for_comment_id` mediumint(8) DEFAULT '0' COMMENT '对m的回复',
  `type_id` bigint(20) unsigned DEFAULT NULL COMMENT '名称',
  `product_id` mediumint(8) unsigned DEFAULT '0' COMMENT '货品ID',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单编号',
  `object_type` enum('ask','discuss','buy','message','msg','order') NOT NULL DEFAULT 'ask' COMMENT '类型',
  `author_id` mediumint(8) DEFAULT '0' COMMENT '作者ID',
  `author` varchar(100) DEFAULT NULL COMMENT '发表人',
  `contact` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `mem_read_status` enum('false','true') DEFAULT 'false' COMMENT '会员阅读标识',
  `adm_read_status` enum('false','true') DEFAULT 'false' COMMENT '管理员阅读标识',
  `time` int(10) unsigned DEFAULT NULL COMMENT '时间',
  `lastreply` int(10) unsigned DEFAULT NULL COMMENT '最后回复时间',
  `reply_name` varchar(100) DEFAULT NULL COMMENT '最后回复人',
  `inbox` enum('true','false') DEFAULT 'true' COMMENT '收件箱',
  `track` enum('true','false') DEFAULT 'true' COMMENT '发件箱',
  `has_sent` enum('true','false') DEFAULT 'true' COMMENT '是否发送',
  `to_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '目标会员序号ID',
  `to_uname` varchar(100) DEFAULT NULL COMMENT '目标会员姓名',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `comment` longtext COMMENT '内容',
  `ip` varchar(15) DEFAULT NULL COMMENT 'ip地址',
  `display` enum('true','false') DEFAULT 'true' COMMENT '前台是否显示',
  `gask_type` varchar(50) DEFAULT '' COMMENT '留言类型 针对订单留言',
  `addon` longtext COMMENT '序列化',
  `p_index` tinyint(2) DEFAULT NULL COMMENT '弃用',
  `disabled` enum('false','true') DEFAULT 'false',
  PRIMARY KEY (`comment_id`),
  KEY `index_for_comment_id` (`for_comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_coupon
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_coupon`;
CREATE TABLE `car_b2c_member_coupon` (
  `memc_code` varchar(255) NOT NULL DEFAULT '' COMMENT '优惠券code',
  `cpns_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员优惠券ID',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `memc_gen_orderid` varchar(15) DEFAULT NULL COMMENT '优惠券产生订单号',
  `memc_source` enum('a','b','c') NOT NULL DEFAULT 'a' COMMENT '优惠券来源(保留)',
  `memc_enabled` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '留做后用, 可单独取消某些已发放出的优惠券',
  `memc_used_times` mediumint(9) DEFAULT '0' COMMENT '已使用次数',
  `memc_gen_time` int(10) unsigned DEFAULT NULL COMMENT '优惠券产生时间',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '无效',
  `memc_isvalid` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '会员优惠券是否当前可用',
  PRIMARY KEY (`memc_code`,`member_id`),
  KEY `ind_memc_gen_orderid` (`memc_gen_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_goods
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_goods`;
CREATE TABLE `car_b2c_member_goods` (
  `gnotify_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `goods_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
  `member_id` mediumint(8) unsigned DEFAULT NULL COMMENT '会员用户名',
  `product_id` mediumint(8) unsigned DEFAULT NULL COMMENT '货品ID',
  `goods_name` varchar(200) DEFAULT '' COMMENT '商品名称',
  `goods_price` decimal(20,3) DEFAULT '0.000' COMMENT '销售价',
  `image_default_id` varchar(32) DEFAULT NULL COMMENT '默认图片',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `cellphone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `status` enum('ready','send','progress') NOT NULL COMMENT '状态',
  `send_time` int(10) unsigned DEFAULT NULL COMMENT '发送时间',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '申请时间',
  `disabled` enum('true','false') DEFAULT 'false',
  `remark` longtext COMMENT '备注',
  `type` enum('fav','sto') DEFAULT NULL COMMENT '类型, 收藏还是缺货',
  `object_type` varchar(100) DEFAULT 'goods' COMMENT '收藏的类型，goods',
  PRIMARY KEY (`gnotify_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_lv
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_lv`;
CREATE TABLE `car_b2c_member_lv` (
  `member_lv_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '等级名称',
  `lv_logo` varchar(255) DEFAULT NULL COMMENT '会员等级LOGO',
  `dis_count` decimal(5,2) NOT NULL DEFAULT '1.00' COMMENT '会员折扣率',
  `pre_id` mediumint(9) DEFAULT NULL COMMENT '前一级别ID',
  `default_lv` enum('0','1') NOT NULL DEFAULT '0' COMMENT '是否默认',
  `deposit_freeze_time` int(11) DEFAULT '0' COMMENT '保证金冻结时间',
  `deposit` int(11) DEFAULT '0' COMMENT '所需保证金金额',
  `more_point` int(11) DEFAULT '1' COMMENT '会员等级积分倍率',
  `lv_type` enum('retail','wholesale','dealer') NOT NULL DEFAULT 'retail' COMMENT '等级类型',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '所需积分',
  `disabled` enum('true','false') DEFAULT 'false',
  `show_other_price` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '查阅其他会员等级价格',
  `order_limit` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会员每次下单限制. 0不限制 1遵守批发规则中的最小起批数量和混批规则中的最小起批数量/金额 2 此等级会员每次下单必须达到',
  `order_limit_price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '每次下单必须达到的金额',
  `lv_remark` text COMMENT '会员等级备注',
  `experience` int(10) NOT NULL DEFAULT '0' COMMENT '经验值',
  `expiretime` int(10) NOT NULL DEFAULT '0' COMMENT '积分过期时间',
  PRIMARY KEY (`member_lv_id`),
  UNIQUE KEY `ind_name` (`name`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_msg
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_msg`;
CREATE TABLE `car_b2c_member_msg` (
  `msg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `for_id` int(11) DEFAULT '0' COMMENT '回复哪个信件',
  `from_id` mediumint(8) unsigned NOT NULL COMMENT '发起会员ID',
  `from_uname` varchar(100) DEFAULT NULL COMMENT '发信者',
  `from_type` int(11) DEFAULT '0' COMMENT '发信类型',
  `to_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '目标会员ID',
  `to_uname` varchar(100) DEFAULT NULL COMMENT '目标会员姓名',
  `subject` varchar(100) NOT NULL COMMENT '消息主题',
  `content` text NOT NULL COMMENT '内容',
  `order_id` bigint(20) DEFAULT '0' COMMENT '订单ID',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '发送时间',
  `to_time` int(10) unsigned DEFAULT NULL COMMENT '发送时间',
  `has_read` enum('true','false') DEFAULT 'false' COMMENT '是否已读',
  `keep_unread` enum('true','false') DEFAULT 'false' COMMENT '保持未读',
  `has_star` enum('true','false') DEFAULT 'false' COMMENT '是否打上星标',
  `has_sent` enum('true','false') DEFAULT 'true' COMMENT '是否发送',
  PRIMARY KEY (`msg_id`),
  KEY `ind_to_id` (`to_id`,`has_read`,`has_sent`),
  KEY `ind_from_id` (`from_id`,`has_read`,`has_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_point
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_point`;
CREATE TABLE `car_b2c_member_point` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分日志ID',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `point` int(10) NOT NULL DEFAULT '0' COMMENT '积分阶段总结',
  `change_point` int(10) NOT NULL DEFAULT '0' COMMENT '改变积分',
  `consume_point` int(10) NOT NULL DEFAULT '0' COMMENT '单笔积分消耗的积分值',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `expiretime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `reason` varchar(50) NOT NULL DEFAULT '' COMMENT '理由',
  `remark` varchar(100) DEFAULT '' COMMENT '备注',
  `related_id` bigint(20) unsigned DEFAULT NULL COMMENT '积分关联对象ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '操作类型',
  `operator` varchar(50) DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_pwdlog
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_pwdlog`;
CREATE TABLE `car_b2c_member_pwdlog` (
  `pwdlog_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_id` mediumint(8) unsigned NOT NULL COMMENT '会员ID',
  `secret` varchar(100) NOT NULL DEFAULT '' COMMENT '临时秘钥',
  `expiretime` int(10) unsigned DEFAULT NULL COMMENT '过期时间',
  `has_used` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '是否使用过, 如果使用过将失效',
  PRIMARY KEY (`pwdlog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_member_systmpl
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_member_systmpl`;
CREATE TABLE `car_b2c_member_systmpl` (
  `tmpl_name` varchar(100) NOT NULL COMMENT '模版名称',
  `content` longtext COMMENT '模板内容',
  `edittime` int(10) NOT NULL COMMENT '编辑时间',
  `active` enum('true','false') DEFAULT 'true' COMMENT '是否激活',
  PRIMARY KEY (`tmpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_members
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_members`;
CREATE TABLE `car_b2c_members` (
  `member_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员用户名',
  `member_lv_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员等级',
  `crm_member_id` mediumint(8) unsigned DEFAULT '0' COMMENT '联通CRM，存储CRM的member_id',
  `name` varchar(50) DEFAULT NULL COMMENT '姓名',
  `point` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `lastname` varchar(50) DEFAULT NULL COMMENT '姓氏',
  `firstname` varchar(50) DEFAULT NULL COMMENT '名字',
  `area` varchar(255) DEFAULT NULL COMMENT '地区',
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `tel` varchar(50) DEFAULT NULL COMMENT '固定电话',
  `email` varchar(200) DEFAULT '' COMMENT 'EMAIL',
  `zip` varchar(20) DEFAULT NULL COMMENT '邮编',
  `order_num` mediumint(8) unsigned DEFAULT '0' COMMENT '订单数',
  `refer_id` varchar(50) DEFAULT NULL COMMENT '来源ID',
  `refer_url` varchar(200) DEFAULT NULL COMMENT '推广来源URL',
  `b_year` smallint(5) unsigned DEFAULT NULL COMMENT '生年',
  `b_month` tinyint(3) unsigned DEFAULT NULL COMMENT '生月',
  `b_day` tinyint(3) unsigned DEFAULT NULL COMMENT '生日',
  `sex` enum('0','1','2') NOT NULL DEFAULT '1' COMMENT '性别',
  `addon` longtext COMMENT '会员额外序列化信息',
  `wedlock` enum('0','1') NOT NULL DEFAULT '0' COMMENT '婚姻状况',
  `education` varchar(30) DEFAULT NULL COMMENT '教育程度',
  `vocation` varchar(50) DEFAULT NULL COMMENT '职业',
  `interest` longtext COMMENT '扩展信息里的爱好',
  `advance` decimal(20,3) unsigned NOT NULL DEFAULT '0.000' COMMENT '会员账户余额',
  `advance_freeze` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '会员预存款冻结金额',
  `point_freeze` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员当前冻结积分(暂时停用)',
  `point_history` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员历史总积分(暂时停用)',
  `score_rate` decimal(5,3) DEFAULT NULL COMMENT '积分折换率',
  `reg_ip` varchar(16) DEFAULT NULL COMMENT '注册时IP地址',
  `regtime` int(10) unsigned DEFAULT NULL COMMENT '注册时间',
  `state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会员验证状态',
  `pay_time` mediumint(8) unsigned DEFAULT NULL COMMENT '上次结算时间',
  `biz_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '上次结算后到现在的所有因商业合作(推广人,代理)而产生的可供结算的金额',
  `fav_tags` longtext COMMENT '会员感兴趣的tag',
  `custom` longtext COMMENT '用户可根据自己的需要定义额外的会员注册信息,这里存的是序列化后的信息目前系统序列化进去的有： industry:工作行业 company:工作单位 co_addr:公司地址 salary:月收入',
  `cur` varchar(20) DEFAULT NULL COMMENT '货币(偏爱货币)',
  `lang` varchar(20) DEFAULT NULL COMMENT '偏好语言',
  `unreadmsg` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '未读信息',
  `disabled` enum('true','false') DEFAULT 'false',
  `remark` text COMMENT '备注',
  `remark_type` varchar(2) NOT NULL DEFAULT 'b1' COMMENT '备注类型',
  `login_count` int(11) NOT NULL DEFAULT '0',
  `experience` int(10) DEFAULT '0' COMMENT '经验值',
  `foreign_id` varchar(255) DEFAULT NULL COMMENT 'foreign_id(弃用',
  `resetpwd` varchar(255) DEFAULT NULL COMMENT '找回密码唯一标示',
  `resetpwdtime` int(10) unsigned DEFAULT NULL COMMENT '找回密码时间',
  `member_refer` varchar(50) DEFAULT 'local' COMMENT '会员来源(弃用)',
  `source` enum('pc','wap','weixin','api') DEFAULT 'pc' COMMENT '平台来源',
  PRIMARY KEY (`member_id`),
  KEY `ind_email` (`email`),
  KEY `ind_regtime` (`regtime`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_cancel_reason
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_cancel_reason`;
CREATE TABLE `car_b2c_order_cancel_reason` (
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `reason_type` enum('0','1','2','3','4','5','6','7') NOT NULL DEFAULT '0' COMMENT '取消原因类型',
  `reason_desc` varchar(150) DEFAULT NULL COMMENT '其他原因',
  `cancel_time` int(10) unsigned DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_coupon_user`;
CREATE TABLE `car_b2c_order_coupon_user` (
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '应用订单号',
  `cpns_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券方案ID',
  `cpns_name` varchar(255) DEFAULT NULL COMMENT '优惠券方案名称',
  `usetime` int(10) unsigned DEFAULT NULL COMMENT '使用时间',
  `memc_code` varchar(255) DEFAULT NULL COMMENT '使用的优惠券号码',
  `cpns_type` enum('0','1','2') DEFAULT NULL COMMENT '优惠券类型0全局 1用户 2外部优惠券',
  PRIMARY KEY (`order_id`,`cpns_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_delivery
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_delivery`;
CREATE TABLE `car_b2c_order_delivery` (
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `dlytype` enum('delivery','reship') NOT NULL DEFAULT 'delivery' COMMENT '单据类型',
  `dly_id` varchar(20) NOT NULL COMMENT '关联单号',
  `items` text COMMENT '货品明细',
  PRIMARY KEY (`order_id`,`dly_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_items
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_items`;
CREATE TABLE `car_b2c_order_items` (
  `item_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单明细ID',
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `obj_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '订单明细对应的商品对象ID, 对应到sdb_b2c_order_objects表',
  `product_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '货品ID',
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `type_id` mediumint(8) unsigned DEFAULT NULL COMMENT '商品类型ID',
  `bn` varchar(40) DEFAULT NULL COMMENT '明细商品的品牌名',
  `name` varchar(200) DEFAULT NULL COMMENT '明细商品的名称',
  `cost` decimal(20,3) DEFAULT NULL COMMENT '明细商品的成本',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '明细商品的销售价(购入价)',
  `g_price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '明细商品的会员价原价',
  `amount` decimal(20,3) DEFAULT NULL COMMENT '明细商品总额',
  `score` mediumint(8) unsigned DEFAULT NULL COMMENT '明细商品积分',
  `weight` mediumint(8) unsigned DEFAULT NULL COMMENT '明细商品重量',
  `nums` float NOT NULL DEFAULT '1' COMMENT '明细商品购买数量',
  `sendnum` float NOT NULL DEFAULT '0' COMMENT '明细商品发货数量',
  `addon` longtext COMMENT '明细商品的规格属性',
  `item_type` enum('product','pkg','gift','adjunct') NOT NULL DEFAULT 'product' COMMENT '明细商品类型',
  PRIMARY KEY (`item_id`),
  KEY `ind_item_bn` (`bn`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_log
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_log`;
CREATE TABLE `car_b2c_order_log` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单日志ID',
  `rel_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '对象ID',
  `op_id` mediumint(8) unsigned DEFAULT NULL COMMENT '操作员ID',
  `op_name` varchar(100) DEFAULT NULL COMMENT '操作人名称',
  `alttime` int(10) unsigned DEFAULT NULL COMMENT '操作时间',
  `bill_type` enum('order','recharge','joinfee','prepaid_recharge') NOT NULL DEFAULT 'order' COMMENT '操作人员姓名',
  `behavior` enum('creates','updates','payments','refunds','delivery','reship','finish','cancel') NOT NULL DEFAULT 'payments' COMMENT '日志记录操作的行为',
  `result` enum('SUCCESS','FAILURE') NOT NULL COMMENT '日志结果',
  `log_text` longtext COMMENT '操作内容',
  `addon` longtext COMMENT '序列化数据',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_objects
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_objects`;
CREATE TABLE `car_b2c_order_objects` (
  `obj_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单商品对象ID',
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `obj_type` varchar(50) NOT NULL DEFAULT '' COMMENT '对象类型',
  `obj_alias` varchar(100) NOT NULL DEFAULT '' COMMENT '对象别名',
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `bn` varchar(40) DEFAULT NULL COMMENT '品牌名',
  `name` varchar(200) DEFAULT NULL COMMENT '商品对象名字',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '商品对象单价',
  `amount` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '商品对象总金额',
  `quantity` float NOT NULL DEFAULT '1' COMMENT '商品对象购买量',
  `weight` mediumint(8) unsigned DEFAULT NULL COMMENT '总重量',
  `score` mediumint(8) unsigned DEFAULT NULL COMMENT '获得积分',
  PRIMARY KEY (`obj_id`),
  KEY `ind_obj_bn` (`bn`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_order_pmt
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_order_pmt`;
CREATE TABLE `car_b2c_order_pmt` (
  `pmt_id` int(8) NOT NULL COMMENT '促销规则id',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单id',
  `product_id` mediumint(8) unsigned DEFAULT NULL COMMENT '商品ID',
  `pmt_type` enum('order','goods','coupon') NOT NULL DEFAULT 'goods' COMMENT '优惠规则类型',
  `pmt_amount` decimal(20,3) NOT NULL DEFAULT '0.000',
  `pmt_tag` longtext,
  `pmt_memo` longtext,
  `pmt_describe` longtext,
  PRIMARY KEY (`pmt_id`,`order_id`,`pmt_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_orders
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_orders`;
CREATE TABLE `car_b2c_orders` (
  `order_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '订单号',
  `total_amount` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '商品默认货币总值',
  `final_amount` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单货币总值, 包含支付价格,税等',
  `pay_status` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0' COMMENT '付款状态',
  `ship_status` enum('0','1','2','3','4') NOT NULL DEFAULT '0' COMMENT '发货状态',
  `is_delivery` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT '是否需要发货',
  `createtime` int(10) unsigned DEFAULT NULL COMMENT '下单时间',
  `last_modified` int(10) unsigned DEFAULT NULL COMMENT '最后更新时间',
  `payment` varchar(100) DEFAULT NULL COMMENT '支付方式',
  `shipping_id` mediumint(8) unsigned DEFAULT NULL COMMENT '配送方式',
  `shipping` varchar(100) DEFAULT NULL COMMENT '配送方式',
  `member_id` mediumint(8) unsigned DEFAULT NULL COMMENT '会员用户名',
  `status` enum('active','dead','finish') NOT NULL DEFAULT 'active' COMMENT '订单状态',
  `confirm` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '确认状态',
  `ship_area` varchar(255) DEFAULT NULL COMMENT '收货地区',
  `ship_name` varchar(50) DEFAULT NULL COMMENT '收货人',
  `weight` decimal(20,3) DEFAULT NULL COMMENT '订单总重量',
  `tostr` longtext COMMENT '订单文字描述',
  `itemnum` mediumint(8) unsigned DEFAULT NULL COMMENT '订单子订单数量',
  `ip` varchar(15) DEFAULT NULL COMMENT 'IP地址',
  `ship_addr` text COMMENT '收货地址',
  `ship_zip` varchar(20) DEFAULT NULL COMMENT '收货人邮编',
  `ship_tel` varchar(50) DEFAULT NULL COMMENT '收货电话',
  `ship_email` varchar(200) DEFAULT NULL COMMENT '收货人email',
  `ship_time` varchar(50) DEFAULT NULL COMMENT '配送时间',
  `ship_mobile` varchar(50) DEFAULT NULL COMMENT '收货人手机',
  `cost_item` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单商品总价格',
  `is_tax` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否要开发票',
  `tax_type` enum('false','personal','company') NOT NULL DEFAULT 'false' COMMENT '发票类型',
  `tax_content` varchar(255) DEFAULT NULL COMMENT '发票内容',
  `cost_tax` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单税率',
  `tax_company` varchar(255) DEFAULT NULL COMMENT '发票抬头',
  `is_protect` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否还有保价费',
  `cost_protect` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '保价费',
  `cost_payment` decimal(20,3) DEFAULT NULL COMMENT '支付费用',
  `currency` varchar(8) DEFAULT NULL COMMENT '订单支付货币',
  `cur_rate` decimal(10,4) DEFAULT '1.0000' COMMENT '订单支付货币汇率',
  `score_u` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单使用积分',
  `score_g` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单获得积分',
  `discount` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '订单减免',
  `pmt_goods` decimal(20,3) DEFAULT NULL COMMENT '商品促销优惠',
  `pmt_order` decimal(20,3) DEFAULT NULL COMMENT '订单促销优惠',
  `payed` decimal(20,3) DEFAULT '0.000' COMMENT '订单支付金额',
  `memo` longtext COMMENT '订单附言',
  `disabled` enum('true','false') DEFAULT 'false',
  `mark_type` varchar(2) NOT NULL DEFAULT 'b1' COMMENT '订单备注图标',
  `mark_text` longtext COMMENT '订单备注',
  `cost_freight` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '配送费用',
  `extend` varchar(255) DEFAULT 'false' COMMENT '订单扩展',
  `order_refer` varchar(20) NOT NULL DEFAULT 'local' COMMENT '订单来源',
  `addon` longtext COMMENT '订单附属信息(序列化)',
  `source` enum('pc','wap','app','weixin') DEFAULT 'pc' COMMENT '平台来源',
  PRIMARY KEY (`order_id`),
  KEY `ind_ship_status` (`ship_status`),
  KEY `ind_pay_status` (`pay_status`),
  KEY `ind_status` (`status`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_last_modified` (`last_modified`),
  KEY `ind_createtime` (`createtime`),
  KEY `idx_order_refer` (`order_refer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_products
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_products`;
CREATE TABLE `car_b2c_products` (
  `product_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '货品ID',
  `goods_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `barcode` varchar(128) DEFAULT NULL COMMENT '条码',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `bn` varchar(30) DEFAULT NULL COMMENT '货号',
  `price` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '销售价格',
  `cost` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '成本价',
  `mktprice` decimal(20,3) DEFAULT NULL COMMENT '市场价',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '货品名称',
  `weight` decimal(20,3) DEFAULT NULL COMMENT '单位重量',
  `unit` varchar(20) DEFAULT NULL COMMENT '单位',
  `store` mediumint(8) unsigned DEFAULT '0' COMMENT '库存',
  `store_place` varchar(255) DEFAULT NULL COMMENT '库位',
  `freez` mediumint(8) unsigned DEFAULT NULL COMMENT '冻结库存',
  `goods_type` enum('normal','bind','gift') NOT NULL DEFAULT 'normal' COMMENT '销售类型',
  `spec_info` varchar(30) DEFAULT NULL COMMENT '规格名称',
  `spec_desc` varchar(30) DEFAULT NULL COMMENT '规格值,序列化',
  `is_default` enum('true','false') NOT NULL DEFAULT 'false',
  `qrcode_image_id` varchar(32) DEFAULT NULL COMMENT '二维码图片ID',
  `uptime` int(10) unsigned DEFAULT NULL COMMENT '录入时间',
  `last_modify` int(10) unsigned DEFAULT NULL COMMENT '最后修改时间',
  `disabled` enum('true','false') DEFAULT 'false',
  `marketable` enum('true','false') NOT NULL DEFAULT 'true' COMMENT '上架',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `ind_bn` (`bn`),
  KEY `ind_goods_id` (`goods_id`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_barcode` (`barcode`),
  KEY `idx_goods_type` (`goods_type`),
  KEY `idx_store` (`store`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_reship
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_reship`;
CREATE TABLE `car_b2c_reship` (
  `reship_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '配送流水号',
  `order_id` varchar(100) DEFAULT NULL COMMENT '订单号',
  `reship_bn` varchar(32) DEFAULT NULL COMMENT '退货流水号',
  `member_id` mediumint(8) unsigned DEFAULT NULL COMMENT '订货会员ID',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '配送费用',
  `is_protect` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '是否保价',
  `delivery` varchar(20) DEFAULT NULL COMMENT '配送方式(货到付款、EMS...)',
  `logi_id` varchar(50) DEFAULT NULL COMMENT '物流公司ID',
  `logi_name` varchar(100) DEFAULT NULL COMMENT '物流公司名称',
  `logi_no` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `ship_name` varchar(50) DEFAULT NULL COMMENT '收货人姓名',
  `ship_area` varchar(255) DEFAULT NULL COMMENT '收货人地区',
  `ship_addr` text COMMENT '收货人地址',
  `ship_zip` varchar(20) DEFAULT NULL COMMENT '收货人邮编',
  `ship_tel` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `ship_mobile` varchar(50) DEFAULT NULL COMMENT '收货人手机',
  `ship_email` varchar(200) DEFAULT NULL COMMENT '收货人Email',
  `t_begin` int(10) unsigned DEFAULT NULL COMMENT '单据生成时间',
  `t_send` int(10) unsigned DEFAULT NULL COMMENT '单据结束时间',
  `t_confirm` int(10) unsigned DEFAULT NULL COMMENT '确认时间',
  `op_name` varchar(50) DEFAULT NULL COMMENT '操作者',
  `status` enum('succ','failed','cancel','lost','progress','timeout','ready') NOT NULL DEFAULT 'ready' COMMENT '状态',
  `memo` longtext COMMENT '备注',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '无效',
  PRIMARY KEY (`reship_id`),
  KEY `ind_disabled` (`disabled`),
  KEY `ind_logi_no` (`logi_no`)
) ENGINE=InnoDB AUTO_INCREMENT=142881660610148101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_reship_items
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_reship_items`;
CREATE TABLE `car_b2c_reship_items` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '发/退货单明细ID',
  `reship_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '发/退货单ID',
  `order_item_id` mediumint(8) unsigned DEFAULT '0' COMMENT '订单明细ID',
  `item_type` enum('goods','gift','pkg','adjunct') NOT NULL DEFAULT 'goods' COMMENT '退/换货商品类型',
  `product_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '货品ID',
  `product_bn` varchar(30) DEFAULT NULL COMMENT '货品品牌名',
  `product_name` varchar(200) DEFAULT NULL COMMENT '货品名',
  `number` float NOT NULL DEFAULT '0' COMMENT '退/换货数量',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_spec_values
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_spec_values`;
CREATE TABLE `car_b2c_spec_values` (
  `spec_value_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格值ID',
  `spec_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '规格ID',
  `spec_value` varchar(100) NOT NULL DEFAULT '' COMMENT '规格值',
  `alias` varchar(255) DEFAULT '' COMMENT '规格别名',
  `spec_image` char(32) DEFAULT '' COMMENT '规格图片',
  `p_order` mediumint(8) unsigned NOT NULL DEFAULT '50' COMMENT '排序',
  PRIMARY KEY (`spec_value_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_specification
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_specification`;
CREATE TABLE `car_b2c_specification` (
  `spec_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规格id',
  `spec_name` varchar(50) NOT NULL DEFAULT '' COMMENT '规格名称',
  `spec_show_type` enum('select','flat') NOT NULL DEFAULT 'flat' COMMENT '显示方式',
  `spec_type` enum('text','image') NOT NULL DEFAULT 'text' COMMENT '类型',
  `spec_memo` varchar(50) NOT NULL DEFAULT '' COMMENT '规格备注',
  `p_order` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false',
  `alias` varchar(255) DEFAULT '' COMMENT '规格别名',
  PRIMARY KEY (`spec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_b2c_type_brand
-- ----------------------------
DROP TABLE IF EXISTS `car_b2c_type_brand`;
CREATE TABLE `car_b2c_type_brand` (
  `type_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品类型ID',
  `brand_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `brand_order` mediumint(8) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`type_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_banner_dimension
-- ----------------------------
DROP TABLE IF EXISTS `car_banner_dimension`;
CREATE TABLE `car_banner_dimension` (
  `dimension_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统编号',
  `channel` enum('wap','web','app') NOT NULL COMMENT '所属渠道',
  `page_type` tinyint(3) NOT NULL COMMENT '-1:所有页面;0:首页;1:一级类页面;2:二级类页面;3:三级类页面;4:品牌页面;5:产品详细页面;6:促销页面;7:登录、注册页面;8:下单页面',
  `position` varchar(30) NOT NULL COMMENT '页面中广告具体位置',
  `position_no` mediumint(3) unsigned NOT NULL COMMENT '页面中广告位具体位置编号：如10,21,22,23,31,32',
  `width` mediumint(5) unsigned NOT NULL DEFAULT '400' COMMENT '根据设置的宽度正确显示',
  `height` mediumint(5) unsigned NOT NULL DEFAULT '300' COMMENT '根据设置的高度正确显示',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `creator` mediumint(5) unsigned NOT NULL COMMENT '创建人',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '编辑时间',
  `updater` mediumint(5) unsigned DEFAULT NULL COMMENT '编辑人',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否失效',
  PRIMARY KEY (`dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_banner_info
-- ----------------------------
DROP TABLE IF EXISTS `car_banner_info`;
CREATE TABLE `car_banner_info` (
  `info_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '内容信息ID',
  `banner_type` enum('V','H','T','F','A','I') NOT NULL COMMENT '广告类型 I:Image;F:Flash;A:活动专题',
  `description` varchar(300) DEFAULT NULL COMMENT '描述信息',
  `title` varchar(100) DEFAULT NULL COMMENT '鼠标一道上面显示的内容',
  `text` text COMMENT '对于BannerType为Text和Html代码，分别是显示的文本和Html代码。其他情况无效',
  `url` varchar(500) DEFAULT NULL COMMENT 'BannerType为Flash和Image的Url。其他情况无效',
  `link` varchar(500) DEFAULT NULL COMMENT 'BannerType为”Html代码”时无效，其他情况点击banner所到达的url',
  `onclick` varchar(1000) DEFAULT NULL COMMENT 'BannerType为Flash或者Image时，点击banner所执行的javascript脚本。需要包含<script></script>标签',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `creator` mediumint(5) unsigned NOT NULL COMMENT '创建人',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '编辑时间',
  `updater` mediumint(5) unsigned DEFAULT NULL COMMENT '编辑人',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否失效',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_banner_location
-- ----------------------------
DROP TABLE IF EXISTS `car_banner_location`;
CREATE TABLE `car_banner_location` (
  `location_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统编号',
  `info_id` mediumint(8) unsigned NOT NULL COMMENT 'BannerInfo关联的外键',
  `dimension_id` mediumint(8) unsigned NOT NULL COMMENT 'BannerDimension关联的外键',
  `page_id` tinyint(3) unsigned NOT NULL COMMENT '类别ID：如大类、中类、小类，品牌ID，其他促销页面，对应其他促销ID，0表示首页，-1表示所有同PageType的页面',
  `except_page_id` varchar(500) DEFAULT NULL COMMENT '排除的ID',
  `p_order` mediumint(5) unsigned NOT NULL DEFAULT '99' COMMENT '数字越大优先级越高',
  `relative_tags` varchar(500) DEFAULT NULL COMMENT '相关联的Tag列表',
  `start_time` int(11) unsigned NOT NULL COMMENT '广告设置生效开始时间',
  `end_time` int(11) unsigned NOT NULL COMMENT '广告设置生效结束时间',
  `retio` float(5,2) DEFAULT NULL COMMENT '广告显示比例',
  `status` enum('D','A') NOT NULL DEFAULT 'D' COMMENT '广告显示状态 A:表示有效,D:表示无效',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `creator` mediumint(5) unsigned NOT NULL COMMENT '创建人',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '编辑时间',
  `updater` mediumint(5) unsigned DEFAULT NULL COMMENT '编辑人',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否失效',
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_brand_special
-- ----------------------------
DROP TABLE IF EXISTS `car_brand_special`;
CREATE TABLE `car_brand_special` (
  `special_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '品牌特卖ID',
  `brand_id` mediumint(8) unsigned NOT NULL COMMENT '品牌id',
  `brand_name` varchar(50) NOT NULL COMMENT '品牌名称',
  `special_name` varchar(50) NOT NULL COMMENT '品牌特卖名称',
  `brief` varchar(128) NOT NULL COMMENT '特卖活动',
  `start_time` int(11) unsigned NOT NULL COMMENT '开始时间',
  `end_time` int(11) unsigned NOT NULL COMMENT '结束时间',
  `img_url` varchar(128) NOT NULL COMMENT '特卖商品图片',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否存在',
  PRIMARY KEY (`special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_ectools_order_bills
-- ----------------------------
DROP TABLE IF EXISTS `car_ectools_order_bills`;
CREATE TABLE `car_ectools_order_bills` (
  `rel_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `bill_type` enum('payments','refunds') NOT NULL DEFAULT 'payments' COMMENT '单据类型',
  `pay_object` enum('order','recharge','joinfee','prepaid_recharge') NOT NULL DEFAULT 'order' COMMENT '支付类型',
  `bill_id` varchar(20) NOT NULL COMMENT '关联退款/付款单号',
  `money` decimal(20,3) DEFAULT NULL COMMENT '金额',
  PRIMARY KEY (`rel_id`,`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_ectools_payments
-- ----------------------------
DROP TABLE IF EXISTS `car_ectools_payments`;
CREATE TABLE `car_ectools_payments` (
  `payment_id` varchar(20) NOT NULL DEFAULT '' COMMENT '支付单号',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支付金额',
  `cur_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支付货币金额',
  `member_id` varchar(100) DEFAULT NULL COMMENT '会员用户名',
  `status` enum('succ','failed','cancel','error','invalid','progress','timeout','ready') NOT NULL DEFAULT 'ready' COMMENT '支付状态',
  `pay_name` varchar(100) DEFAULT NULL,
  `pay_type` enum('online','offline','deposit') NOT NULL DEFAULT 'online' COMMENT '支付类型',
  `t_payed` int(10) unsigned DEFAULT NULL COMMENT '支付完成时间',
  `op_id` mediumint(8) unsigned DEFAULT NULL COMMENT '操作员',
  `payment_bn` varchar(32) DEFAULT '' COMMENT '支付单唯一编号',
  `account` varchar(50) DEFAULT NULL COMMENT '收款账号',
  `bank` varchar(50) DEFAULT NULL COMMENT '收款银行',
  `pay_account` varchar(50) DEFAULT NULL COMMENT '支付账户',
  `currency` varchar(10) DEFAULT NULL COMMENT '货币',
  `paycost` decimal(20,3) DEFAULT NULL COMMENT '支付网关费用',
  `pay_app_id` varchar(100) NOT NULL DEFAULT '0' COMMENT '支付方式名称',
  `pay_ver` varchar(50) DEFAULT NULL COMMENT '支付版本号',
  `ip` varchar(20) DEFAULT NULL COMMENT '支付IP',
  `t_begin` int(10) unsigned DEFAULT NULL COMMENT '支付开始时间',
  `t_confirm` int(10) unsigned DEFAULT NULL COMMENT '支付确认时间',
  `memo` longtext COMMENT '支付注释',
  `return_url` varchar(100) DEFAULT NULL COMMENT '支付返回地址',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '支付单状态',
  `trade_no` varchar(30) DEFAULT NULL COMMENT '支付单交易编号',
  `thirdparty_account` varchar(50) DEFAULT '' COMMENT '第三方支付账户',
  PRIMARY KEY (`payment_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_ectools_refunds
-- ----------------------------
DROP TABLE IF EXISTS `car_ectools_refunds`;
CREATE TABLE `car_ectools_refunds` (
  `refund_id` varchar(20) NOT NULL DEFAULT '' COMMENT '退款单号',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000',
  `cur_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支付金额',
  `member_id` varchar(100) DEFAULT NULL COMMENT '会员用户名',
  `account` varchar(50) DEFAULT NULL COMMENT '收款账号',
  `bank` varchar(50) DEFAULT NULL COMMENT '收款银行',
  `pay_account` varchar(50) DEFAULT NULL COMMENT '支付账户',
  `currency` varchar(10) DEFAULT NULL COMMENT '货币',
  `paycost` decimal(20,3) DEFAULT NULL COMMENT '支付网关费用',
  `pay_type` enum('online','offline','deposit') NOT NULL DEFAULT 'online' COMMENT '支付类型',
  `status` enum('succ','failed','cancel','error','invalid','progress','timeout','ready') NOT NULL DEFAULT 'ready' COMMENT '支付状态',
  `pay_name` varchar(100) DEFAULT NULL,
  `pay_ver` varchar(50) DEFAULT NULL COMMENT '支付版本号',
  `op_id` mediumint(8) unsigned DEFAULT NULL COMMENT '操作员',
  `refund_bn` varchar(32) DEFAULT '' COMMENT '退款唯一单号',
  `pay_app_id` varchar(100) NOT NULL DEFAULT '0' COMMENT '支付方式',
  `t_begin` int(10) unsigned DEFAULT NULL COMMENT '支付开始时间',
  `t_payed` int(10) unsigned DEFAULT NULL COMMENT '支付完成时间',
  `t_confirm` int(10) unsigned DEFAULT NULL COMMENT '支付确认时间',
  `memo` longtext COMMENT '备注',
  `disabled` enum('true','false') DEFAULT 'false',
  `trade_no` varchar(30) DEFAULT NULL COMMENT '退款单交易编号',
  PRIMARY KEY (`refund_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_ectools_regions
-- ----------------------------
DROP TABLE IF EXISTS `car_ectools_regions`;
CREATE TABLE `car_ectools_regions` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '区域序号',
  `local_name` varchar(50) NOT NULL DEFAULT '' COMMENT '地区名称',
  `package` varchar(20) NOT NULL DEFAULT '' COMMENT '地区包的类别, 中国/外国等. 中国大陆的编号目前为mainland',
  `p_region_id` int(10) unsigned DEFAULT NULL COMMENT '上一级地区的序号',
  `region_path` varchar(255) DEFAULT NULL COMMENT '序号层级排列结构',
  `region_grade` mediumint(8) unsigned DEFAULT NULL COMMENT '地区层级',
  `p_1` varchar(50) DEFAULT NULL COMMENT '额外参数1',
  `p_2` varchar(50) DEFAULT NULL COMMENT '额外参数2',
  `ordernum` mediumint(8) unsigned DEFAULT NULL COMMENT '排序',
  `disabled` enum('true','false') DEFAULT 'false',
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `ind_p_regions_id` (`p_region_id`,`region_grade`,`local_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3267 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_image_image
-- ----------------------------
DROP TABLE IF EXISTS `car_image_image`;
CREATE TABLE `car_image_image` (
  `image_id` char(32) NOT NULL COMMENT '图片ID',
  `ident` varchar(200) NOT NULL,
  `url` varchar(200) NOT NULL COMMENT '网址',
  `l_ident` varchar(200) DEFAULT NULL COMMENT '大图唯一标识',
  `l_url` varchar(200) DEFAULT NULL COMMENT '大图URL地址',
  `m_ident` varchar(200) DEFAULT NULL COMMENT '中图唯一标识',
  `m_url` varchar(200) DEFAULT NULL COMMENT '中图URL地址',
  `s_ident` varchar(200) DEFAULT NULL COMMENT '小图唯一标识',
  `s_url` varchar(200) DEFAULT NULL COMMENT '小图URL地址',
  `last_modified` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_image_image_attach
-- ----------------------------
DROP TABLE IF EXISTS `car_image_image_attach`;
CREATE TABLE `car_image_image_attach` (
  `attach_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '图片关联表ID',
  `target_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '对象id-外键',
  `target_type` varchar(20) NOT NULL DEFAULT '0' COMMENT '对象类型',
  `image_id` char(32) NOT NULL DEFAULT '0' COMMENT '图片的主键-外键关联image表',
  `last_modified` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attach_id`),
  KEY `index_1` (`target_id`,`target_type`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_pam_members
-- ----------------------------
DROP TABLE IF EXISTS `car_pam_members`;
CREATE TABLE `car_pam_members` (
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '账户序号ID',
  `login_account` varchar(100) NOT NULL COMMENT '登录名',
  `login_type` enum('local','mobile','email') NOT NULL DEFAULT 'local' COMMENT '账户类型',
  `login_password` varchar(32) NOT NULL COMMENT '登录密码',
  `password_account` varchar(100) NOT NULL COMMENT '登录密码加密所用账号',
  `disabled` enum('true','false') DEFAULT 'false',
  `createtime` int(10) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`member_id`,`login_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_recommend_dimension
-- ----------------------------
DROP TABLE IF EXISTS `car_recommend_dimension`;
CREATE TABLE `car_recommend_dimension` (
  `dimension_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统编号',
  `channel` enum('app','wap','web') NOT NULL COMMENT '所属渠道',
  `page_type` tinyint(3) unsigned NOT NULL COMMENT '0:所有页面;1:首页;2:一级类页面;3:二级类页面;4:三级类页面;5:品牌页面;6:产品详细页面;7:促销页面;8:登录、注册页面;9:下单页面',
  `position` varchar(30) NOT NULL COMMENT '页面中广告具体位置',
  `position_no` mediumint(3) unsigned NOT NULL COMMENT '页面中广告位具体位置编号：如10,21,22,23,31,32',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `creator` mediumint(5) unsigned NOT NULL COMMENT '创建人',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '编辑时间',
  `updater` mediumint(5) unsigned DEFAULT NULL COMMENT '编辑人',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否失效',
  PRIMARY KEY (`dimension_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for car_recommend_loaction
-- ----------------------------
DROP TABLE IF EXISTS `car_recommend_loaction`;
CREATE TABLE `car_recommend_loaction` (
  `location_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '系统编号',
  `dimension_id` mediumint(8) unsigned NOT NULL COMMENT 'RecommendDimension关联外键',
  `goods_id` bigint(20) unsigned NOT NULL COMMENT '商品编号',
  `title` varchar(200) DEFAULT NULL COMMENT '推荐促销语',
  `p_order` mediumint(5) unsigned NOT NULL DEFAULT '99' COMMENT '数字越大优先级越高',
  `start_time` int(11) unsigned NOT NULL COMMENT '设置生效开始时间',
  `end_time` int(11) unsigned NOT NULL COMMENT '设置生效结束时间',
  `status` enum('D','A') NOT NULL DEFAULT 'A' COMMENT '显示状态 A:表示有效,D:表示无效',
  `create_time` int(11) unsigned NOT NULL COMMENT '创建时间',
  `creator` mediumint(5) unsigned NOT NULL COMMENT '创建人',
  `update_time` int(11) unsigned DEFAULT NULL COMMENT '编辑人',
  `updater` mediumint(5) unsigned DEFAULT NULL COMMENT '编辑人',
  `disabled` enum('false','true') NOT NULL DEFAULT 'false' COMMENT '是否失效',
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
