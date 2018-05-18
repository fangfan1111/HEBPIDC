<%@ page import="cn.huazx.ebp.modules.sys.security.CsrfTokenManager" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>首页静态化</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		var headers = {};
		headers['__RequestVerificationToken'] = "<%=session.getAttribute(CsrfTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME)%>";
	function createIndex() {
		var button = $("#createButton");
		var value = button.val();
		button.val("正在生成,请稍等...").attr("disabled","disabled");
		$.ajax({
			type: "POST",
			cache: false,
			headers: headers,
			url: "${ctx}/cms/static/o_index",
			dataType:"json",
			async: true,
			error: function(data, error) {},
			success: function(data)
			{
				button.val(value).removeAttr("disabled");
				if(data.success) {
					alert('生成成功');
				} else {
					alert(data.msg);
				}
			}
		});
	}
	function deleteIndex() {
		$.ajax({
			type: "POST",
			cache: false,
			headers: headers,
			url: "${ctx}/cms/static/o_index_remove",
			dataType:"json",
			async: true,
			error: function(data, error) {},
			success: function(data)
			{
				if(data.success) {
					alert('删除成功');
				} else {
					alert('文件不存在');
				}
			}
		});
	}
	</script>
</head>
<body>
	<div class="form-actions">
		<shiro:hasPermission name="cms:static:edit">
	<input class="btn btn-primary"id="createButton" type="button" value="生成首页HTML" onclick="createIndex();"/>
&nbsp; <input class="btn btn-primary" id="deleteButton" type="button" value="删除首页HTML" onclick="deleteIndex();"/>
		</shiro:hasPermission>
	</div>
</body>
</html>