<%@ page import="cn.huazx.ebp.modules.sys.security.CsrfTokenManager" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>栏目静态化</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		var headers = {};
		headers['__RequestVerificationToken'] = "<%=session.getAttribute(CsrfTokenManager.CSRF_TOKEN_FOR_SESSION_ATTR_NAME)%>";
		function createChannels() {
			var button = $("#createButton");
			var value = button.val();
			button.val("正在生成,请稍等...").attr("disabled","disabled");
			$.ajax({
				type: "POST",
				cache: false,
				data:{
					channelId:$("#channelId option:selected").val(),
					containChild:$("input[name='containChild']:checked").val()},
				headers: headers,
				url: "${ctx}/cms/static/o_channel",
				dataType:"json",
				async: true,
				error: function(data, error) {},
				success: function(data)
				{
					button.val(value).removeAttr("disabled");
					if(data.success) {
						alert('生成成功,生成栏目数'+data.count+'个');
					} else {
						alert(data.msg);
					}
				}
			});
		}
	</script>
</head>
<body>
	<div class="form-horizontal">
		<shiro:hasPermission name="cms:static:edit">
		<div class="control-group">
			<label class="control-label">栏目:</label>
			<div class="controls">
				<select name="channelId" id="channelId">
					<option value="">所有栏目
					<c:forEach items="${channelList}" var="channel">
						<option value="${channel.id}">${channel.name}
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">更新子栏目:</label>
			<div class="controls">
				<c:forEach items="${fns:getDictList('yes_no')}" var="dict">
				 	<input type="radio"  name="containChild" id="containChild" value="${dict.value}" <c:if test="${dict.value =='1'}">checked</c:if>>${dict.label}
				</c:forEach>
			</div>
		</div>
		<div class="form-actions">
			<input class="btn btn-primary" id="createButton" type="button" value="生成栏目页HTML" onclick="createChannels()"/>
		</div>
		</shiro:hasPermission>
	</div>
</body>
</html>