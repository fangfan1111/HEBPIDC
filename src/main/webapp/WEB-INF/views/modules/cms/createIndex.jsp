<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>全文检索</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		function createIndex() {
			var button = $("#createButton");
			var value = button.val();
			button.val("正在生成,请稍等...").attr("disabled","disabled");
			$.post("${ctx}/cms/article/o_createIndex",
				{
					channelId:$("#channelId option:selected").val(),
					startDate:$("#startDate").val(),
					endDate:$("#endDate").val()
				},
				function(data) {
				button.val(value).removeAttr("disabled");
				alert(data.msg);
			},"json");
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
			<label class="control-label">开始时间:</label>
			<div class="controls">
				<input name="startDate" id="startDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间:</label>
			<div class="controls">
				<input name="endDate" id="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="" onclick="WdatePicker({minDate:'#F{$dp.$D(\'startDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-actions">
			<input class="btn btn-primary" id="createButton" type="button" value="生成索引" onclick="createIndex()"/>
		</div>
		</shiro:hasPermission>
	</div>
</body>
</html>