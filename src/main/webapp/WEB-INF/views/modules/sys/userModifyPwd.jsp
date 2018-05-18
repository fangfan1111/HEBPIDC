<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>修改密码</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script src="${ctxStatic}/cryptojs/tripledes.js"></script>
	<script src="${ctxStatic}/cryptojs/mode-ecb-min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#oldPassword").focus();
			$("#inputForm").validate({
				messages: {
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				submitHandler: function(form){
					$("#oldPassword").val(encrypt($("#oldPassword").val()));
					$("#newPassword").val(encrypt($("#newPassword").val()));
					$("#confirmNewPassword").val(encrypt($("#confirmNewPassword").val()));
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
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
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li class="active"><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul><br/></div>
		<div class="box-body">
	
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="form-horizontal">
		<input type="hidden" name="aes" value="${aes}">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font> 旧密码:</label>
			<div class="col-sm-3 controls">
				<input id="oldPassword" name="oldPassword" autocomplete="off"  type="password" value="" maxlength="50" minlength="3" class="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>新密码:</label>
			<div class="col-sm-3 controls">
				<input id="newPassword" name="newPassword" autocomplete="off" type="password" value="" maxlength="50" minlength="3" class="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>确认新密码:</label>
			<div class="col-sm-3 controls">
				<input id="confirmNewPassword" name="confirmNewPassword" autocomplete="off" type="password" value="" maxlength="50" minlength="3" class="form-control input-sm required" equalTo="#newPassword"/>
			</div>
		</div>
		<div class="form-actions" style="text-align:left;">
			<input id="btnSubmit" class="btn btn-primary sm-left-1" type="submit" value="保 存"/>
		</div>
	</form:form>
	</div>
</body>
</html>