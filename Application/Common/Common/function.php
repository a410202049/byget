<?php

/**
 * 检测用户是否登录
 * @return integer 0-未登录，大于0-当前登录用户ID
 * @author kerry.gao
 */
function is_login() {
    $uid = session('uid');
    if (empty($uid)) {
        return false;
    } else {
       return $uid;
    }
}

/**
 * [is_admin 是否为管理员]
 */
function is_admin() {
    $uid = session('aid');
    if (empty($uid)) {
        return false;
    } else {
       return $uid;
    }
}

/**
 * 邮件发送函数
 */
function sendMail($to, $title, $content) {
    Vendor('PHPMailer.PHPMailerAutoload');     
    $mail = new PHPMailer(); //实例化
    $mail->IsSMTP(); // 启用SMTP
    $mail->SMTPDebug = C('MAIL_DEBUG');
    $mail->SMTPSecure = 'ssl';
    $mail->Port = 465;
    $mail->Host=C('MAIL_HOST'); //smtp服务器的名称（这里以QQ邮箱为例）
    $mail->SMTPAuth = C('MAIL_SMTPAUTH'); //启用smtp认证
    $mail->Username = C('MAIL_USERNAME'); //你的邮箱名
    $mail->Password = C('MAIL_PASSWORD') ; //邮箱密码
    $mail->From = C('MAIL_FROM'); //发件人地址（也就是你的邮箱地址）
    $mail->FromName = C('MAIL_FROMNAME'); //发件人姓名
    $mail->AddAddress($to,"尊敬的客户");
    $mail->WordWrap = 50; //设置每行字符长度
    $mail->IsHTML(C('MAIL_ISHTML')); // 是否HTML格式邮件
    $mail->CharSet=C('MAIL_CHARSET'); //设置邮件编码
    $mail->Subject =$title; //邮件主题
    $mail->Body = $content; //邮件内容
    return($mail->Send());
}

/**
 * [i_array_column 二维数组转一维数组]
 * @param  [type] $input     [description]
 * @param  [type] $columnKey [description]
 * @param  [type] $indexKey  [description]
 * @return [type]            [description]
 */
function i_array_column($input, $columnKey, $indexKey=null){
    if(!function_exists('array_column')){ 
        $columnKeyIsNumber  = (is_numeric($columnKey))?true:false; 
        $indexKeyIsNull            = (is_null($indexKey))?true :false; 
        $indexKeyIsNumber     = (is_numeric($indexKey))?true:false; 
        $result                         = array(); 
        foreach((array)$input as $key=>$row){ 
            if($columnKeyIsNumber){ 
                $tmp= array_slice($row, $columnKey, 1); 
                $tmp= (is_array($tmp) && !empty($tmp))?current($tmp):null; 
            }else{ 
                $tmp= isset($row[$columnKey])?$row[$columnKey]:null; 
            } 
            if(!$indexKeyIsNull){ 
                if($indexKeyIsNumber){ 
                  $key = array_slice($row, $indexKey, 1); 
                  $key = (is_array($key) && !empty($key))?current($key):null; 
                  $key = is_null($key)?0:$key; 
                }else{ 
                  $key = isset($row[$indexKey])?$row[$indexKey]:0; 
                } 
            } 
            $result[$key] = $tmp; 
        } 
        return $result; 
    }else{
        return array_column($input, $columnKey, $indexKey);
    }
}


/**
 * 将闭包函数转为字符串
 * @param Closure $c
 * @param boolen $escape
 * @return string
 */
function closure_dump(Closure $c, $escape = true) {
    $str = 'function (';
    $r = new ReflectionFunction($c);
    $params = array();
    foreach($r->getParameters() as $p) {
        $s = '';
        if($p->isArray()) {
            $s .= 'array ';
        } else if($p->getClass()) {
            $s .= $p->getClass()->name . ' ';
        }
        if($p->isPassedByReference()){
            $s .= '&';
        }
        $s .= '$' . $p->name;
        if($p->isOptional()) {
            $s .= ' = ' . var_export($p->getDefaultValue(), TRUE);
        }
        $params []= $s;
    }
    $str .= implode(', ', $params);
    $str .= '){' . PHP_EOL;
    $lines = file($r->getFileName());
    for($l = $r->getStartLine(); $l < $r->getEndLine(); $l++) {
        $str .= $lines[$l];
    }
    if($escape){
        $str = preg_replace('/[\r\n\t]/', '', $str);
    }
    $str = preg_replace('/}[,;]$/', '}', $str);
    return $str;
}

/**
 * 将变量转为输出到字符串
 * @param mixed $expression
 * @param boolen $escape
 * @return string 
 */
function custom_var_export($expression, $escape = true){
    $str = '';
    if(is_array($expression)){
        $str .= 'array(';
        foreach ($expression as $key => $val){
            $str .= "'".$key."' => ".custom_var_export($val).',';
        }
        $str .= ')';
    }else if($expression instanceof \Closure){
        $str .= closure_dump($expression);
    }else{
        $str .= var_export($expression, true);
    }
    return $str;
}