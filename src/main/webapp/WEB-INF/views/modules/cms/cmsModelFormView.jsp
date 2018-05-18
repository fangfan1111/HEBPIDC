<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模型管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsModel/">模型列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsModel/view?id=${cmsModel.id}">模型查看</a></li>
	</ul><br/></div>
			<div class="box-body">
	
	<form:form id="inputForm" modelAttribute="cmsModel" action="${ctx}/cms/cmsModel/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">名称：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.modelName}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">路径：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.modelPath}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目模板前缀：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.tplChannelPrefix}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容模板前缀：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.tplContentPrefix}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目标题图宽度：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.titleImgWidth}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目标题图高度：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.titleImgHeight}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目内容图宽度：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.contentImgWidth}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目内容图高度：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.contentImgHeight}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">排列顺序：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.priority}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否有内容：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${fns:getDictLabel(cmsModel.hasContent,'yes_no','')}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否禁用：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${fns:getDictLabel(cmsModel.isDisabled,'yes_no','')}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否默认模型：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${fns:getDictLabel(cmsModel.isDef,'yes_no','')}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${cmsModel.remarks}</div>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</div>
</body>
</html>