<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>区域管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
		<li><a href="${ctx}/sys/area/">区域列表</a></li>
		<li class="active"><a href="form?id=${area.id}&parent.id=${area.parent.id}">区域<shiro:hasPermission name="sys:area:edit">${not empty area.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:area:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	</div>
		<div class="box-body">
	
	<form:form id="inputForm" modelAttribute="area" action="${ctx}/sys/area/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">上级区域:</label>
			<div class="col-sm-10 controls">
				<sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
					title="区域" url="/sys/area/treeData" extId="${area.id}" cssClass="form-control input-sm" allowClear="true"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>区域名称:</label>
			<div class="col-sm-10 controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">区域编码:</label>
			<div class="col-sm-10 controls">
				<form:input path="code" htmlEscape="false" class="form-control input-sm" maxlength="50"/>
		</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">区域类型:</label>
			<div class="col-sm-10 controls">
				<form:select path="type" class="input-medium">
					<form:options items="${fns:getDictList('sys_area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注:</label>
			<div class="col-sm-10 controls">
				<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control"/>
				</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:area:edit">
			<input id="btnSubmit" class="btn btn-primary pull-default" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn pull-default" type="button" value="返 回" onclick="history.go(-1)"/>
			</shiro:hasPermission>
		</div>
	</form:form>
	
	</div>
</body>
</html>