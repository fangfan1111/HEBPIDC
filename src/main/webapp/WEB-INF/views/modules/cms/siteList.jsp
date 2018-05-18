<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>站点管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
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
		<li class="active"><a href="${ctx}/cms/site/">站点列表</a></li>
		<shiro:hasPermission name="cms:site:edit"><li><a href="${ctx}/cms/site/form">站点添加</a></li></shiro:hasPermission>
	</ul></div>
	<div class="box-body">
	<form:form id="searchForm" modelAttribute="site" action="${ctx}/cms/site/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
		<div class="form-group">
		<label class="col-sm-2 control-label">名称：</label>
		<div class="col-sm-4">
		<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
		</div>
		<label class="col-sm-2 control-label">状态：</label>
		<div class="col-sm-3 form-float-span">
		<form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" />
        </div>
		<div class="col-sm-1">
			<input id="btnSubmit" class="btn btn-primary pull-right sm-right-1" type="submit" value="查询"/>
		</div>
	</div>
		</fieldset>
	</form:form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>标题</th><th>描述</th><th>关键字</th><shiro:hasPermission name="cms:site:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="site">
			<tr>
				<td><a href="${ctx}/cms/site/form?id=${site.id}" title="${site.name}">${fns:abbr(site.name,40)}</a></td>
				<td>${fns:abbr(site.title,40)}</td>
				<td>${fns:abbr(site.description,40)}</td>
				<td>${fns:abbr(site.keywords,40)}</td>
				<shiro:hasPermission name="cms:site:edit"><td>
    				<a href="${ctx}/cms/site/form?id=${site.id}">修改</a>
					<a href="${ctx}/cms/site/delete?id=${site.id}${site.delFlag ne 0?'&isRe=true':''}" onclick="return confirmx('确认要${site.delFlag ne 0?'恢复':''}删除该站点吗？', this.href)" >${site.delFlag ne 0?'恢复':''}删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>