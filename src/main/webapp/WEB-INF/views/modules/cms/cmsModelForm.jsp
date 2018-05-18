<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模型管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
		<li><a href="${ctx}/cms/cmsModel/">模型列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsModel/form?id=${cmsModel.id}">模型<shiro:hasPermission name="cms:cmsModel:edit">${not empty cmsModel.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsModel:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/></div>
		<div class="box-body">
	
	<form:form id="inputForm" modelAttribute="cmsModel" action="${ctx}/cms/cmsModel/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>名称：</label>
			<div class="col-sm-6 controls">
				<form:input path="modelName" htmlEscape="false" maxlength="64" class="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>路径：</label>
			<div class="col-sm-6 controls">
				<form:input path="modelPath" htmlEscape="false" maxlength="64" class="form-control input-sm required"/>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目模板前缀：</label>
			<div class="col-sm-6 controls">
				<form:input path="tplChannelPrefix" htmlEscape="false" maxlength="50" class="form-control input-sm "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容模板前缀：</label>
			<div class="col-sm-6 controls">
				<form:input path="tplContentPrefix" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目标题图宽度：</label>
			<div class="col-sm-6 controls">
				<form:input path="titleImgWidth" htmlEscape="false" maxlength="9" class="number form-control input-sm required digits"/>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目标题图高度：</label>
			<div class="col-sm-6 controls">
				<form:input path="titleImgHeight" htmlEscape="false" maxlength="9" class="number form-control input-sm required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目内容图宽度：</label>
			<div class="col-sm-6 controls">
				<form:input path="contentImgWidth" htmlEscape="false" maxlength="9" class="number form-control input-sm required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目内容图高度：</label>
			<div class="col-sm-6 controls">
				<form:input path="contentImgHeight" htmlEscape="false" maxlength="9" class="number form-control input-sm required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">排列顺序：</label>
			<div class="col-sm-6 controls">
				<form:input path="priority" htmlEscape="false" maxlength="9" class="form-control input-sm  digits number"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>是否有内容：</label>
			<div class="col-sm-6 controls">
				<form:radiobuttons path="hasContent" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否禁用：</label>
			<div class="col-sm-6 controls">
				<form:radiobuttons path="isDisabled" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>是否默认模型：</label>
			<div class="col-sm-6 controls">
				<form:radiobuttons path="isDef" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-6 controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control input-sm"/>
			</div>
		</div>
		<div class="form-actions" style="text-align:left;padding-left:2%;">
			<shiro:hasPermission name="cms:cmsModel:edit"><input id="btnSubmit" class="btn btn-primary col-md-offset-4" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</div>
</body>
</html>