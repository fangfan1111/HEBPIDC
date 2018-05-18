<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>个人信息</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				rules: {
					email:{remote: "${pageContext.request.contextPath}${fns:getFrontPath()}/checkEmail?oldEmail=" + encodeURIComponent('${user.email}')}
				},
				messages: {
					email:{remote: "该邮箱已注册过帐号，请更换其他邮箱"}
				},
				submitHandler: function(form){
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
	</script>
</head>
<body>
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
		<li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
	</ul><br/></div>
			<div class="box-body" style="padding: 10px 100px 10px;">
	
	<form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post" class="form-horizontal"><%--
		<form:hidden path="email" htmlEscape="false" maxlength="255" class="input-xlarge"/>
		<sys:ckfinder input="email" type="files" uploadPath="/mytask" selectMultiple="false"/> --%>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">头像:</label>
			<div class="col-sm-4">
				<form:hidden id="nameImage" path="photo" htmlEscape="false" maxlength="255" class="form-control"/>
				<sys:myuploadlocal input="nameImage" type="images" uploadPath="/photo" isSaveLocal="false" uploadMaxSize="10" uploadMimeTypes="jpg,jpeg,png,gif" multiSelection="false" saveRealName="false"/>
<%-- 				<sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/> --%>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属公司:</label>
			<div class="col-sm-4">
				${user.company.name}
			</div>
			<label class="col-sm-2 control-label">归属部门:</label>
			<div class="col-sm-4">
				${user.office.name}
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">姓名:</label>
			<div class="col-sm-4">
				<form:input path="name" htmlEscape="false" cssClass="form-control input-sm" maxlength="50" />
			</div>
		
			<label class="col-sm-2 control-label"><font color="red">*</font>邮箱:</label>
			<div class="col-sm-4">
				<form:input path="email" htmlEscape="false" maxlength="50" class="form-control input-sm required email"/>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">电话:</label>
			<div class="col-sm-4">
				<form:input path="phone" htmlEscape="false" cssClass="form-control input-sm" maxlength="50"/>
			</div>
		
			<label class="col-sm-2 control-label">手机:</label>
			<div class="col-sm-4">
				<form:input path="mobile" htmlEscape="false" cssClass="form-control input-sm" maxlength="50"/>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-4">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
			</div>
		
			<label class="col-sm-2 control-label">用户类型:</label>
			<div class="col-sm-4">
				${fns:getDictLabel(user.userType, 'sys_user_type', '无')}
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户角色:</label>
			<div class="col-sm-4">
				${user.roleNames}
			</div>
	
			<label class="col-sm-2 control-label">上次登录:</label>
			<div class="col-sm-4">
				IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/>
			</div>
		</div>
		<div class="form-group">
			<input id="btnSubmit" class="btn btn-primary col-md-offset-6 sm-top-1" type="submit" value="保 存"/>
		</div>
	</form:form>
	</div>
</body>
</html>