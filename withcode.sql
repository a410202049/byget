CREATE TABLE `user` (
`id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
`username` varchar(20) NOT NULL,
`password` varchar(32) NULL COMMENT '密码',
`roles` int NOT NULL DEFAULT 3 COMMENT '权限 ：1管理员 2老师 3学生',
`lock` int NOT NULL DEFAULT 0 COMMENT '是否锁定（0：否，1：是）',
`registime` datetime NOT NULL COMMENT '注册时间',
PRIMARY KEY (`id`) ,
UNIQUE INDEX `username` (`username`)
)
COMMENT='用户表';

CREATE TABLE `userInfo` (
`id` int NOT NULL AUTO_INCREMENT,
`qq` varchar(15) NOT NULL COMMENT 'QQ号',
`phone` varchar(15) NOT NULL COMMENT '手机号码',
`email` varchar(50) NOT NULL,
`sex` enum('男','女') NOT NULL DEFAULT '男' COMMENT '性别',
`face` varchar(100) NULL COMMENT '头像地址',
`idcard` varchar(30) NULL COMMENT '身份证号码',
`company` varchar(50) NULL COMMENT '公司名称',
`signature` varchar(200) NULL,
`about` varchar(1000) NULL,
`province` varchar(10) NULL COMMENT '省份',
`city` varchar(10) NULL COMMENT '城市',
`nickname` varchar(20) NOT NULL COMMENT '昵称',
`uid` int NOT NULL,
`valid_email` int NULL DEFAULT 0 COMMENT '0未激活 1已激活',
`valid_mobile` int NULL DEFAULT 0 COMMENT '0未激活 1已激活',
PRIMARY KEY (`id`) ,
UNIQUE INDEX `nickName` (`nickname`)
);

CREATE TABLE `article` (
`id` int NOT NULL AUTO_INCREMENT,
`title` varchar(100) NOT NULL COMMENT '文章标题',
`discription` varchar(500) NOT NULL COMMENT '文章描述',
`content` varchar(2000) NOT NULL COMMENT '文章内容',
`uid` int NOT NULL COMMENT '用户id',
`tagId` int NULL COMMENT '标签id',
`visit` int NULL DEFAULT 0 COMMENT '浏览量',
`categoryId` int NULL,
`isTop` int NULL DEFAULT 0 COMMENT '0为非置顶 1为置顶',
`createTime` datetime NOT NULL COMMENT '创建时间',
`updateTime` datetime NOT NULL COMMENT '更新时间',
PRIMARY KEY (`id`) 
)
COMMENT='文章';

CREATE TABLE `category` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL COMMENT '分类名称',
`seoTitle` varchar(200) NULL COMMENT '分类标题',
`seoKeyword` varchar(200) NULL COMMENT '分类关键词',
`seoDesc` varchar(500) NULL COMMENT '分类描述',
`parentId` int NULL DEFAULT NULL COMMENT '父级ID 多级分类',
`weight` int NULL DEFAULT 0 COMMENT '权重',
PRIMARY KEY (`id`) 
);

CREATE TABLE `article_tag` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL,
`aid` int NOT NULL COMMENT '文章id',
PRIMARY KEY (`id`) 
);

CREATE TABLE `praise` (
`id` int NOT NULL AUTO_INCREMENT,
`aid` int NOT NULL,
`uid` int NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='点赞';

CREATE TABLE `article_comment` (
`id` int NOT NULL AUTO_INCREMENT,
`aid` int NOT NULL,
`uid` int NOT NULL,
`content` varchar(1000) NOT NULL,
`parentId` int NULL DEFAULT NULL COMMENT '父级评论',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='评论表';

CREATE TABLE `letter` (
`id` int NOT NULL AUTO_INCREMENT,
`from` int NOT NULL COMMENT '发私用户ID',
`content` varchar(500) NOT NULL,
`uid` int NOT NULL,
`isReady` int NULL DEFAULT 0 COMMENT '0为未阅读 1为阅读',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='私信表';

CREATE TABLE `groups` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL COMMENT '小组名称',
`desc` varchar(500) NOT NULL COMMENT '小组描述',
`logo` varchar(200) NOT NULL COMMENT '小组头像',
`uid` int NOT NULL COMMENT '组长id',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='小组表';

CREATE TABLE `groups_member` (
`id` int NOT NULL AUTO_INCREMENT,
`gid` int NOT NULL,
`uid` int NOT NULL,
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `follow` (
`id` int NOT NULL AUTO_INCREMENT,
`uid` int NOT NULL COMMENT '被关注的人id',
`fansId` int NOT NULL COMMENT ' 粉丝id',
PRIMARY KEY (`id`) 
)
COMMENT='关注表';

CREATE TABLE `talk` (
`id` int NOT NULL,
`title` varchar(200) NOT NULL,
`content` varchar(1000) NOT NULL,
`gid` int NULL COMMENT '小组id',
`uid` int NULL COMMENT '发布人id',
`parentId` int NULL DEFAULT NULL COMMENT '父级讨论id',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `course` (
`id` int NOT NULL AUTO_INCREMENT,
`title` varchar(100) NOT NULL COMMENT '课程名称',
`pic` varchar(200) NOT NULL COMMENT '封面图',
`description` varchar(500) NULL COMMENT '课程描述',
`teachId` int NOT NULL,
`status` int NOT NULL DEFAULT 0 COMMENT '0非连载课程 1更新中 2已完结 ',
`price` float NULL DEFAULT 0,
`isRelease` int NULL DEFAULT 0 COMMENT '0未发布 1已发布',
`categoryId` int NULL,
`weight` int NULL DEFAULT 0 COMMENT '课程权重',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `course_tag` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL,
`cid` int NOT NULL COMMENT '文章id',
PRIMARY KEY (`id`) 
);

CREATE TABLE `course_category` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NULL,
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='课程分类';

CREATE TABLE `section` (
`id` int NOT NULL AUTO_INCREMENT,
`cid` int NULL,
`title` varchar(50) NOT NULL COMMENT '章节名称',
`description` varchar(200) NOT NULL,
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='章节';

CREATE TABLE `lesson` (
`id` int NOT NULL AUTO_INCREMENT,
`title` varchar(50) NOT NULL,
`description` varchar(200) NULL,
`videoUrl` varchar(500) NOT NULL,
`playCount` int NULL DEFAULT 0,
`lessonTime` varchar(500) NOT NULL COMMENT '课程时间（秒）',
`sid` int NOT NULL,
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
);

CREATE TABLE `course_comment` (
`id` int NOT NULL AUTO_INCREMENT,
`cid` int NOT NULL,
`uid` int NOT NULL,
`content` varchar(1000) NOT NULL,
`parentId` int NULL DEFAULT NULL COMMENT '父级评论',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='评论表';

CREATE TABLE `student_payCourse` (
`id` int NOT NULL AUTO_INCREMENT,
`studentId` int NOT NULL,
`cid` int NULL COMMENT '课程id',
`createTime` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='学生购买的课程';

CREATE TABLE `integral` (
`id` int NOT NULL AUTO_INCREMENT,
`score` int NULL DEFAULT 0 COMMENT '学分',
`balance` float NULL DEFAULT 0 COMMENT '账号余额',
`uid` int NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='积分表';

CREATE TABLE `dataDown` (
`id` int NOT NULL AUTO_INCREMENT,
`name` varchar(50) NOT NULL,
`url` varchar(200) NOT NULL,
`type` enum('txt','zip','rar','pdf') NULL,
`cid` int NULL,
PRIMARY KEY (`id`) 
)
COMMENT='课程资料下载';

CREATE TABLE `order` (
`id` int NOT NULL AUTO_INCREMENT,
`orderNum` varchar(50) NOT NULL,
`proName` varchar(50) NOT NULL COMMENT '商品名称',
`createTime` datetime NOT NULL,
`num` int NOT NULL COMMENT '商品数量',
`price` float NOT NULL COMMENT '商品价格',
`is_pay` int NULL DEFAULT 0 COMMENT '0未支付 1已支付',
PRIMARY KEY (`id`) 
);

CREATE TABLE `mobileVerifyRecord` (
`id` int NOT NULL AUTO_INCREMENT,
`code` varchar(10) NOT NULL,
`mobile` varchar(11) NOT NULL,
`ip` varchar(20) NOT NULL,
`created` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='手机注册验证表';

CREATE TABLE `emailVerifyRecord` (
`id` int NOT NULL AUTO_INCREMENT,
`code` varchar(10) NOT NULL,
`email` varchar(50) NOT NULL,
`ip` varchar(20) NOT NULL,
`created` datetime NOT NULL,
PRIMARY KEY (`id`) 
)
COMMENT='手机注册验证表';

CREATE TABLE `banner` (
`id` int NOT NULL AUTO_INCREMENT,
`title` varchar(50) NULL,
`description` varchar(50) NULL,
`pic` varchar(255) NULL,
`url` varchar(255) NULL,
PRIMARY KEY (`id`) 
);


ALTER TABLE `category` ADD CONSTRAINT `fk_category_article` FOREIGN KEY (`id`) REFERENCES `article` (`categoryId`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_article` FOREIGN KEY (`id`) REFERENCES `article` (`uid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_userInfo` FOREIGN KEY (`id`) REFERENCES `userInfo` (`uid`);
ALTER TABLE `article` ADD CONSTRAINT `fk_article_article_tag` FOREIGN KEY (`id`) REFERENCES `article_tag` (`aid`);
ALTER TABLE `article` ADD CONSTRAINT `fk_article_article_praise` FOREIGN KEY (`id`) REFERENCES `praise` (`aid`);
ALTER TABLE `article` ADD CONSTRAINT `fk_article_article_comment` FOREIGN KEY (`id`) REFERENCES `article_comment` (`aid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_user_letter` FOREIGN KEY (`id`) REFERENCES `letter` (`uid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_user_groups` FOREIGN KEY (`id`) REFERENCES `groups` (`uid`);
ALTER TABLE `groups` ADD CONSTRAINT `fk_groups_groups_member` FOREIGN KEY (`id`) REFERENCES `groups_member` (`gid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_follow` FOREIGN KEY (`id`) REFERENCES `follow` (`uid`);
ALTER TABLE `groups` ADD CONSTRAINT `fk_groups_groups_talk` FOREIGN KEY (`id`) REFERENCES `talk` (`gid`);
ALTER TABLE `course` ADD CONSTRAINT `fk_course_course_tag` FOREIGN KEY (`id`) REFERENCES `course_tag` (`cid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_user_course` FOREIGN KEY (`id`) REFERENCES `course` (`teachId`);
ALTER TABLE `course_category` ADD CONSTRAINT `fk_course_category_course_category_course` FOREIGN KEY (`id`) REFERENCES `course` (`categoryId`);
ALTER TABLE `course` ADD CONSTRAINT `fk_course_course_section` FOREIGN KEY (`id`) REFERENCES `section` (`cid`);
ALTER TABLE `section` ADD CONSTRAINT `fk_section_section_lesson` FOREIGN KEY (`id`) REFERENCES `lesson` (`sid`);
ALTER TABLE `course` ADD CONSTRAINT `fk_course_course_comment` FOREIGN KEY (`id`) REFERENCES `course_comment` (`cid`);
ALTER TABLE `course` ADD CONSTRAINT `fk_course_course_payCourse` FOREIGN KEY (`id`) REFERENCES `student_payCourse` (`cid`);
ALTER TABLE `user` ADD CONSTRAINT `fk_user_user_integral` FOREIGN KEY (`id`) REFERENCES `integral` (`uid`);
ALTER TABLE `course` ADD CONSTRAINT `fk_course_course_dataDown` FOREIGN KEY (`id`) REFERENCES `dataDown` (`cid`);

