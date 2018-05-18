<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>评论管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		function view(href){
			top.$.jBox.open('iframe:'+href,'查看文档',$(top.document).width()-220,$(top.document).height()-180,{
				buttons:{"关闭":true},
				loaded:function(h){
					//$(".jbox-content", top.document).css("overflow-y","hidden");
					//$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
				}
			});
			return false;
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
		<li class="active"><a href="${ctx}/cms/comment/">评论列表</a></li><%--
		<shiro:hasPermission name="cms:comment:edit"><li><a href="${ctx}/cms/comment/form?id=${comment.id}">评论添加</a></li></shiro:hasPermission> --%>
	</ul></div>
	<div class="box-body">
	<form:form id="searchForm" modelAttribute="comment" action="${ctx}/cms/comment/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
		<div class="form-group">
		<label class="col-sm-2 control-label">文档标题：</label>
		<div class="col-sm-4">
		<form:input path="title" htmlEscape="false" maxlength="50" class="form-control input-sm"/>
		</div>
<!-- 		</div> -->
<!-- 		<div class="form-group"> -->
		<label class="col-sm-1 control-label">状态：</label>
		<div class="col-sm-5 form-float-span">
		<form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" />
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
	<table id="contentTable" class="table table-bordered table-condensed">
		<thead><tr><th>评论内容</th><th>文档标题</th><th>评论人</th><th>评论IP</th><th>评论时间</th><th nowrap="nowrap">操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="comment">
			<tr>
				<td><a href="javascript:" onclick="$('#c_${comment.id}').toggle()">${fns:abbr(fns:replaceHtml(comment.content),40)}</a></td>
				<td><a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-${comment.category.id}-${comment.contentId}${fns:getUrlSuffix()}" title="${comment.title}" onclick="return view(this.href);">${fns:abbr(comment.title,40)}</a></td>
				<td>${comment.name}</td>
				<td>${comment.ip}</td>
				<td><fmt:formatDate value="${comment.createDate}" type="both"/></td>
				<td><shiro:hasPermission name="cms:comment:edit">
					<c:if test="${comment.delFlag ne '2'}"><a href="${ctx}/cms/comment/delete?id=${comment.id}${comment.delFlag ne 0?'&isRe=true':''}" 
						onclick="return confirmx('确认要${comment.delFlag ne 0?'恢复审核':'删除'}该审核吗？', this.href)">${comment.delFlag ne 0?'恢复审核':'删除'}</a></c:if>
					<c:if test="${comment.delFlag eq '2'}"><a href="${ctx}/cms/comment/save?id=${comment.id}">审核通过</a></c:if></shiro:hasPermission>
				</td>
			</tr>
			<tr id="c_${comment.id}" style="background:#fdfdfd;display:none;"><td colspan="6">${fns:replaceHtml(comment.content)}</td></tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>