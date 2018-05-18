<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模型管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/cmsModel/">模型列表</a></li>
		<shiro:hasPermission name="cms:cmsModel:edit"><li><a href="${ctx}/cms/cmsModel/form">模型添加</a></li></shiro:hasPermission>
	</ul></div>
	<div class="box-body">
	<form:form id="searchForm" modelAttribute="cmsModel" action="${ctx}/cms/cmsModel/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
		<div class="form-group">
					<label class="col-sm-2 control-label" for="modelName">名称：</label>
                   <div class="col-sm-4">
					<form:input path="modelName" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
					</div>	
	<label class="col-sm-2 control-label" for="modelPath">路径：</label>
                   <div class="col-sm-4">
				<form:input path="modelPath" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
					</div>										
					</div>
					
	<div class="form-group">
					<label class="col-sm-2 control-label" for="hasContent">是否有内容：</label>
                   <div class="col-sm-4 form-float-span">
				<form:radiobuttons path="hasContent" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</div>	
	<label class="col-sm-2 control-label" for="isDisabled">是否禁用：</label>
                   <div class="col-sm-4 form-float-span">
				<form:radiobuttons path="isDisabled" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</div>										
					</div>					
	<div class="form-group">
		<input id="btnSubmit" class="btn btn-primary pull-right sm-right-1" type="submit" value="查询"/>
	</div>
		</fieldset>
	</form:form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>排列顺序</th>
				<th>栏目模板前缀</th>
				<th>内容模板前缀</th>
				<th>是否有内容</th>
				<th>是否禁用</th>
				<th>是否默认模型</th>
				<shiro:hasPermission name="cms:cmsModel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsModel">
			<tr>
				<td><a href="${ctx}/cms/cmsModel/view?id=${cmsModel.id}">
					${cmsModel.modelName}(${cmsModel.modelPath})
				</a></td>
				<td>
					${cmsModel.priority}
				</td>
				<td>
					${cmsModel.tplChannelPrefix}
				</td>
				<td>
					${cmsModel.tplContentPrefix}
				</td>
				<td>
					${fns:getDictLabel(cmsModel.hasContent, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(cmsModel.isDisabled, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(cmsModel.isDef, 'yes_no', '')}
				</td>
				<shiro:hasPermission name="cms:cmsModel:edit"><td>
    				<a href="${ctx}/cms/cmsModel/form?id=${cmsModel.id}">修改</a>
    				<c:if test="${cmsModel.id ne '34fa3cea0f8e48ffbe1048e347b104e8' and cmsModel.id ne 'e4e7d7723abe4e24a6364ee07b7d87f4' }">
    				   <a href="${ctx}/cms/cmsModel/delete?id=${cmsModel.id}" onclick="return confirmx('确认要删除该模型吗？', this.href)">删除</a>
    				</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>