<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				window.top.layer.confirm('确认要导出用户数据吗？', {
					icon: 3,
					title:'系统提示',
					  btn: ['确定','取消'] //按钮
					}, function(index){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();		
						layer.close(index);
					}, function(){
					});		
			});
			$("#btnImport").click(function(){
				//页面层
				layer.open({
				  type: 1,
				  title:'导入用户信息',
//				  skin: 'layui-layer-rim', //加上边框
				  area: ['420px', '240px'], //宽高
				  content: $("#importBox").html()
				});

			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form:form  id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-horizontal" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" class="form-control input-sm" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit"  class="btn btn-primary" type="submit" value="导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form:form>
		<br><br>
		导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！
		
	</div>
	<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/list">用户列表</a></li>
		<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form">用户添加</a></li></shiro:hasPermission>
	</ul>
	</div>
	<div class="box-body">
		<form:form id="searchForm" modelAttribute="user"
			action="${ctx}/sys/user/list" method="post" class="breadcrumb form-horizontal">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden"
				value="${page.pageSize}" />
			<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
				callback="page();" />
			<fieldset>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="company">归属公司：</label>
					<div class="col-sm-4">
						<sys:treeselect id="company" name="company.id"
							value="${user.company.id}" labelName="company.name"
							labelValue="${user.company.name}" title="公司"
							url="/sys/office/treeData?type=1"
							cssClass="form-control input-sm" allowClear="true" />
					</div>
					<label class="col-sm-2 control-label" for="loginName">登录名：</label>
					<div class="col-sm-4">
						<form:input path="loginName" htmlEscape="false" maxlength="50"
							class="form-control input-sm" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label" for="office">归属部门：</label>
					<div class="col-sm-4">
						<sys:treeselect id="office" name="office.id"
							value="${user.office.id}" labelName="office.name"
							labelValue="${user.office.name}" title="部门"
							url="/sys/office/treeData?type=2"
							cssClass="form-control input-sm" allowClear="true"
							notAllowSelectParent="true" />
					</div>

					<label class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;名：</label>
					<div class="col-sm-4">
						<form:input path="name" htmlEscape="false" maxlength="50"
							class="form-control input-sm" />
					</div>
				</div>
				<div class="form-group">
					<input id="btnSubmit" class="btn btn-primary pull-right sm-right-1"
						type="submit" value="查询" onclick="return page();" /> <input
						id="btnExport" class="btn btn-primary pull-right sm-right-1" type="button"
						value="导出" /> <input id="btnImport"
						class="btn btn-primary pull-right sm-right-1" type="button" value="导入" />
				</div>
			</fieldset>
		</form:form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr><th>归属公司</th><th>归属部门</th><th class="sort-column login_name">登录名</th><th class="sort-column a.name">姓名</th><th>电话</th><th>手机</th><%--<th>角色</th> --%><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td width="18%">${user.company.name}</td>
				<td width="15%">${user.office.name}</td>
				<td width="10%"><a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a></td>
				<td width="15%">${user.name}</td>
				<td width="12%">${user.phone}</td>
				<td width="15%">${user.mobile}</td><%--
				<td>${user.roleNames}</td> --%>
				<shiro:hasPermission name="sys:user:edit">
				<td width="15%">
    				<a href="${ctx}/sys/user/form?id=${user.id}"  class="btn btn-success btn-xs"><i class="fa fa-edit"></i>修改</a>
					<a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>删除</a>				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<div class="pagination">${page}</div>
	</div>
</body>
</html>