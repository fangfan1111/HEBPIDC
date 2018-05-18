<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模板管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div id="content" class="row-fluid">
		<div id="left">
			<iframe id="cmsMenuFrame" name="cmsMenuFrame" src="${ctx}/cms/template/tree" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%"></iframe>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="cmsMainFrame" name="cmsMainFrame" src="${ctx}/cms/template/list" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%"></iframe>
		</div>
	</div>
	<script type="text/javascript"> 
		var leftWidth = "180"; // 左侧窗口大小
		function wSize(){
			var strs=getWindowSize().toString().split(",");
			$("#cmsMenuFrame, #cmsMainFrame, #openClose").height(strs[0]-5);
			$("#right").width($("body").width()-$("#left").width()-$("#openClose").width()-5);
		}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>