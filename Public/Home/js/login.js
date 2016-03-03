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

	$('form[name=login]').validate({
		// errorElement : 'span',
		submitHandler: function(form) { 
			// var param = form.serialize(); 
			console.log(form);
			
		},
		rules : {
			username : {
				required : true,
				user : true
				// remote : {
				// 	url : checkAccount,
				// 	type : 'post',
				// 	dataType : 'json',
				// 	data : {
				// 		account : function () {
				// 			return $('#account').val();
				// 		}
				// 	}
				// }
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






});