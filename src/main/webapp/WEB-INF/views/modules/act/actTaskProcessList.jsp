<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>发起任务</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			top.$.jBox.tip.mess = null;
		});
		function page(n,s){
        	location = '${ctx}/act/task/process/?pageNo='+n+'&pageSize='+s;
        }
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/act/task/todo/">待办任务</a></li>
		<li><a href="${ctx}/act/task/historic/">已办任务</a></li>
		<li class="active"><a href="${ctx}/act/task/process/">新建任务</a></li>
	</ul></div>
	<div class="box-body">
	<form id="searchForm" action="${ctx}/act/task/process/" method="post" class="breadcrumb form-horizontal">
	<fieldset>
	<div class="form-group">
		<div class="col-sm-2" style="margin-top:4px;">
		<select id="category" name="category" class="input-medium">
			<option value="">全部分类</option>
			<c:forEach items="${fns:getDictList('act_category')}" var="dict">
				<option value="${dict.value}" ${dict.value==category?'selected':''}>${dict.label}</option>
			</c:forEach>
		</select>
		</div>
		<div class="col-sm-1">
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
		</div>
	</div>
	</fieldset>
	</form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>流程分类</th>
				<th>流程标识</th>
				<th>流程名称</th>
				<th>流程图</th>
				<th>流程版本</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="object">
				<c:set var="process" value="${object[0]}" />
				<c:set var="deployment" value="${object[1]}" />
				<tr>
					<td>${fns:getDictLabel(process.category,'act_category','无分类')}</td>
					<td><a href="${ctx}/act/task/form?procDefId=${process.id}">${process.key}</a></td>
					<td>${process.name}</td>
					<td><a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${process.id}">${process.diagramResourceName}</a><%--
						<a target="_blank" href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=image">${process.diagramResourceName}</a>--%></td>
					<td><b title='流程版本号'>V: ${process.version}</b></td>
					<td><fmt:formatDate value="${deployment.deploymentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td>
						<a href="${ctx}/act/task/form?procDefId=${process.id}">启动流程</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
	
</body>
</html>
