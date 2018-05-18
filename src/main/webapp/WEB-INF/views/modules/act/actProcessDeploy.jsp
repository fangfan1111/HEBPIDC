<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>部署流程 - 流程管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
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
		<li><a href="${ctx}/act/process/">流程管理</a></li>
		<li class="active"><a href="${ctx}/act/process/deploy/">部署流程</a></li>
		<li><a href="${ctx}/act/process/running/">运行中的流程</a></li>
	</ul><br/></div>
	<sys:message content="${message}"/>
	<div class="box-body">
	<form:form id="inputForm" action="${ctx}/act/process/deploy" method="post" enctype="multipart/form-data" class="breadcrumb form-horizontal" style="background:none;">
		<fieldset>
		<div class="form-group">
		
			<label class="control-label col-sm-2">流程分类：</label>
			<div class="col-sm-4">
				<select id="category" name="category" class="required input-medium">
					<c:forEach items="${fns:getDictList('act_category')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-2">流程文件：</label>
			<div class="col-sm-4">
				<input type="file" id="file" name="file" class="required"/>
				<span class="help-inline">支持文件格式：zip、bar、bpmn、bpmn20.xml</span>
			</div>
		</div>
		<div class="form-group">
			<input id="btnSubmit" class="btn btn-primary col-sm-offset-2 sm-right-1" type="submit" value="提 交"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			
		</div>
	
	</fieldset>
	</form:form>
	</div>
</body>
</html>
