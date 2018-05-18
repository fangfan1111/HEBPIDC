SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `sys_attachment`
-- ----------------------------
CREATE TABLE `sys_attachment` (
  `id` bigint(18) NOT NULL,
  `file_name` varchar(200) DEFAULT NULL COMMENT '文件名称',
  `save_name` varchar(200) DEFAULT NULL COMMENT '保存名称',
  `extention` varchar(10) DEFAULT NULL COMMENT '后缀',
  `file_size` varchar(10) DEFAULT NULL COMMENT '文件大小',
  `order_no` int(11) DEFAULT NULL COMMENT '排序',
  `object_id` varchar(32) DEFAULT NULL COMMENT '对象ID',
  `save_path` varchar(500) NOT NULL COMMENT '保存路径',
  `classify_info` varchar(50) DEFAULT NULL COMMENT '业务分类',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_attachment
-- ----------------------------
