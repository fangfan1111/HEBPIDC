<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>日志管理</title>
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
		<li class="active"><a href="${ctx}/sys/log/">日志列表</a></li>
	</ul>
	</div>
	<div class="box-body">
	<form:form id="searchForm" action="${ctx}/sys/log/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
		<div class="form-group">
					<label class="col-sm-2 control-label" for="title">操作菜单 ：</label>
					<div class="col-sm-4">
<input id="title" name="title" type="text" maxlength="50" class="form-control input-sm" value="${log.title}"/>
				</div>
					<label class="col-sm-2 control-label" for="createBy.id">用户ID ：</label>
					<div class="col-sm-4">
<input id="createBy.id" name="createBy.id" type="text" maxlength="50" class="form-control input-sm" value="${log.createBy.id}"/>
					</div>
		</div>
		<div class="form-group">
					<label class="col-sm-2 control-label" for="requestUri">URI ：</label>
					<div class="col-sm-4">
<input id="requestUri" name="requestUri" type="text" maxlength="50" class="form-control input-sm" value="${log.requestUri}"/>
					</div>
				</div>
		
		<div class="form-group">
					<label class="col-sm-2 control-label" for="beginDate">开始时间 ：</label>
					<div class="col-sm-2">
<input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>	
				</div>
					<label class="col-sm-1 control-label" for="endDate">结束时间：</label>
					<div class="col-sm-2">
<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>	
				</div>
				
<label class="col-sm-1 control-label" for="exception"></label>
					<div class="col-sm-2" style="margin-top:4px;">
<input id="exception" name="exception" type="checkbox"${log.exception eq '1'?' checked':''} value="1"/>	只查询异常信息
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
		<tr><th>操作菜单</th><th>操作用户</th><th>所在公司</th><th>所在部门</th><th>URI</th><th>提交方式</th><th>操作者IP</th><th>操作时间</th>
		</thead>
		<tbody><%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<td>${log.title}</td>
				<td>${log.createBy.name}</td>
				<td>${log.createBy.company.name}</td>
				<td>${log.createBy.office.name}</td>
				<td><strong>${log.requestUri}</strong></td>
				<td>${log.method}</td>
				<td>${log.remoteAddr}</td>
				<td><fmt:formatDate value="${log.createDate}" type="both"/></td>
			</tr>
			<c:if test="${not empty log.exception}"><tr>
				<td colspan="8" style="word-wrap:break-word;word-break:break-all;">
<%-- 					用户代理: ${log.userAgent}<br/> --%>
<%-- 					提交参数: ${fns:escapeHtml(log.params)} <br/> --%>
					异常信息: <br/>
					${fn:replace(fn:replace(fns:escapeHtml(log.exception), strEnter, '<br/>'), strTab, '&nbsp; &nbsp; ')}</td>
			</tr></c:if>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>