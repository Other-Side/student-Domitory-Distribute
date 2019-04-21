/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : dormitory

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2019-04-06 14:15:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `careerplan`
-- ----------------------------
DROP TABLE IF EXISTS `careerplan`;
CREATE TABLE `careerplan` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of careerplan
-- ----------------------------
INSERT INTO `careerplan` VALUES ('2', '创业优先');
INSERT INTO `careerplan` VALUES ('3', '开心优先');
INSERT INTO `careerplan` VALUES ('1', '成绩优先');

-- ----------------------------
-- Table structure for `class`
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES ('1', '班级a');
INSERT INTO `class` VALUES ('2', '班级b');
INSERT INTO `class` VALUES ('3', '班级c');
INSERT INTO `class` VALUES ('4', '班级d');
INSERT INTO `class` VALUES ('5', '班级e');
INSERT INTO `class` VALUES ('6', '班级f');
INSERT INTO `class` VALUES ('7', '班级g');
INSERT INTO `class` VALUES ('8', '班级h');
INSERT INTO `class` VALUES ('9', '班级i');

-- ----------------------------
-- Table structure for `hobby`
-- ----------------------------
DROP TABLE IF EXISTS `hobby`;
CREATE TABLE `hobby` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hobby
-- ----------------------------
INSERT INTO `hobby` VALUES ('2', '篮球');
INSERT INTO `hobby` VALUES ('1', '羽毛球');
INSERT INTO `hobby` VALUES ('3', '跑步');

-- ----------------------------
-- Table structure for `major`
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('1', '专业a');
INSERT INTO `major` VALUES ('2', '专业b');
INSERT INTO `major` VALUES ('3', '专业c');
INSERT INTO `major` VALUES ('4', '专业d');
INSERT INTO `major` VALUES ('5', '专业f');

-- ----------------------------
-- Table structure for `majortoclass`
-- ----------------------------
DROP TABLE IF EXISTS `majortoclass`;
CREATE TABLE `majortoclass` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `major` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `class` (`class`),
  KEY `major` (`major`),
  CONSTRAINT `majortoclass_ibfk_1` FOREIGN KEY (`class`) REFERENCES `class` (`value`),
  CONSTRAINT `majortoclass_ibfk_2` FOREIGN KEY (`major`) REFERENCES `major` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of majortoclass
-- ----------------------------
INSERT INTO `majortoclass` VALUES ('1', '专业a', '班级a');
INSERT INTO `majortoclass` VALUES ('2', '专业a', '班级b');
INSERT INTO `majortoclass` VALUES ('3', '专业a', '班级c');
INSERT INTO `majortoclass` VALUES ('4', '专业b', '班级d');
INSERT INTO `majortoclass` VALUES ('5', '专业b', '班级e');
INSERT INTO `majortoclass` VALUES ('6', '专业c', '班级f');
INSERT INTO `majortoclass` VALUES ('7', '专业c', '班级g');
INSERT INTO `majortoclass` VALUES ('8', '专业d', '班级h');
INSERT INTO `majortoclass` VALUES ('9', '专业f', '班级i');

