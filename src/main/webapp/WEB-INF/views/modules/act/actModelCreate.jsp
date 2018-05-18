<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>新建模型 - 模型管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			top.$.jBox.tip.mess = null;
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
					setTimeout(function(){location='${ctx}/act/model/'}, 1000);
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
		function page(n,s){
        	location = '${ctx}/act/model/?pageNo='+n+'&pageSize='+s;
        }
	</script>
</head>
<body>
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/act/model/">模型管理</a></li>
		<li class="active"><a href="${ctx}/act/model/create">新建模型</a></li>
	</ul><br/></div>
	<sys:message content="${message}"/>
		<div class="box-body">
	<fieldset>
	<form:form id="inputForm" action="${ctx}/act/model/create" target="_blank" method="post" class="form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label">流程分类：</label>
			<div class="col-sm-10 controls">
				<select id="category" name="category" class="required input-medium">
					<c:forEach items="${fns:getDictList('act_category')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">模块名称：</label>
			<div class="col-sm-10 controls">
				<input id="name" name="name" type="text" class="form-control input-sm required" />
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">模块标识：</label>
			<div class="col-sm-10 controls">
				<input id="key" name="key" type="text" class="form-control input-sm required" />
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">模块描述：</label>
			<div class="col-sm-10 controls">
				<textarea id="description" name="description" class="form-control input-sm required"></textarea>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary pull-default" type="submit" value="提 交"/>
			<input id="btnCancel" class="btn pull-default" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</fieldset>
	</div>
</body>
</html>
