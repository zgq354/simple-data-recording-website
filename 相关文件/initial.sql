-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018-01-03 16:39:25
-- 服务器版本： 5.7.20-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `report`
--

-- --------------------------------------------------------

--
-- 表的结构 `data`
--

CREATE TABLE `data` (
  `id` int(11) NOT NULL COMMENT '记录id',
  `template` int(11) NOT NULL COMMENT '记录使用的模板',
  `field_name` varchar(50) NOT NULL COMMENT '指标名称',
  `unit` varchar(20) NOT NULL COMMENT '计量单位',
  `parent` int(11) NOT NULL DEFAULT '0' COMMENT '父级记录',
  `format` int(11) NOT NULL COMMENT '记录格式',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `area` varchar(20) NOT NULL COMMENT '记录归属地区',
  `current` double NOT NULL COMMENT '本期实际',
  `last_year` double NOT NULL COMMENT '去年同期',
  `year-on-year` double NOT NULL COMMENT '同比',
  `date` varchar(10) NOT NULL COMMENT '月份',
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据表';

--
-- 转存表中的数据 `data`
--

INSERT INTO `data` (`id`, `template`, `field_name`, `unit`, `parent`, `format`, `sort`, `area`, `current`, `last_year`, `year-on-year`, `date`, `created`) VALUES
(3, 1, '（一）本月新设企业数量', '个', 0, 1, 1, 'B', 213, 217, 0.05, '2017-12', 1514791764),
(4, 1, '（一）本月新设企业数量', '个', 0, 1, 1, 'C', 809, 833, -2.88, '2017-12', 1514792383),
(5, 1, '（一）本月新设企业数量', '个', 0, 1, 1, 'A', 809, 833, -2.88, '2017-12', 1514792924),
(6, 2, '1. 内资企业数量', '个', 1, 0, 0, 'A', 774, 789, -1.9, '2017-12', 1514793238),
(7, 3, '注册资本总额\n', '万元人民币', 1, 0, 0, 'A', 885, 867, 2.08, '2017-12', 1514793322),
(9, 3, '注册资本总额\n', '万元人民币', 1, 0, 0, 'C', 213, 324, -34.26, '2017-12', 1514793723),
(10, 7, '3. 注册资本1亿元以上大企业数量', '个', 1, 0, 0, 'C', 546, 768, -28.91, '2017-12', 1514793731),
(12, 1, '（一）本月新设企业数量', '个', 0, 1, 1, 'B', 2342, 3423, -31.58, '2017-10', 1514793750),
(13, 4, '2. 外商投资企业数量', '个', 1, 0, 0, 'C', 342, 23, 1386.96, '2017-12', 1514793757),
(15, 2, '1. 内资企业数量', '个', 1, 0, 0, 'B', 32424, 76575, -57.66, '2017-12', 1514793766),
(18, 3, '注册资本总额\n', '万元人民币', 1, 0, 0, 'B', 67575, 53553, 26.18, '2017-9', 1514793779),
(19, 2, '1. 内资企业数量', '个', 1, 0, 0, 'C', 123, 234, -47.44, '2017-12', 1514793779),
(20, 4, '2. 外商投资企业数量', '个', 1, 0, 0, 'A', 566, 266, 112.78, '2017-12', 1514793785),
(21, 6, '实际利用外资金额', '万元人民币', 1, 0, 0, 'C', 3456, 234, 1376.92, '2017-12', 1514793789),
(22, 5, '合同外资金额', '万元人民币', 1, 0, 0, 'B', 1233423, 453554, 171.95, '2017-12', 1514793795),
(23, 6, '实际利用外资金额', '万元人民币', 1, 0, 0, 'B', 3543534, 324263, 992.8, '2017-12', 1514793804),
(24, 5, '合同外资金额', '万元人民币', 1, 0, 0, 'A', 4399, 8848, -50.28, '2017-12', 1514793808),
(25, 8, '其中：①注册资本10亿元以上大企业数量', '个', 7, 0, 0, 'B', 2342423, 657854, 256.07, '2017-12', 1514793815),
(27, 9, '②注册资本100亿元以上大企业数量', '个', 7, 0, 0, 'B', 85674, 35352, 142.35, '2017-12', 1514793823),
(28, 6, '实际利用外资金额', '万元人民币', 1, 0, 0, 'A', 235, 342, -34.52, '2017-12', 1514793835),
(29, 7, '3. 注册资本1亿元以上大企业数量', '个', 1, 0, 0, 'B', 74353, 24355, 205.29, '2017-12', 1514793835),
(30, 5, '合同外资金额', '万元人民币', 1, 0, 0, 'B', 356785, 24324, 1366.8, '2017-12', 1514793844),
(32, 7, '3. 注册资本1亿元以上大企业数量', '个', 1, 0, 0, 'A', 444, 565, -21.42, '2017-12', 1514793851),
(33, 8, '其中：①注册资本10亿元以上大企业数量', '个', 7, 0, 0, 'A', 546546, 346346, 57.8, '2017-12', 1514793857),
(34, 9, '②注册资本100亿元以上大企业数量', '个', 7, 0, 0, 'B', 666, 168, 296.43, '2017-12', 1514793875),
(35, 6, '实际利用外资金额', '万元人民币', 1, 0, 0, 'B', 856654, 324742, 163.8, '2017-12', 1514793891),
(36, 4, '2. 外商投资企业数量', '个', 1, 0, 0, 'B', 546324, 64562, 746.2, '2017-12', 1514793904),
(37, 13, '（二）本月进出口总额', '万元人民币', 0, 1, 10, 'A', 1234, 1235, -0.08, '2017-12', 1514906597),
(38, 14, '出口额', '万元人民币', 13, 0, 11, 'A', 1100, 1200, -8.33, '2017-12', 1514906624),
(39, 15, '进口额', '万元人民币', 13, 0, 12, 'A', 110, 132, -16.67, '2017-12', 1514906639);

-- --------------------------------------------------------

--
-- 表的结构 `template`
--

CREATE TABLE `template` (
  `id` int(11) NOT NULL COMMENT '条目id',
  `field_name` varchar(50) NOT NULL COMMENT '条目名字',
  `unit` varchar(20) NOT NULL COMMENT '单位',
  `parent` int(11) NOT NULL COMMENT '父级条目',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序ID',
  `format` int(11) NOT NULL DEFAULT '0' COMMENT '显示格式'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='记录模板表';

--
-- 转存表中的数据 `template`
--

INSERT INTO `template` (`id`, `field_name`, `unit`, `parent`, `sort`, `format`) VALUES
(1, '（一）本月新设企业数量', '个', 0, 0, 1),
(2, '1. 内资企业数量', '个', 1, 1, 0),
(3, '注册资本总额\n', '万元人民币', 1, 2, 0),
(4, '2. 外商投资企业数量', '个', 1, 3, 0),
(5, '合同外资金额', '万元人民币', 1, 4, 0),
(6, '实际利用外资金额', '万元人民币', 1, 5, 0),
(7, '3. 注册资本1亿元以上大企业数量', '个', 1, 6, 0),
(8, '其中：①注册资本10亿元以上大企业数量', '个', 7, 7, 0),
(9, '②注册资本100亿元以上大企业数量', '个', 7, 8, 0),
(13, '（二）本月进出口总额', '万元人民币', 0, 10, 1),
(14, '出口额', '万元人民币', 13, 11, 0),
(15, '进口额', '万元人民币', 13, 12, 0),
(16, '（三）本月境外投资项目', '个', 0, 13, 1),
(17, '中方协议投资额', '万元人民币', 16, 14, 0),
(18, '中方实际投资额', '万元人民币', 16, 15, 0);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT '用户id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(64) NOT NULL COMMENT '密码哈希',
  `email` varchar(20) NOT NULL COMMENT '邮箱',
  `role` enum('admin','manager','accendant','department') NOT NULL DEFAULT 'department' COMMENT '用户角色',
  `area` varchar(20) NOT NULL COMMENT '地区',
  `created` int(11) NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表格';

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `area`, `created`) VALUES
(1, 'test', 'password', 'jack@example.com', 'department', 'A', 123456789),
(2, 'Jack', '123456', 'a@b.com', 'admin', 'C', 1514659950),
(3, 'admin', '$2a$10$JXcBhEo36ExmFqfYEMPRJ.C9lN/WDHJE2TLtaoF903VYUDQWjSOge', 'jacka@example.com', 'admin', 'A', 123456789),
(5, 'mic', '$2a$10$Gttua1CZcM7NIg/YH/r7O.B.D5U9GH6.HzEVGH0ca7Yk44jLyUvBK', 'mic@123.com', 'manager', 'A', 1514795740),
(6, 'root', '$2a$10$BcJDWCH2jph1w3N23Oe5J.GAnpkxmle58ei8uUK4RTActv8UmzG6m', 'admin@example.com', 'admin', '0', 1514968741);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template` (`template`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `template`
--
ALTER TABLE `template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `data`
--
ALTER TABLE `data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id', AUTO_INCREMENT=40;
--
-- 使用表AUTO_INCREMENT `template`
--
ALTER TABLE `template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '条目id', AUTO_INCREMENT=19;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id', AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
