<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>任务管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			controlInput();
			execycleSelect();
			selectTaskType();
		});
		function selectTaskType(){
			var type=$("#taskType").val();
			if(type==1){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.IndexStaticJob");
				$("#channelSpan").hide();
			}else if(type==2){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.ChannelStaticJob");
				$("#channelSpan").show();
			}else if(type==3){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.ContentStaticJob");
				$("#channelSpan").show();
			}else if(type==4){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.CmsAcquisitionJob");
				$("#channelSpan").hide();
				$("#acquisitionSpan").show();
			}
		}
		function execycleSelect(){
			var execycleValue=1;
			$("input[name='execycle']").each(function(){
				if($(this).prop("checked")){
					execycleValue=$(this).val();
				}
			});
			if(execycleValue==1){
				$("#dayOfMonthInput").prop("disabled","");
				$("#dayOfWeekInput").prop("disabled","");
				$("#hourInput").prop("disabled","");
				$("#minuteInput").prop("disabled","");
				$("#intervalHourInput").prop("disabled","");
				$("#intervalMinuteInput").prop("disabled","");
				$("#taskIntervalUnit").prop("disabled","");
				$("#cronExpression").prop("disabled","disabled");
			}else{
				$("#dayOfMonthInput").prop("disabled","disabled");
				$("#dayOfWeekInput").prop("disabled","disabled");
				$("#hourInput").prop("disabled","disabled");
				$("#minuteInput").prop("disabled","disabled");
				$("#intervalHourInput").prop("disabled","disabled");
				$("#intervalMinuteInput").prop("disabled","disabled");
				$("#taskIntervalUnit").prop("disabled","disabled");
				$("#cronExpression").prop("disabled","");
			}
		}
		function controlInput(){
			var intervalUnitValue = $("#taskIntervalUnit").val();
			$("span[id$='Span']").each(function(){
				$(this).hide();
			});
			$("input[id$='Input']").each(function(){
				$(this).prop("disabled","disabled");
			});
			if(intervalUnitValue==1){
				$("#intervalMinuteSpan").show();
				$("#intervalMinuteInput").prop("disabled","");
			}else if(intervalUnitValue==2){
				$("#intervalHourSpan").show();
				$("#intervalHourInput").prop("disabled","");
			}else if(intervalUnitValue==3){
				$("#hourSpan").show();
				$("#minuteSpan").show();
				$("#hourInput").prop("disabled","");
				$("#minuteInput").prop("disabled","");
			}else if(intervalUnitValue==4){
				$("#dayOfWeekSpan").show();
				$("#hourSpan").show();
				$("#minuteSpan").show();
				$("#dayOfWeekInput").prop("disabled","");
				$("#hourInput").prop("disabled","");
				$("#minuteInput").prop("disabled","");
			}else if(intervalUnitValue==5){
				$("#dayOfMonthSpan").show();
				$("#hourSpan").show();
				$("#minuteSpan").show();
				$("#dayOfMonthInput").prop("disabled","");
				$("#hourInput").prop("disabled","");
				$("#minuteInput").prop("disabled","");
			}
		}
		function selectUnit(){
			var intervalUnitValue=$("#taskIntervalUnit").val();
			controlInput(intervalUnitValue);
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsTask/">任务列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsTask/view?id=${cmsTask.id}">任务查看</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmsTask" action="${ctx}/cms/cmsTask/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="col-sm-2 control-label">任务名称：</label>
			<div class="col-sm-10 controls">
				<div class="input-xlarge">${cmsTask.taskName}</div>
			</div>
		</div>
		<div class="control-group">
			<label class="col-sm-2 control-label">任务类型：</label>
			<div class="col-sm-10 controls">
				<form:hidden path="taskType"/>
				${fns:getDictLabel(cmsTask.taskType,'task_type','')}&nbsp;
				<span id="channelSpan">
				<form:select path="attr_channelId" id="attr_channelId" class="input-xlarge">
					<form:option value="" label="所有栏目"/>
					<c:forEach items="${channelList}" var="channel">
						<form:option value="${channel.id}" label="${channel.name}"/>
					</c:forEach>
				</form:select></span>
				<span id="acquisitionSpan">
					<form:checkboxes disabled="true" items="${acquisitionList}" itemLabel="acqName" itemValue="id"  path="attr_acquisitionId"/>
				</span>
				<form:hidden path="jobClass" id="jobClass"/>
			</div>
		</div>
		<div class="control-group">
			<label class="col-sm-2 control-label">执行周期：</label>
			<div class="col-sm-10 controls">
			   <form:hidden path="execycle" />
			   <form:hidden path="taskIntervalUnit" />
				<span id="dayOfMonthSpan">${cmsTask.dayOfMonth}日</span>
				<span id="dayOfWeekSpan">${cmsTask.dayOfWeek}星期</span>
				<span id="hourSpan">${cmsTask.hour}时</span>
				<span id="minuteSpan">${cmsTask.minute}分</span>
				<span id="intervalHourSpan">间隔${cmsTask.intervalHour}小时</span>
				<span id="intervalMinuteSpan">间隔${cmsTask.intervalMinute}分钟</span>
			</div>
		</div>
		<div class="control-group">
			<label class="col-sm-2 control-label">cron表达式：</label>
			<div class="col-sm-10 controls">
				${cmsTask.cronExpression}
			</div>
		</div>
		<div class="control-group">
			<label class="col-sm-2 control-label">是否启用：</label>
			<div class="col-sm-10 controls">
				${fns:getDictLabel(cmsTask.isEnable,'yes_no','')}
			</div>
		</div>
		<div class="control-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-10 controls">
				${cmsTask.remarks}
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>