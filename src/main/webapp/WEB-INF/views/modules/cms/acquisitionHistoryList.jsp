<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>采集历史管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
	 function selectAll(){  
	        if ($("#SelectAll").attr("checked")) {  
	            $(":checkbox").attr("checked", true);  
	        } else {  
	            $(":checkbox").attr("checked", false);  
	        }  
	    }
	    function optDelete() {
	    	var checkedsub = $(":checkbox:checked").length; 
	    	if(checkedsub<=0) {
	    		$.jBox.tip("请选择您要操作的数据", 'info');
	    		return;
	    	}
	    	
	     	layer.confirm('确认要删除数据吗？', {
				icon: 2,
				title:'系统提示',
				  btn: ['确定','取消'] //按钮
				}, function(index){
					$("#searchForm").attr("action","${ctx}/cms/acquisitionHistory/delete");
					$("#searchForm").submit();
					layer.close(index);
				}, function(){
				});	
	   
	    }
	    function Delete(id){
	    	layer.confirm('确认要删除数据吗？', {
				icon: 2,
				title:'系统提示',
				  btn: ['确定','取消'] //按钮
				}, function(index){
					$("#searchForm").attr("action","${ctx}/cms/acquisitionHistory/singledelete?id="+id);
					$("#searchForm").submit();
					layer.close(index);
				}, function(){
				});	
	    }
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
		<li class="active"><a href="${ctx}/cms/acquisitionHistory/">采集历史列表</a></li>
	</ul></div>
	<div class="content-padding" style="margin-top:6px;">
		<shiro:hasPermission name="cms:acquisitionHistory:edit"><input type="button" value="删除" onclick="optDelete();"  class="btn btn-primary" style="margin-bottom:10px;margin-top:10px;"></shiro:hasPermission>
	
	<form:form id="searchForm" modelAttribute="acquisitionHistory" action="${ctx}/cms/acquisitionHistory/list" method="post">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<shiro:hasPermission name="cms:acquisitionHistory:edit"><th style="width:25px;"><input name="SelectAll" id="SelectAll" type='checkbox' onclick='selectAll()'/></th></shiro:hasPermission>
				<th>标题</th>
				<th>采集名称</th>
				<th>所属栏目</th>
				<th>采集地址</th>
				<th>内容地址</th>
				<th>状态</th>
				<th>描述</th>
				<shiro:hasPermission name="cms:acquisitionHistory:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="acquisitionHistory">
			<tr>
				<shiro:hasPermission name="cms:acquisitionHistory:edit"><td style="width:25px;">
					<input type='checkbox' name='ids' value='${acquisitionHistory.id}' />
				</td></shiro:hasPermission>
				<td>
					<c:choose>
						<c:when test="${!empty acquisitionHistory.contentId}">
							<a href="${acquisitionHistory.previewUrl}" target="_blank">${acquisitionHistory.title}</a>
						</c:when>
						<c:otherwise>
							${acquisitionHistory.title}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${acquisitionHistory.acquisitionId}
				</td>
				<td>
					${acquisitionHistory.categoryName}
				</td>
				<td>
					<a href="${acquisitionHistory.channelUrl}" target="_blank">点击浏览</a>
				</td>
				<td>
					<a href="${acquisitionHistory.contentUrl}" target="_blank">点击浏览</a>
				</td>
				<td>
					<c:choose>
					 	<c:when test="${acquisitionHistory.description eq 'SUCCESS'}">
					 		<span style="color:green">成功</span>
					 	</c:when>
					 	<c:otherwise>
					 		<span style="color:red">失败</span>
					 	</c:otherwise>
				 	</c:choose>
				</td>
				<td>
				 	<c:choose>
				 	<c:when test="${acquisitionHistory.description eq 'SUCCESS'}">
				 		成功
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'TITLESTARTNOTFOUND'}">
				 		采集失败!原因: 标题起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'TITLEENDNOTFOUND'}">
				 		采集失败!原因: 标题结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'CONTENTSTARTNOTFOUND'}">
				 		采集失败!原因: 正文起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'CONTENTENDNOTFOUND'}">
				 		采集失败!原因: 正文结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'AUTHORSTARTNOTFOUND'}">
				 		采集失败!原因: 作者起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'AUTHORENDNOTFOUND'}">
				 		采集失败!原因: 作者结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'VIEWSTARTNOTFOUND'}">
				 		采集失败!原因: 发布时间起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'VIEWENDNOTFOUND'}">
				 		采集失败!原因: 发布时间结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'ORIGINSTARTNOTFOUND'}">
			 			采集失败!原因: 来源起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'ORIGINENDNOTFOUND'}">
				 		采集失败!原因: 来源结束点不匹配
				 	</c:when>
				 	
				 	<c:when test="${acquisitionHistory.description eq 'DESCRISTARTNOTFOUND'}">
				 		采集失败!原因: 摘要起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'DESCRIENDNOTFOUND'}">
				 		采集失败!原因: 摘要结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'RELEASESTARTNOTFOUND'}">
				 		采集失败!原因: 发布时间起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'RELEASEENDNOTFOUND'}">
				 		采集失败!原因: 发布时间结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'RELEASEDATEUNKNOW'}">
				 		采集失败!原因: 发布时间格式不正确
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'TITLEEXIST'}">
				 		采集失败!原因: 标题已存在
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'FILESTARTNOTFOUND'}">
				 		采集失败!原因: 附件起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'FILEENDNOTFOUND'}">
				 		采集失败!原因: 附件结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'TABLEUNKNOW'}">
				 		采集失败!原因: 表格格式不匹配
				 	</c:when>
				 	<c:otherwise>
				 		采集失败!原因: 采集地址解析失败
				 	</c:otherwise>
				 </c:choose>
				</td>
				<shiro:hasPermission name="cms:acquisitionHistory:edit"><td>
   					<a onclick="Delete('${acquisitionHistory.id}')" href="javascript:">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</form:form>
	</div>
</body>
</html>