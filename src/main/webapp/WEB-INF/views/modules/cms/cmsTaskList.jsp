<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>任务管理</title>
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
		<li class="active"><a href="${ctx}/cms/cmsTask/">任务列表</a></li>
		<shiro:hasPermission name="cms:cmsTask:edit"><li><a href="${ctx}/cms/cmsTask/form">任务添加</a></li></shiro:hasPermission>
	</ul></div>
		<div class="box-body">
	
	<form:form id="searchForm" modelAttribute="cmsTask" action="${ctx}/cms/cmsTask/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
				<div class="form-group">
		<label class="col-sm-2 control-label">任务名称：</label>
		<div  class="col-sm-4">
				<form:input path="taskName" htmlEscape="false" maxlength="255" class="form-control input-sm"/>
		</div>
		<label class="col-sm-2 control-label">是否启用：</label>
				<div  class="col-sm-3 form-float-span">
				<form:radiobuttons path="isEnable" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
         </div>
		<div  class="col-sm-1">
		 <input id="btnSubmit" class="btn btn-primary pull-right sm-right-1" type="submit" value="查询"/>
		 </div>
		</div>
		</fieldset>
		
	</form:form></div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>任务名称</th>
				<th>任务类型</th>
				<th>是否启用</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="cms:cmsTask:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsTask">
			<tr>
				<td><a href="${ctx}/cms/cmsTask/view?id=${cmsTask.id}">
					${cmsTask.taskName}
				</a></td>
				<td>
					${fns:getDictLabel(cmsTask.taskType, 'task_type', '')}
				</td>
				<td>
					${fns:getDictLabel(cmsTask.isEnable, 'yes_no', '')}
				</td>
				<td>
					${cmsTask.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${cmsTask.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${cmsTask.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cmsTask.remarks}
				</td>
				<shiro:hasPermission name="cms:cmsTask:edit"><td>
    				<a href="${ctx}/cms/cmsTask/form?id=${cmsTask.id}">修改</a>
					<a href="${ctx}/cms/cmsTask/delete?id=${cmsTask.id}" onclick="return confirmx('确认要删除该任务吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>