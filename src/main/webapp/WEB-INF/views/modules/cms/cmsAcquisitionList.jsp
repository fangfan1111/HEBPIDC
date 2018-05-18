<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>采集管理</title>
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
		<li class="active"><a href="${ctx}/cms/cmsAcquisition/">采集源列表</a></li>
		<shiro:hasPermission name="cms:cmsAcquisition:edit"><li><a href="${ctx}/cms/cmsAcquisition/form">采集源添加</a></li></shiro:hasPermission>
	</ul></div>
			<div class="box-body">
	
	<form:form id="searchForm" modelAttribute="cmsAcquisition" action="${ctx}/cms/cmsAcquisition/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	
	     <fieldset>
	     <div class="form-group">
	     <label class="col-sm-2 control-label">采集名称：</label>
	     <div class="col-sm-4">
				<form:input path="acqName" htmlEscape="false" maxlength="50" style="width:100%;border:1px #d2d6de solid;"/>
		</div>
		<label class="col-sm-2 control-label">采集状态：</label>
		<div class="col-sm-3">
				<form:select path="status" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:option value="0">停止</form:option>
					<form:option value="1">运行</form:option>
					<form:option value="2">暂停</form:option>
				</form:select>
		</div>
		<div class="col-sm-1">
				<input id="btnSubmit" class="btn btn-primary sm-right-1" type="submit" value="查询"/>
		 </div>
		 </div>
		</fieldset>
		
	</form:form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>采集名称</th>
				<th>采集状态</th>
				<th>当前/总 页数</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<shiro:hasPermission name="cms:cmsAcquisition:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsAcquisition">
			<tr>
				<td>
					${cmsAcquisition.acqName}
				</td>
				<td>
					<c:choose>
						<c:when test="${cmsAcquisition.status eq '0'}">
							停止
						 </c:when>
						 <c:when test="${cmsAcquisition.status eq '1'}">
							<strong style="color:red">运行	</strong>
						 </c:when>
						 <c:when test="${cmsAcquisition.status eq '2'}">
							暂停
						 </c:when>
					</c:choose>
				</td>
				<td>
					${cmsAcquisition.currNum}.${cmsAcquisition.currItem}/${cmsAcquisition.totalNum}.${cmsAcquisition.totalItem}
				</td>
				<td>
					<c:if test="${!empty cmsAcquisition.startTime}"><fmt:formatDate value="${cmsAcquisition.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
				</td>
				<td>
					<c:if test="${!empty cmsAcquisition.endTime}"><fmt:formatDate value="${cmsAcquisition.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
				</td>
				<shiro:hasPermission name="cms:cmsAcquisition:edit">
					<td>
						<c:choose>
							<c:when test="${cmsAcquisition.queue gt 0}">
								<span style="color:red">等待 (${cmsAcquisition.queue})</span>| 
								<a href="${ctx}/cms/cmsAcquisition/cancel?id=${cmsAcquisition.id}">取消</a>| 
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${cmsAcquisition.status eq '0'}">
										<a href="${ctx}/cms/cmsAcquisition/start?ids=${cmsAcquisition.id}">开始</a> |
									</c:when>
									<c:when test="${cmsAcquisition.status eq '1'}">
										<a href="${ctx}/cms/cmsAcquisition/pause?id=${cmsAcquisition.id}">暂停</a> |
										<a href="${ctx}/cms/cmsAcquisition/end?id=${cmsAcquisition.id}">停止</a> |
									</c:when>
									<c:when test="${cmsAcquisition.status eq '2'}">
										<a href="${ctx}/cms/cmsAcquisition/start?ids=${cmsAcquisition.id}">开始</a> |
										<a href="${ctx}/cms/cmsAcquisition/end?id=${cmsAcquisition.id}">停止</a> |
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<a href="${ctx}/cms/cmsAcquisition/form?id=${cmsAcquisition.id}">修改</a> |
						<a href="${ctx}/cms/cmsAcquisition/delete?id=${cmsAcquisition.id}" onclick="return confirmx('确认要删除该采集源吗？', this.href)">删除</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>