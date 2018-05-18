<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>采集进度</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
	function checkComplete(){
		$.post("${ctx}/cms/cmsAcquisition/v_check_complete",{acquisitionId:"${acquisitionId}"},function(data){
			if(!data){
				createProgress();
			}
		},"json");
	}

	function setBar(percent,infor, message) {
		$("#bar").attr("width",6*percent);
		$("#percent").html(percent + "%");
		infor.html(message);
	}

	function createProgress() {
		$.post("${ctx}/cms/cmsAcquisition/v_progress_data",{acquisitionId:"${acquisitionId}"},function(data){
			$("#progressContainer").html(data);
			messageBox = $("#messageBox");
			if (percent >= 100){
				setBar(percent,messageBox, "采集完成");
				checkComplete();
			}else {
			setBar(percent,messageBox, "正在采集");
			setTimeout(createProgress, 1000);
			}
		});
	}

	$(function() {
		createProgress();
	});
	</script>
</head>
<body>
	<div id="progressContainer"></div>
</body>
</html>