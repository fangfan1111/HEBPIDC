<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>内容管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div id="content" class="row-fluid">
		<div id="left">
			<iframe id="cmsMenuFrame" name="cmsMenuFrame" src="${ctx}/cms/tree" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%" onload="this.height=cmsMenuFrame.document.body.scrollHeight;parent.document.getElementById('mainFrame').style.height= document.body.scrollHeight + 'px';"></iframe>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			<iframe id="cmsMainFrame" name="cmsMainFrame" src="${ctx}/cms/none" style="overflow:visible;"
				scrolling="yes" frameborder="no" width="100%" onload="this.height=cmsMainFrame.document.body.scrollHeight;parent.document.getElementById('mainFrame').style.height= document.body.scrollHeight + 'px';"></iframe>
		</div>
	</div>
	<script type="text/javascript"> 
	 var myheight=500;
	var cmsmain=500;
	$(function(){
		$("#cmsMenuFrame").load(function () {
			myheight = $(this).contents().find("body").height() + 100;
			if(myheight<500)
				{
				myheight=500;
				}
		});
	});
// 	$(function(){
// 		$("#cmsMainFrame").load(function () {
// 			cmsmain = $(this).contents().find("body").height() + 100;
// 			if(cmsmain<500)
// 				{
// 				cmsmain=500;
// 				}
// 		});
// 	});
		var leftWidth = "180"; // 左侧窗口大小
		function wSize(){
			var strs=getWindowSize().toString().split(",");
		//	$("#cmsMenuFrame, #cmsMainFrame, #openClose").height(strs[0]-5);
	        $("#left").height(myheight);
			 $("#openClose").height(myheight);
			$("#right").width($("body").width()-$("#left").width()-$("#openClose").width()-4);
		}
		// 鼠标移动到边界自动弹出左侧菜单
		$("#openClose").mouseover(function(){
			if($(this).hasClass("open")){
				$(this).click();
			}
		});
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>