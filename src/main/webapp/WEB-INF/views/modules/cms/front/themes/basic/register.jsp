<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>用户注册</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<style type="text/css">
		.frm_tips{color: #8D8D8D}
		#nav {background: none repeat scroll 0% 0% transparent;width: 100%;z-index: 1;}
		#nav .nav-2 { height: 20px; background: url("${ctxStatic}/custom/images/reg_hr_e84a6d3b.png") no-repeat scroll center top transparent;}
		#head {font-size: 18px;color: #353644;font-weight: normal;font-family: "KaiTi";}
		.btn.btn-large{width:150px;height:34px;font-size: 16px;font-weight: bold;cursor: pointer;color: #FFF;background-image: none;border-radius: 3px;border: medium none;transition: all 0.3s ease 0s;margin-left:135px;float:left;}
		.group_01{width:480px;margin:0 auto;overflow:hidden;}
		.control-label{float:left;width:75px;text-align:right;font-weight:normal;color:#666;}
		.form-control{width:335px;height:28px;border:1px #ddd solid;border-radius:0;float:left;margin-left:15px;font-size: 12px;}
		.frm_tips{float:left;margin-top:10px;margin-left:15px;}
		.help-inline{float:left;margin-top:7px;margin-left:10px;}
		.control-group{margin-top:15px;}
		.btn-primary{background:#f04848;}
		.btn-primary:hover{background:#f25b5b;}
		label.error{margin-top: 8px;margin-left: 14px;}
	</style>
	<script src="${ctxStatic}/cryptojs/tripledes.js"></script>
	<script src="${ctxStatic}/cryptojs/mode-ecb-min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			<c:if test="${not empty msg}">window.wxc.xcConfirm("${msg}", window.wxc.xcConfirm.typeEnum.info);</c:if>
		    jQuery.validator.addMethod("telphone",function(c,a){
		    	var b=c.length;
		    	return this.optional(a)||c=='请输入您的手机'||(b==11&&/^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/.test(c))
	    	},"请正确填写您的手机号码");
		    jQuery.validator.addMethod("showRePwd",function(c,a){
		    	var b = true;
		    	if(c=='6-16位，字母（区分大小写）、数字、符号'){
		    		b = false;
		    	}
		    	return this.optional(a)||b
	    	},"必填信息");
		    jQuery.validator.addMethod("confirmpassword",function(c,a){
		    	var b = true;
		    	if(c=='请再次输入密码'){
		    		b = false;
		    	}
		    	return this.optional(a)||b
	    	},"必填信息");
		    
			$("#inputForm").validate({
				onfocusout: function(element) { $(element).valid();},
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"},
					loginName: {remote: "${ctx}/checkLoginName"},
					newPassword: {rangelength:[6,16]},
					email:{remote: "${ctx}/checkEmail"}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					newPassword:{rangelength: $.format("密码最小长度:{0}, 最大长度:{1}。")},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"},
					validateCode: {remote: "验证码不正确"},
					email:{remote: "该邮箱已注册过帐号，请更换其他邮箱"}
				},submitHandler: function(form){
					encryptMsg();
					form.submit();
				},
				errorPlacement: function(error, element) {
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.appendTo(element.parent());
					}
				} 
			});
		});
		function encryptMsg(){
			$("#email").val(encrypt($("#email").val()));
			$("#newPassword").val(encrypt($("#newPassword").val()));
			$("#confirmNewPassword").val(encrypt($("#confirmNewPassword").val()));
		}
		function encrypt(word){
			var encrypted = CryptoJS.DES.encrypt(word, CryptoJS.enc.Utf8.parse('${aes}'), {
				mode: CryptoJS.mode.ECB,
				padding: CryptoJS.pad.Pkcs7
			});
			return encodeURIComponent(encrypted.toString());
		}
	</script>
</head>
<body>
	<div style="padding:5px 220px 10px 220px;">
		<div id="head" style="font-size:18px;color:red;">
			用户注册
		</div>
		<div id="nav">
			<div class="nav-2">
				<div class="mod-nav clearfix">
					<h1 class="page-type-notab"></h1>
				</div>
			</div>
		</div>
		<form:form id="inputForm" action="${ctx}/saveregister" method="post" class="form-horizontal">
			<input type="hidden" name="aes" value="${aes}"/>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">登录名:</label>
					<div class="controls">
						<input  type="text" id="loginName" name="loginName"  placeholder="允许使用中英文、数字、下划线，提交后不可修改"  maxlength="50" class="form-control userName required" />
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">密码:</label>
					<div class="controls">
        				<input id="newPassword" autocomplete="off" placeholder="6-16位，字母（区分大小写）、数字、符号" name="newPassword" class="required form-control" type="password"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">确认密码:</label>
					<div class="controls">
						<input id="confirmNewPassword" autocomplete="off" name="confirmNewPassword"  type="password" class="required form-control" equalTo="#newPassword" placeholder="请再次输入密码"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">昵称:</label>
					<div class="controls">
						<input type="text" name="name" maxlength="50"  placeholder="请输入您的昵称"  maxlength="50" class="form-control" />
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">邮箱:</label>
					<div class="controls">
						<input type="text" name="email" id="email" maxlength="50" class="required email form-control" placeholder="请输入您常用的邮箱,可用于找回密码"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">手机:</label>
					<div class="controls">
						<input type="text" name="mobile" maxlength="50" class="telphone form-control" placeholder="请输入您的手机"/>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">验证码:</label>
					<div class="controls">
						<sys:validateCode inputCssStyle="width:80px;height:28px;border:1px #ddd solid;border-radius:0;float:left;margin-left:15px;margin-right:10px;" name="validateCode"/>
					</div>
				</div>
			</div>
			<div style="padding:5px 220px 10px 220px;">
				<input class="btn btn-large btn-primary" type="submit" value="注  册"/>
			</div>
		</form:form>
	</div>
</body>
</html>