-- ----------------------------
-- Table structure for `routine`
-- ----------------------------
DROP TABLE IF EXISTS `routine`;
CREATE TABLE `routine` (
  `key` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of routine
-- ----------------------------
INSERT INTO `routine` VALUES ('2', '夜猫子');
INSERT INTO `routine` VALUES ('3', '早鸟');
INSERT INTO `routine` VALUES ('1', '正常');

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `name` varchar(255) DEFAULT NULL,
  `num` varchar(255) NOT NULL,
  `gentle` varchar(255) DEFAULT NULL,
  `academy` varchar(255) DEFAULT NULL,
  `major` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `careerPlan` varchar(255) DEFAULT NULL,
  `hobby` varchar(255) DEFAULT NULL,
  `routine` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `major` (`major`),
  KEY `class` (`class`),
  KEY `hobby` (`hobby`),
  KEY `routine` (`routine`),
  KEY `student_ibfk_6` (`careerPlan`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`major`) REFERENCES `major` (`value`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`class`) REFERENCES `class` (`value`),
  CONSTRAINT `student_ibfk_4` FOREIGN KEY (`hobby`) REFERENCES `hobby` (`value`),
  CONSTRAINT `student_ibfk_5` FOREIGN KEY (`routine`) REFERENCES `routine` (`value`),
  CONSTRAINT `student_ibfk_6` FOREIGN KEY (`careerPlan`) REFERENCES `careerplan` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('155360000', '155360000', '男', '学院1', '专业a', '班级a', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360001', '155360001', '男', '学院1', '专业c', '班级f', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360002', '155360002', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360003', '155360003', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360004', '155360004', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360005', '155360005', '男', '学院1', '专业a', '班级a', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360006', '155360006', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360007', '155360007', '男', '学院1', '专业a', '班级b', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360008', '155360008', '男', '学院1', '专业c', '班级f', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360009', '155360009', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360010', '155360010', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360011', '155360011', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360012', '155360012', '男', '学院1', '专业b', '班级d', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360013', '155360013', '男', '学院1', '专业a', '班级c', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360014', '155360014', '男', '学院1', '专业c', '班级g', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360015', '155360015', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360016', '155360016', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360017', '155360017', '男', '学院1', '专业a', '班级a', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360018', '155360018', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360019', '155360019', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360020', '155360020', '男', '学院1', '专业c', '班级f', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360021', '155360021', '男', '学院1', '专业b', '班级e', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360022', '155360022', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360023', '155360023', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360024', '155360024', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360025', '155360025', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360026', '155360026', '男', '学院1', '专业b', '班级d', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360027', '155360027', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360028', '155360028', '男', '学院1', '专业b', '班级d', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360029', '155360029', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360030', '155360030', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360031', '155360031', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360032', '155360032', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360033', '155360033', '男', '学院1', '专业a', '班级a', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360034', '155360034', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360035', '155360035', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360036', '155360036', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360037', '155360037', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360038', '155360038', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360039', '155360039', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360040', '155360040', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360041', '155360041', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360042', '155360042', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360043', '155360043', '男', '学院1', '专业a', '班级c', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360044', '155360044', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360045', '155360045', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360046', '155360046', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360047', '155360047', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360048', '155360048', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360049', '155360049', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360050', '155360050', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360051', '155360051', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360052', '155360052', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360053', '155360053', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360054', '155360054', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360055', '155360055', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360056', '155360056', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360057', '155360057', '男', '学院1', '专业a', '班级b', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360058', '155360058', '男', '学院1', '专业a', '班级a', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360059', '155360059', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360060', '155360060', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360061', '155360061', '男', '学院1', '专业a', '班级b', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360062', '155360062', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360063', '155360063', '男', '学院1', '专业b', '班级d', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360064', '155360064', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360065', '155360065', '男', '学院1', '专业a', '班级a', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360066', '155360066', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360067', '155360067', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360068', '155360068', '男', '学院1', '专业b', '班级e', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360069', '155360069', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360070', '155360070', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360071', '155360071', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360072', '155360072', '男', '学院1', '专业c', '班级f', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360073', '155360073', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360074', '155360074', '男', '学院1', '专业a', '班级c', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360075', '155360075', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360076', '155360076', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360077', '155360077', '男', '学院1', '专业c', '班级g', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360078', '155360078', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360079', '155360079', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360080', '155360080', '男', '学院1', '专业c', '班级f', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360081', '155360081', '男', '学院1', '专业a', '班级a', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360082', '155360082', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360083', '155360083', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360084', '155360084', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360085', '155360085', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360086', '155360086', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360087', '155360087', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360088', '155360088', '男', '学院1', '专业c', '班级g', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360089', '155360089', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360090', '155360090', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360091', '155360091', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360092', '155360092', '男', '学院1', '专业a', '班级a', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360093', '155360093', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360094', '155360094', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360095', '155360095', '男', '学院1', '专业a', '班级a', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360096', '155360096', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360097', '155360097', '男', '学院1', '专业c', '班级g', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360098', '155360098', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360099', '155360099', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360100', '155360100', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360101', '155360101', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360102', '155360102', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360103', '155360103', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360104', '155360104', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360105', '155360105', '男', '学院1', '专业a', '班级b', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360106', '155360106', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360107', '155360107', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360108', '155360108', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360109', '155360109', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360110', '155360110', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360111', '155360111', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360112', '155360112', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360113', '155360113', '男', '学院1', '专业a', '班级c', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360114', '155360114', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360115', '155360115', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360116', '155360116', '男', '学院1', '专业c', '班级f', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360117', '155360117', '男', '学院1', '专业a', '班级a', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360118', '155360118', '男', '学院1', '专业b', '班级d', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360119', '155360119', '男', '学院1', '专业c', '班级g', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360120', '155360120', '男', '学院1', '专业b', '班级d', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360121', '155360121', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360122', '155360122', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360123', '155360123', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360124', '155360124', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360125', '155360125', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360126', '155360126', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360127', '155360127', '男', '学院1', '专业b', '班级d', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360128', '155360128', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360129', '155360129', '男', '学院1', '专业b', '班级e', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360130', '155360130', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360131', '155360131', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360132', '155360132', '男', '学院1', '专业b', '班级e', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360133', '155360133', '男', '学院1', '专业a', '班级a', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360134', '155360134', '男', '学院1', '专业b', '班级e', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360135', '155360135', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360136', '155360136', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360137', '155360137', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360138', '155360138', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360139', '155360139', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360140', '155360140', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360141', '155360141', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360142', '155360142', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360143', '155360143', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360144', '155360144', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360145', '155360145', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360146', '155360146', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360147', '155360147', '男', '学院1', '专业a', '班级b', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360148', '155360148', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360149', '155360149', '男', '学院1', '专业a', '班级b', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360150', '155360150', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360151', '155360151', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360152', '155360152', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360153', '155360153', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360154', '155360154', '男', '学院1', '专业a', '班级b', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360155', '155360155', '男', '学院1', '专业b', '班级e', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360156', '155360156', '男', '学院1', '专业c', '班级f', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360157', '155360157', '男', '学院1', '专业a', '班级a', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360158', '155360158', '男', '学院1', '专业b', '班级e', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360159', '155360159', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360160', '155360160', '男', '学院1', '专业a', '班级c', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360161', '155360161', '男', '学院1', '专业b', '班级d', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360162', '155360162', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360163', '155360163', '男', '学院1', '专业c', '班级f', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360164', '155360164', '男', '学院1', '专业a', '班级a', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360165', '155360165', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360166', '155360166', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360167', '155360167', '男', '学院1', '专业c', '班级f', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360168', '155360168', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360169', '155360169', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360170', '155360170', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360171', '155360171', '男', '学院1', '专业a', '班级b', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360172', '155360172', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360173', '155360173', '男', '学院1', '专业c', '班级f', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360174', '155360174', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360175', '155360175', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360176', '155360176', '男', '学院1', '专业a', '班级a', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360177', '155360177', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360178', '155360178', '男', '学院1', '专业c', '班级f', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360179', '155360179', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360180', '155360180', '男', '学院1', '专业a', '班级b', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360181', '155360181', '男', '学院1', '专业c', '班级f', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360182', '155360182', '男', '学院1', '专业a', '班级c', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360183', '155360183', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360184', '155360184', '男', '学院1', '专业b', '班级d', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360185', '155360185', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360186', '155360186', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360187', '155360187', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360188', '155360188', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360189', '155360189', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360190', '155360190', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360191', '155360191', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360192', '155360192', '男', '学院1', '专业b', '班级d', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360193', '155360193', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360194', '155360194', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360195', '155360195', '男', '学院1', '专业c', '班级g', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360196', '155360196', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360197', '155360197', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360198', '155360198', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360199', '155360199', '男', '学院1', '专业c', '班级g', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360200', '155360200', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360201', '155360201', '男', '学院1', '专业a', '班级a', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360202', '155360202', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360203', '155360203', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360204', '155360204', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360205', '155360205', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360206', '155360206', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360207', '155360207', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360208', '155360208', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360209', '155360209', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360210', '155360210', '男', '学院1', '专业b', '班级d', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360211', '155360211', '男', '学院1', '专业a', '班级a', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360212', '155360212', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360213', '155360213', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360214', '155360214', '男', '学院1', '专业b', '班级d', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360215', '155360215', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360216', '155360216', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360217', '155360217', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360218', '155360218', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360219', '155360219', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360220', '155360220', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360221', '155360221', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360222', '155360222', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360223', '155360223', '男', '学院1', '专业a', '班级c', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360224', '155360224', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360225', '155360225', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360226', '155360226', '男', '学院1', '专业c', '班级f', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360227', '155360227', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360228', '155360228', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360229', '155360229', '男', '学院1', '专业b', '班级d', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360230', '155360230', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360231', '155360231', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360232', '155360232', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360233', '155360233', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360234', '155360234', '男', '学院1', '专业b', '班级d', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360235', '155360235', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360236', '155360236', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360237', '155360237', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360238', '155360238', '男', '学院1', '专业c', '班级f', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360239', '155360239', '男', '学院1', '专业a', '班级b', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360240', '155360240', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360241', '155360241', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360242', '155360242', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360243', '155360243', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360244', '155360244', '男', '学院1', '专业b', '班级d', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360245', '155360245', '男', '学院1', '专业b', '班级d', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360246', '155360246', '男', '学院1', '专业b', '班级e', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360247', '155360247', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360248', '155360248', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360249', '155360249', '男', '学院1', '专业a', '班级c', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360250', '155360250', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360251', '155360251', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360252', '155360252', '男', '学院1', '专业c', '班级f', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360253', '155360253', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360254', '155360254', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360255', '155360255', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360256', '155360256', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360257', '155360257', '男', '学院1', '专业a', '班级a', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360258', '155360258', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360259', '155360259', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360260', '155360260', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360261', '155360261', '男', '学院1', '专业a', '班级a', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360262', '155360262', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360263', '155360263', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360264', '155360264', '男', '学院1', '专业c', '班级g', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360265', '155360265', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360266', '155360266', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360267', '155360267', '男', '学院1', '专业a', '班级a', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360268', '155360268', '男', '学院1', '专业a', '班级a', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360269', '155360269', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360270', '155360270', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360271', '155360271', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360272', '155360272', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360273', '155360273', '男', '学院1', '专业b', '班级e', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360274', '155360274', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360275', '155360275', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360276', '155360276', '男', '学院1', '专业a', '班级a', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360277', '155360277', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360278', '155360278', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360279', '155360279', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360280', '155360280', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360281', '155360281', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360282', '155360282', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360283', '155360283', '男', '学院1', '专业c', '班级g', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360284', '155360284', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360285', '155360285', '男', '学院1', '专业a', '班级b', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360286', '155360286', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360287', '155360287', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360288', '155360288', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360289', '155360289', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360290', '155360290', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360291', '155360291', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360292', '155360292', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360293', '155360293', '男', '学院1', '专业b', '班级e', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360294', '155360294', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360295', '155360295', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360296', '155360296', '男', '学院1', '专业a', '班级a', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360297', '155360297', '男', '学院1', '专业b', '班级e', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360298', '155360298', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360299', '155360299', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360300', '155360300', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360301', '155360301', '男', '学院1', '专业b', '班级e', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360302', '155360302', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360303', '155360303', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360304', '155360304', '男', '学院1', '专业a', '班级c', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360305', '155360305', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360306', '155360306', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360307', '155360307', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360308', '155360308', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360309', '155360309', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360310', '155360310', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360311', '155360311', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360312', '155360312', '男', '学院1', '专业a', '班级b', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360313', '155360313', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360314', '155360314', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360315', '155360315', '男', '学院1', '专业c', '班级f', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360316', '155360316', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360317', '155360317', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360318', '155360318', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360319', '155360319', '男', '学院1', '专业a', '班级b', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360320', '155360320', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360321', '155360321', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360322', '155360322', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360323', '155360323', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360324', '155360324', '男', '学院1', '专业c', '班级f', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360325', '155360325', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360326', '155360326', '男', '学院1', '专业c', '班级f', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360327', '155360327', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360328', '155360328', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360329', '155360329', '男', '学院1', '专业b', '班级e', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360330', '155360330', '男', '学院1', '专业b', '班级e', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360331', '155360331', '男', '学院1', '专业a', '班级b', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360332', '155360332', '男', '学院1', '专业a', '班级b', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360333', '155360333', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360334', '155360334', '男', '学院1', '专业a', '班级c', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360335', '155360335', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360336', '155360336', '男', '学院1', '专业a', '班级b', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360337', '155360337', '男', '学院1', '专业b', '班级e', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360338', '155360338', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360339', '155360339', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360340', '155360340', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360341', '155360341', '男', '学院1', '专业a', '班级a', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360342', '155360342', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360343', '155360343', '男', '学院1', '专业b', '班级e', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360344', '155360344', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360345', '155360345', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360346', '155360346', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360347', '155360347', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360348', '155360348', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360349', '155360349', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360350', '155360350', '男', '学院1', '专业a', '班级c', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360351', '155360351', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360352', '155360352', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360353', '155360353', '男', '学院1', '专业a', '班级c', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360354', '155360354', '男', '学院1', '专业b', '班级e', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360355', '155360355', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360356', '155360356', '男', '学院1', '专业c', '班级f', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360357', '155360357', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360358', '155360358', '男', '学院1', '专业a', '班级c', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360359', '155360359', '男', '学院1', '专业a', '班级c', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360360', '155360360', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360361', '155360361', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360362', '155360362', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360363', '155360363', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360364', '155360364', '男', '学院1', '专业c', '班级g', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360365', '155360365', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360366', '155360366', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360367', '155360367', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360368', '155360368', '男', '学院1', '专业b', '班级e', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360369', '155360369', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360370', '155360370', '男', '学院1', '专业b', '班级d', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360371', '155360371', '男', '学院1', '专业a', '班级a', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360372', '155360372', '男', '学院1', '专业a', '班级a', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360373', '155360373', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360374', '155360374', '男', '学院1', '专业a', '班级b', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360375', '155360375', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360376', '155360376', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360377', '155360377', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360378', '155360378', '男', '学院1', '专业b', '班级d', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360379', '155360379', '男', '学院1', '专业c', '班级f', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360380', '155360380', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360381', '155360381', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360382', '155360382', '男', '学院1', '专业c', '班级g', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360383', '155360383', '男', '学院1', '专业a', '班级b', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360384', '155360384', '男', '学院1', '专业a', '班级a', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360385', '155360385', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360386', '155360386', '男', '学院1', '专业c', '班级f', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360387', '155360387', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360388', '155360388', '男', '学院1', '专业c', '班级f', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360389', '155360389', '男', '学院1', '专业b', '班级d', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360390', '155360390', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360391', '155360391', '男', '学院1', '专业b', '班级e', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360392', '155360392', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360393', '155360393', '男', '学院1', '专业a', '班级c', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360394', '155360394', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360395', '155360395', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360396', '155360396', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360397', '155360397', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360398', '155360398', '男', '学院1', '专业a', '班级a', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360399', '155360399', '男', '学院1', '专业a', '班级a', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360400', '155360400', '男', '学院1', '专业a', '班级b', '成绩优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360401', '155360401', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360402', '155360402', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360403', '155360403', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360404', '155360404', '男', '学院1', '专业c', '班级f', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360405', '155360405', '男', '学院1', '专业d', '班级h', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360406', '155360406', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360407', '155360407', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360408', '155360408', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360409', '155360409', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360410', '155360410', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360411', '155360411', '男', '学院1', '专业d', '班级h', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360412', '155360412', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360413', '155360413', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360414', '155360414', '男', '学院1', '专业f', '班级i', '成绩优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360415', '155360415', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360416', '155360416', '男', '学院1', '专业c', '班级g', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360417', '155360417', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360418', '155360418', '男', '学院1', '专业c', '班级f', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360419', '155360419', '男', '学院1', '专业c', '班级g', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360420', '155360420', '男', '学院1', '专业b', '班级d', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360421', '155360421', '男', '学院1', '专业f', '班级i', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360422', '155360422', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360423', '155360423', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360424', '155360424', '男', '学院1', '专业a', '班级b', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360425', '155360425', '男', '学院1', '专业a', '班级b', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360426', '155360426', '男', '学院1', '专业a', '班级c', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360427', '155360427', '男', '学院1', '专业f', '班级i', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360428', '155360428', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360429', '155360429', '男', '学院1', '专业b', '班级d', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360430', '155360430', '男', '学院1', '专业b', '班级e', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360431', '155360431', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360432', '155360432', '男', '学院1', '专业f', '班级i', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360433', '155360433', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360434', '155360434', '男', '学院1', '专业b', '班级d', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360435', '155360435', '男', '学院1', '专业c', '班级f', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360436', '155360436', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360437', '155360437', '男', '学院1', '专业a', '班级c', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360438', '155360438', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360439', '155360439', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360440', '155360440', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360441', '155360441', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360442', '155360442', '男', '学院1', '专业b', '班级d', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360443', '155360443', '男', '学院1', '专业a', '班级c', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360444', '155360444', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360445', '155360445', '男', '学院1', '专业a', '班级c', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360446', '155360446', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360447', '155360447', '男', '学院1', '专业c', '班级g', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360448', '155360448', '男', '学院1', '专业d', '班级h', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360449', '155360449', '男', '学院1', '专业c', '班级g', '开心优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360450', '155360450', '男', '学院1', '专业b', '班级e', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360451', '155360451', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360452', '155360452', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360453', '155360453', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360454', '155360454', '男', '学院1', '专业b', '班级d', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360455', '155360455', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360456', '155360456', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360457', '155360457', '男', '学院1', '专业c', '班级g', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360458', '155360458', '男', '学院1', '专业b', '班级d', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360459', '155360459', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360460', '155360460', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360461', '155360461', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360462', '155360462', '男', '学院1', '专业c', '班级g', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360463', '155360463', '男', '学院1', '专业f', '班级i', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360464', '155360464', '男', '学院1', '专业c', '班级g', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360465', '155360465', '男', '学院1', '专业f', '班级i', '创业优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360466', '155360466', '男', '学院1', '专业a', '班级c', '成绩优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360467', '155360467', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360468', '155360468', '男', '学院1', '专业f', '班级i', '成绩优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360469', '155360469', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360470', '155360470', '男', '学院1', '专业a', '班级b', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360471', '155360471', '男', '学院1', '专业f', '班级i', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360472', '155360472', '男', '学院1', '专业b', '班级d', '开心优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360473', '155360473', '男', '学院1', '专业d', '班级h', '创业优先', '篮球', '早鸟');
INSERT INTO `student` VALUES ('155360474', '155360474', '男', '学院1', '专业c', '班级g', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360475', '155360475', '男', '学院1', '专业a', '班级c', '创业优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360476', '155360476', '男', '学院1', '专业d', '班级h', '成绩优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360477', '155360477', '男', '学院1', '专业a', '班级a', '创业优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360478', '155360478', '男', '学院1', '专业b', '班级e', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360479', '155360479', '男', '学院1', '专业d', '班级h', '成绩优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360480', '155360480', '男', '学院1', '专业d', '班级h', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360481', '155360481', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360482', '155360482', '男', '学院1', '专业a', '班级b', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360483', '155360483', '男', '学院1', '专业a', '班级b', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360484', '155360484', '男', '学院1', '专业c', '班级f', '成绩优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360485', '155360485', '男', '学院1', '专业c', '班级f', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360486', '155360486', '男', '学院1', '专业b', '班级d', '创业优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360487', '155360487', '男', '学院1', '专业b', '班级e', '开心优先', '跑步', '早鸟');
INSERT INTO `student` VALUES ('155360488', '155360488', '男', '学院1', '专业d', '班级h', '开心优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360489', '155360489', '男', '学院1', '专业a', '班级a', '成绩优先', '跑步', '正常');
INSERT INTO `student` VALUES ('155360490', '155360490', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360491', '155360491', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '夜猫子');
INSERT INTO `student` VALUES ('155360492', '155360492', '男', '学院1', '专业c', '班级f', '开心优先', '羽毛球', '早鸟');
INSERT INTO `student` VALUES ('155360493', '155360493', '男', '学院1', '专业c', '班级g', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360494', '155360494', '男', '学院1', '专业d', '班级h', '开心优先', '篮球', '正常');
INSERT INTO `student` VALUES ('155360495', '155360495', '男', '学院1', '专业b', '班级e', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360496', '155360496', '男', '学院1', '专业a', '班级b', '创业优先', '羽毛球', '正常');
INSERT INTO `student` VALUES ('155360497', '155360497', '男', '学院1', '专业c', '班级f', '创业优先', '跑步', '夜猫子');
INSERT INTO `student` VALUES ('155360498', '155360498', '男', '学院1', '专业f', '班级i', '创业优先', '羽毛球', '夜猫子');
INSERT INTO `student` VALUES ('155360499', '155360499', '男', '学院1', '专业c', '班级g', '创业优先', '跑步', '夜猫子');
