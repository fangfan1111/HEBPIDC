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
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				rules: {
					intervalMinute:{required:true,digits:true,range:[0,59]},
					dayOfMonth:{required:true,digits:true,range:[1,31]},
					dayOfWeek:{required:true,digits:true,range:[1,7]},
					hour:{required:true,digits:true,range:[0,23]},
					minute:{required:true,digits:true,range:[0,59]},
					intervalHour:{required:true,digits:true,range:[0,23]}
				},
				errorPlacement: function(error, element) {
					error.appendTo(element.parent());
				}
			});
		});
		function selectTaskType(){
			var type=$("#taskType").val();
			if(type==1){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.IndexStaticJob");
				$("#channelSpan").hide();
				$("#acquisitionSpan").hide();
			}else if(type==2){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.ChannelStaticJob");
				$("#channelSpan").show();
				$("#acquisitionSpan").hide();
			}else if(type==3){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.ContentStaticJob");
				$("#channelSpan").show();
				$("#acquisitionSpan").hide();
			}else if(type==3){
				$("#jobClass").val("cn.huazx.ebp.modules.cms.job.ContentStaticJob");
				$("#channelSpan").show();
				$("#acquisitionSpan").hide();
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
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsTask/">任务列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsTask/form?id=${cmsTask.id}">任务<shiro:hasPermission name="cms:cmsTask:edit">${not empty cmsTask.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsTask:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/></div>
		<div class="box-body">
	
	<form:form id="inputForm" modelAttribute="cmsTask" action="${ctx}/cms/cmsTask/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>任务名称：</label>
			<div class="col-sm-10 controls">
				<form:input path="taskName" htmlEscape="false" maxlength="255" class="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">任务类型：</label>
			<div class="col-sm-10 controls">
				<form:select path="taskType"  id="taskType" class="required" onchange="selectTaskType()">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('task_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>&nbsp;
				<span id="channelSpan">&nbsp;栏目&nbsp;
				<form:select path="attr_channelId" id="attr_channelId" class="">
					<form:option value="" label="所有栏目"/>
					<c:forEach items="${channelList}" var="channel">
						<form:option value="${channel.id}" label="${channel.name}"/>
					</c:forEach>
				</form:select></span></br></br>
				<span id="acquisitionSpan">&nbsp;采集源&nbsp;
					<form:checkboxes items="${acquisitionList}" itemLabel="acqName" itemValue="id"  path="attr_acquisitionId"/>
				</span>
				<form:hidden path="jobClass" id="jobClass"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">执行周期：</label>
			<div class="col-sm-10 controls">
				<form:radiobutton path="execycle" onclick="execycleSelect()" value="1"  class="required"/>
				<form:select path="taskIntervalUnit" onchange="selectUnit()" id="taskIntervalUnit" cssStyle="width:50px">
					<form:option value="1" label="分"/>
					<form:option value="2" label="时"/>
					<form:option value="3" label="日"/>
					<form:option value="4" label="周"/>
					<form:option value="5" label="月"/>
				</form:select>
				<span id="dayOfMonthSpan"><form:input path="dayOfMonth" id="dayOfMonthInput" htmlEscape="false" cssClass="{rangelength:[1,31]}" />日</span>
				<span id="dayOfWeekSpan"><form:input path="dayOfWeek" id="dayOfWeekInput" cssClass="{rangelength:[1,7]}"/>星期</span>
				<span id="hourSpan"><form:input path="hour" id="hourInput"  cssClass="{rangelength:[0,23]}"/>时</span>
				<span id="minuteSpan"><form:input path="minute" id="minuteInput"  cssClass="{rangelength:[0,59]}"/>分</span>
				<span id="intervalHourSpan">间隔<form:input path="intervalHour" cssClass="{digits:true,rangelength:[0,23]}" id="intervalHourInput"/>小时</span>
				<span id="intervalMinuteSpan">间隔<form:input path="intervalMinute" id="intervalMinuteInput"/>分钟</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">cron表达式：</label>
			<div class="col-sm-10 controls">
				<form:radiobutton path="execycle" onclick="execycleSelect()"  value="2"  class="required"/>
				<form:input path="cronExpression" htmlEscape="false" maxlength="255" class="form-control input-sm "/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>是否启用：</label>
			<div class="col-sm-10 controls">
				<form:radiobuttons path="isEnable" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-10 controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="form-control"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsTask:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</div>
</body>
</html>