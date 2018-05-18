<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>文章管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		function viewComment(href){
			//iframe层
			layer.open({
			  type: 2,
			  maxmin: true,
			  title: '查看评论',
			  shadeClose: true,
			  shade: 0.8,
			  area: ['550px', '70%'],
			  content: href //iframe的url
			}); 
			return false;
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		 function selectAll(){  
		        if ($("#SelectAll").attr("checked")) {  
		            $(":checkbox").attr("checked", true);  
		        } else {  
		            $(":checkbox").attr("checked", false);  
		        }  
	    }
		 function publishByIds() {
		    	var checkedsub = $(":checkbox:checked").length; 
		    	if(checkedsub<=0) {
		    		$.jBox.tip("请选择您要操作的数据", 'info');
		    		return;
		    	}
		    	layer.confirm('确认要发布数据吗？', {
					icon: 3,
					title:'系统提示',
					  btn: ['确定','取消'] //按钮
					}, function(index){
						$("#tableForm").attr("action","${ctx}/cms/article/publishByIds?categoryId=${article.category.id}");
						$("#tableForm").submit();	
						layer.close(index);
					}, function(){
					});	

		    }
		 function publishByCateGoryId() {
			 layer.confirm('确认要发布数据吗？', {
					icon: 3,
					title:'系统提示',
					  btn: ['确定','取消'] //按钮
					}, function(index){
						$("#tableForm").attr("action","${ctx}/cms/article/publishByCateGoryId?categoryId=${article.category.id}");
						$("#tableForm").submit();
						layer.close(index);
					}, function(){
					});	
	
		    }
	</script>
</head>
<body>
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/article/?category.id=${article.category.id}">文章列表</a></li>
		<shiro:hasPermission name="cms:article:edit"><li><a href="<c:url value='${fns:getAdminPath()}/cms/article/form?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">文章添加</a></li></shiro:hasPermission>
	</ul></div>
			<div class="box-body">
	
	
	<form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/article/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
			<div class="form-group">
					<label class="col-sm-2 control-label" for="category">栏目：</label>
					<div class="col-sm-4">
<sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" notAllowSelectRoot="false" cssClass="form-control input-sm"/>					
					</div>
					
					<label class="col-sm-2 control-label" for="title">标题：</label>
					<div class="col-sm-4">
					<form:input path="title" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
					</div>
					</div>
					<div class="form-group">
					<label class="col-sm-2 control-label" for="delFlag">状态：</label>
					<div class="col-sm-10 form-float-span">
						<form:radiobuttons onclick="$('#searchForm').submit();"  path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</div>
				</div>
			<div class="form-group">
				<input type="button" value="增量发布" onclick="publishByIds();"  class="btn btn-primary pull-right sm-right-1">
				<input type="button" value="完全发布" onclick="publishByCateGoryId();"  class="btn btn-primary pull-right sm-right-1">
			</div>
		</fieldset>
	</form:form>
	
	</div>
	
	<sys:message content="${message}"/><div class="content-padding">
	<form id="tableForm" method="post">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th style="width:25px;"><input name="SelectAll" id="SelectAll" type='checkbox' onclick='selectAll()'/><th>栏目</th><th>标题</th><th>状态</th><th>权重</th><th>点击数</th><th>发布者</th><th>更新时间</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="article">
			<tr>
				<td style="width:25px;"><input type='checkbox' name='ids' value='${article.id}' /></td>
				<td><a href="javascript:" onclick="$('#categoryId').val('${article.category.id}');$('#categoryName').val('${article.category.name}');$('#searchForm').submit();return false;">${article.category.name}</a></td>
				<td><a href="${ctx}/cms/article/form?id=${article.id}" title="${article.title}">${fns:abbr(article.title,40)}</a></td>
				<td>${fns:getDictLabel(article.delFlag,'cms_del_flag','')}</td>
				<td>${article.weight}</td>
				<td>${article.hits}</td>
				<td>${article.user.name}</td>
				<td><fmt:formatDate value="${article.updateDate}" type="both"/></td>
				<td>
					<a href="${article.previewUrl}" target="_blank">预览</a>
					<shiro:hasPermission name="cms:article:edit">
						<c:if test="${article.category.allowComment eq '1'}"><shiro:hasPermission name="cms:comment:view">
							<a href="${ctx}/cms/comment/?module=article&contentId=${article.id}&delFlag=2" onclick="return viewComment(this.href);">评论</a>
						</shiro:hasPermission></c:if>
						<c:if test="${articleState ne '2'&&article.delFlag ne '2'}">
							<c:choose>
								<c:when test="${article.delFlag eq '6'}">
									<a href="${ctx}/cms/article/publish?id=${article.id}&categoryId=${article.category.id}" onclick="return confirmx('确认要发布该文章吗？', this.href)" >发布</a>
								</c:when>
								<c:when test="${article.delFlag eq '4'}">
									<a href="${ctx}/cms/article/form?id=${article.id}">编辑</a>
								</c:when>
								<c:when test="${article.delFlag eq '5'}">
								</c:when>
								<c:when test="${article.delFlag eq '0'}">
									<a href="${ctx}/cms/article/delpublish?id=${article.id}&categoryId=${article.category.id}"  onclick="return confirmx('确认要撤销发布该文章吗？', this.href)">撤销发布</a>
								</c:when>
								<c:otherwise>
									<a href="${ctx}/cms/article/form?id=${article.id}">修改</a>
								</c:otherwise>
							</c:choose>
							<a href="${ctx}/cms/article/delete?id=${article.id}&categoryId=${article.category.id}" onclick="return confirmx('确认要删除该文章吗？', this.href)" >删除</a>
	    				</c:if>
	    				<c:choose>	
	    					<c:when test="${article.category.isAudit eq '1'}">
	    						<shiro:hasPermission name="cms:article:audit">
	    							<c:if test="${article.delFlag eq '2'}">
	    								<a href="${ctx}/cms/article/form?id=${article.id}">签发</a>
	    							</c:if>
	    							<c:if test="${article.delFlag ne '2' &&article.delFlag ne '5'}">
	    								<a href="${ctx}/cms/article/publish?id=${article.id}&categoryId=${article.category.id}"  onclick="return confirmx('确认要发布该文章吗？', this.href)" >发布</a>
	    							</c:if>
								</shiro:hasPermission>
	    					</c:when>
	    					<c:when test="${article.category.isAudit eq '0'}">
	    						<c:if test="${article.delFlag ne '1'}">
	    							<a href="${ctx}/cms/article/publish?id=${article.id}&categoryId=${article.category.id}" onclick="return confirmx('确认要发布该文章吗？', this.href)" >发布</a>
	    						</c:if>
	    					</c:when>
	    				</c:choose>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</form></div>
</body>
</html>