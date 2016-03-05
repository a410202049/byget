$(function () {
	//jQuery Validate 表单验证
	/**
	 * 添加验证方法
	 * 以字母开头，5-17 字母、数字、下划线"_"
	 */
	jQuery.validator.addMethod("user", function(value, element) {   
	    var tel = /^1[345678][0-9]{9}|[^@]+@[\w\.]+/;
	    return this.optional(element) || (tel.test(value));
	}, "账户必须为手机或邮箱");


	jQuery.validator.addMethod("pass", function(value, element) {   
	    var tel = /^[a-zA-Z][\w]{5,15}$/;
	    return this.optional(element) || (tel.test(value));
	}, "以字母开头，6-16 字母、数字、下划线'_'");


	jQuery.validator.addMethod("isMobile", function(value, element) {
		var length = value.length;
		var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
		return this.optional(element) || (length == 11 && mobile.test(value));
	}, "请正确填写您的手机号码");

	$('form[name=login]').validate({
		submitHandler: function(form) { 
		   $.ajax({
				type: "POST",
				url: loginUrl,
				dataType: "json",
				data:$('#login-form').serialize(),
				beforeSend: function(){
					$('#login-form .btn-block').html('登录中...');
    			},
    			complete: function(){
    				$('#login-form .btn-block').html('登录');
    			},
				success: function(data) {
					if(data.status == 'error'){
						$('#login-form .alert-danger').html(data.message).show(500).delay(2000).hide(500);
					}else{
						window.location.reload()
					}
				}
			});

		},
		rules : {
			username : {
				required : true,
				user : true
			},
			password : {
				required : true,
				pass : true
			}

		},
		messages : {
			username : {
				required : '账号不能为空',
				remote : '账号已存在'
			},
			password : {
				required : '密码不能为空'
			}

		}
	});



	$('form[name=mobile-reg]').validate({
		// errorElement : 'span',
		submitHandler: function(form) { 
		   $.ajax({
				type: "POST",
				url: mobileRegisterUrl,
				dataType: "json",
				data:$('#mobile-reg').serialize(),
				beforeSend: function(){
					$('#mobile-reg .btn-reg').html('注册中...');
    			},
    			complete: function(){
    				$('#mobile-reg .btn-reg').html('注册');
    			},
				success: function(data) {
					if(data.status == 'error'){
						$('#mobile-reg .alert-danger').html(data.message).show(500).delay(2000).hide(500);
					}else{
						window.location.reload()
					}
				}
			});
			
		},
		rules : {
			username : {
				required : true,
				isMobile : true,
				remote : {
					url : checkAccount,
					type : 'post',
					dataType : 'json',
					data : {
						username : function () {
							return $("#mobile-reg input[name='username']").val();
						}
					}
				}
			},
			password : {
				required : true,
				pass : true
			},
			nickname:{
				required : true,
				remote : {
					url : checkNickname,
					type : 'post',
					dataType : 'json',
					data : {
						nickname : function () {
							return $("#mobile-reg input[name='nickname']").val();
						}
					}
				}
			},
			code:{
				required : true
			}

		},
		messages : {
			username : {
				required : '账号不能为空',
				isMobile: '请填写正确的手机号码',
				remote : '账号已存在'
			},
			password : {
				required : '密码不能为空'
			},
			nickname : {
				required : '昵称不能为空',
				remote: '昵称已存在'
			},
			code:{
				required : '验证码不能为空'
			}

		}
	});

	$('form[name=email-reg]').validate({
		// errorElement : 'span',
		submitHandler: function(form) { 
		   $.ajax({
				type: "POST",
				url: emailRegisterUrl,
				dataType: "json",
				data:$('#email-reg').serialize(),
				beforeSend: function(){
					$('#email-reg .btn-reg').html('注册中...');
    			},
    			complete: function(){
    				$('#email-reg .btn-reg').html('注册');
    			},
				success: function(data) {
					if(data.status == 'error'){
						$('#email-reg .alert-danger').html(data.message).show(500).delay(2000).hide(500);
					}else{
						window.location.reload()
					}
				}
			});
			
		},
		rules : {
			username : {
				required : true,
				email : true,
				remote : {
					url : checkAccount,
					type : 'post',
					dataType : 'json',
					data : {
						username : function () {
							return $("#email-reg input[name='username']").val();
						}
					}
				}
			},
			password : {
				required : true,
				pass : true
			},
			nickname:{
				required : true,
				remote : {
					url : checkNickname,
					type : 'post',
					dataType : 'json',
					data : {
						nickname : function () {
							return $("#email-reg input[name='nickname']").val();
						}
					}
				}
			}

		},
		messages : {
			username : {
				required : '账号不能为空',
				email: '请填写正确邮箱地址',
				remote : '账号已存在'
			},
			password : {
				required : '密码不能为空'
			},
			nickname : {
				required : '昵称不能为空',
				remote: '昵称已存在'
			}

		}
	});


	var _reg_log_code = true;
	$('#mobile-reg .getCode').click(function(event) {
		var _time = 10;
		if(_reg_log_code){
		   $('#mobile-reg .getCode').html("发送中..");
		   $.ajax({
				type: "POST",
				url: sendCode,
				dataType: "json",
				data:{mobile:$("#mobile-reg input[name='username']").val()},
				success: function(data) {
					if(data.status == 'error'){
						$('#mobile-reg .getCode').html("发送验证码");
	   					return false;
					}else{
		                _reg_log_code = false;
		                var _t_code = setInterval(function() {
		                    $('#mobile-reg .getCode').html(_time-- + "秒");
		                    if (_time < 1) {
		                        clearInterval(_t_code);
		                        $('#mobile-reg .getCode').html("发送验证码");
		                        _reg_log_code = true;
		                    };
		                }, 1000);
					}
				}
			});
	    }
	});



});