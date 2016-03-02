<?php
return array(
    'DB_TYPE'   => 'mysqli', // 数据库类型
    'DB_HOST'   => 'localhost', // 服务器地址
    'DB_NAME'   => 'withcode', // 数据库名
    'DB_USER'   => 'root', // 用户名
    'DB_PWD'    => 'root', // 密码
    'DB_PORT'   => 3306, // 端口
    'DB_CHARSET'=> 'utf8', // 字符集
    'MODULE_ALLOW_LIST' => array('Home','Admin'),
    'DEFAULT_MODULE'     => 'Home',

 	// 配置邮件发送服务器
    'MAIL_HOST' =>'smtp.163.com',//smtp服务器的名称
    'MAIL_SMTPAUTH' =>true, //启用smtp认证
    'MAIL_USERNAME' =>'15208491440@163.com',//你的邮箱名
    'MAIL_FROM' =>'15208491440@163.com',//发件人地址
    'MAIL_FROMNAME'=>'withcode',//发件人姓名
    'MAIL_PASSWORD' =>'e10adc3949',//邮箱密码
    'MAIL_CHARSET' =>'utf-8',//设置邮件编码
    'MAIL_ISHTML' =>true, // 是否HTML格式邮件
    'MAIL_DEBUG' =>false
);