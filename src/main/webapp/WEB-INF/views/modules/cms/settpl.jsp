<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模板管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
			$("#inputForm").validate({
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
		<li class="active"><a>模板管理</a></li>
	</ul><br/></div>
	<form id="inputForm"  action="${ctx}/cms/template/def_template" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">文件名:</label>
			<div class="controls">
				<select name="solution" id="solution" value="${defSolution }">
					<c:forEach items="${solutions}" var="item">
							<option value="${item}" <c:if test="${defSolution==item }">selected</c:if>>${item}
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>