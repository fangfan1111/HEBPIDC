<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>模板帮助文档</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
    <style>
        h1, h2, h3, .masthead p, .subhead p, .marketing h2, .lead {
            font-family: "Helvetica Neue", Helvetica, Arial, "Microsoft Yahei UI", "Microsoft YaHei", SimHei, "\5B8B\4F53", simsun, sans-serif;
            font-weight: normal;
        }
    </style>
    <script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			}});
		});
    </script>
</head>
<body>
<div class="container">
	<ul class="nav nav-tabs">
		<li ><a href="${ctx}/cms/template/list?root=${root}">模板列表</a></li>
		<shiro:hasPermission name="cms:template:edit"><li class="active"><a href="${ctx}/cms/template/v_rename?root=${root}&name=${template.filename}">模板重命名</a></li></shiro:hasPermission>
	</ul>
<form:form id="inputForm"  action="${ctx}/cms/template/o_rename" method="post" class="form-horizontal">
		<input type="hidden" name="root" value="${root}"/>
		<div class="control-group">
			<label class="control-label">原名称:</label>
			<div class="controls">
				${name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新名称:</label>
			<div class="controls">
				<input name="oldname" type="hidden"  value="${name}">
				<input name="newname" type="text"  class="required" value="${name}">
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
</form:form>
</div>
</body>
</html>