<%@ page import="cn.huazx.ebp.modules.sys.security.CsrfTokenManager" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>模板列表</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
    <style>
        h1, h2, h3, .masthead p, .subhead p, .marketing h2, .lead {
            font-family: "Helvetica Neue", Helvetica, Arial, "Microsoft Yahei UI", "Microsoft YaHei", SimHei, "\5B8B\4F53", simsun, sans-serif;
            font-weight: normal;
        }
    </style>
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
	    	$.jBox.confirm("确认要删除数据吗？","系统提示",function(v,h,f){
				if(v=="ok"){
					$("#tableForm").attr("action","${ctx}/cms/template/o_delete");
					$("#tableForm").submit();
				}
			},{buttonsFocus:1});
			$('.jbox-body .jbox-icon').css('top','55px');
	    }
	    function Delete(name){
	    	$.jBox.confirm("确认要删除数据吗？","系统提示",function(v,h,f){
				if(v=="ok"){
					$("#tableForm").attr("action","${ctx}/cms/template/o_delete_single?name="+name);
					$("#tableForm").submit();
				}
			},{buttonsFocus:1});
			$('.jbox-body .jbox-icon').css('top','55px');
	    }
    </script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/template/list?root=${root}">模板列表</a></li>
		<shiro:hasPermission name="cms:template:edit"><li><a href="${ctx}/cms/template/add?root=${root}">创建模板</a></li></shiro:hasPermission>
	</ul>
	<form:form id="inputForm" modelAttribute="fileTpl" action="${ctx}/cms/template/create_dir" method="post" cssStyle="padding:10px 6px;">
		<input type="hidden" name="root" value="${root}"/>
		<table border="0" style="padding-top:3px">
		<tr>
			<td>当前目录: ${root}</td>
			<td>
			&nbsp; 新建目录: <input type="text" name="dirName" style="width:280px;height:30px;border:1px #d2d6de solid;margin:0 8px 0 3px;" size="10" onkeypress="if(event.keyCode==13){$('#dirButton').click();return false;}"/>
				<input class="btn btn-primary" id="dirButton" type="submit" value="新建"/>
			</td>
		</tr>
		</table>
	</form:form>
<sys:message content="${message}"/>
<div class="content-padding">
<form:form id="tableForm" method="post">
	<input type="hidden" name="root" value="${root}"/>
   <table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th style="width:25px;"><input name="SelectAll" id="SelectAll" type='checkbox' onclick='selectAll()'/><th style="width:25px;"></th><th>文件名</th><th>大小</th><th>最后修改日期</th>
		<shiro:hasPermission name="cms:template:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${list}" var="template">
			<tr>
				<td style="width:25px;"><input type='checkbox' name='names' value='${template.name}' /></td>
				<td style="width:25px;">
				<img src="${ctxStatic}/custom/images/${template.directory?'folder':'html'}.gif"/>
				</td>
				<td>${template.filename}</td>
				<td>${template.size} KB</td>
				<td><fmt:formatDate value="${template.lastModifiedDate}" pattern="yyyy/MM/dd  HH:mm:ss" /></td>
				<shiro:hasPermission name="cms:template:edit"><td>
				<a href="${ctx}/cms/template/v_rename?root=${root}&name=${template.filename}">重命名</a>
					<c:if test="${!template.directory}">
						<a href="${ctx}/cms/template/form?name=${root}/${template.filename}">修改</a>
					</c:if>
    				<a onclick="Delete('${template.name}')" href="javascript:">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
		<input type="button" value="删除" onclick="optDelete();"  class="btn btn-primary">
	</div>
</form:form>
</div>
</div>
</body>
</html>