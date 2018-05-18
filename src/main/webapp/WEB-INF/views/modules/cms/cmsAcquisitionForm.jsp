<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>采集源管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			jQuery.validator.addMethod("URLS",function(c,a){
				var planList = $("#planList").val();// 静态地址
		      	var dynamicAddr = $("#dynamicAddr").val();// 动态地址
		      	if(planList==''&&dynamicAddr==''){return false;}else{
		      		if(planList==''&&$('#planList').next().attr("class")=='error'){$('#planList').next().remove();}
		      		if(dynamicAddr==''&&$('#dynamicAddr').next().attr("class")=='error'){$('#dynamicAddr').next().remove();}	
	      		return true;}
	    	},"采集地址或动态地址至少填写一个");
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
<div class="nav-tabs-custom">

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsAcquisition/">采集源列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsAcquisition/form?id=${cmsAcquisition.id}">采集源<shiro:hasPermission name="cms:cmsAcquisition:edit">${not empty cmsAcquisition.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsAcquisition:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/></div>
	
	<form:form id="inputForm" modelAttribute="cmsAcquisition" action="${ctx}/cms/cmsAcquisition/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
			<table class="table-form">
				<tr>
					<td class="tit">采集名称:</td><td>
						<form:input path="acqName" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">栏目:</td>
					<td>
						<form:select path="channelId" class="input-xlarge required">
							<form:option value="" label="请选择"/>
							<c:forEach items="${channelList}" var="channel">
								<form:option value="${channel.id}" label="${channel.name}"/>
							</c:forEach>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">页面编码:</td><td>
						<form:radiobutton path="pageEncoding" value="UTF-8"  label="UTF-8"/>
						<form:radiobutton path="pageEncoding" value="GBK" label="GBK"/>
						<form:radiobutton path="pageEncoding" value="GB2312" label="GB2312"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">暂停时间(毫秒)：</td><td>
						<form:input path="pauseTime" htmlEscape="false"  maxlength="11" class="input-small required digits"/>
						<span class="help-inline"><font color="red">*</font> </span><span class="help-inline">每采集一篇文章暂停时间。单位(毫秒)</span>
					</td>
				</tr>
				<tr>
					<td class="tit">是否采集图片:</td><td>
						<form:radiobutton path="imgAcqu" value="1" maxlength="1" label="是"/>
						<form:radiobutton path="imgAcqu" value="0" maxlength="1" label="否"/>
						<span class="help-inline"><font color="red">*</font> </span>
						<span class="help-inline">采集图片比较慢 </span>
					</td>
					<td class="tit">是否采集附件:</td><td>
						<form:radiobutton path="fileAcqu" value="1" maxlength="1" label="是"/>
						<form:radiobutton path="fileAcqu" value="0" maxlength="1" label="否"/>
						<span class="help-inline"><font color="red">*</font> </span>
						<span class="help-inline">采集附件比较慢 </span>
					</td>
				</tr>
				<tr>
					<td class="tit">是否采集表格数据：</td>
					<td colspan="5">
						<form:radiobutton path="tableAcqu" value="1" maxlength="1" label="是"/>
						<form:radiobutton path="tableAcqu" value="0" maxlength="1" label="否"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">采集地址：</td>
					<td colspan="5">
						<form:textarea path="planList" class="URLS" rows="5" maxlength="500" htmlEscape="false" cssStyle="width:500px"/>
						<br/><span class="help-inline">一个地址一行</span>
					</td>
				</tr>
				<tr>
					<td class="tit">动态地址：</td>
					<td colspan="5">
						<form:input path="dynamicAddr" cssStyle="width:500px" htmlEscape="false" maxlength="255" class="input-xlarge URLS"/>
						<span class="help-inline">如：http://roll.mil.news.sina.com.cn/col/zgjq/index_(*).shtml,页码使用(*)作为通配符</span>
						<br/>页码从:<form:input path="dynamicStart" htmlEscape="false" maxlength="3" cssStyle="width:50px;" class="digits"/>
						&nbsp;到&nbsp;<form:input path="dynamicEnd" htmlEscape="false" maxlength="3"  cssStyle="width:50px;"  class="digits"/>
					</td>
				</tr>
				<tr>
					<td class="tit">内容地址补全url：</td>
					<td colspan="5">
						<form:input path="contentPrefix" cssStyle="width:500px"  htmlEscape="false" maxlength="255" class="input-xlarge "/>
						<span class="help-inline">查看采集地址源代码,内容地址是否带有访问域名，没有补全url</span>
					</td>
				</tr>
				<tr>
					<td class="tit">图片地址补全url：</td>
					<td colspan="5">
						<form:input path="imgPrefix"  cssStyle="width:500px" htmlEscape="false" maxlength="255" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">附件地址补全url：</td>
					<td colspan="5">
						<form:input path="filePrefix"  cssStyle="width:500px" htmlEscape="false" maxlength="255" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">内容地址集：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">开始HTML</td>
								<td align="center" width="50%">结束HTML</td>
							</tr>
							<tr>
								<td align="center" width="50%">
									<form:textarea path="linksetStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
								<td align="center" width="50%">
									<form:textarea path="linksetEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">内容地址：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="linkStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
								<td align="center" width="50%">
									<form:textarea path="linkEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">标题：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="titleStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
								<td align="center" width="50%">
									<form:textarea path="titleEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">摘要描述：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="descriptionStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
								<td align="center" width="50%">
									<form:textarea path="descriptionEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">正文：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="contentStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
								<td align="center" width="50%">
									<form:textarea path="contentEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge required"/>
									<span class="help-inline"><font color="red">*</font> </span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">来源：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="originStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
								<td align="center" width="50%">
									<form:textarea path="originEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">附件：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="fileStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
								<td align="center" width="50%">
									<form:textarea path="fileEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tit">发布时间：</td>
					<td colspan="5">
						<table border="0" width="100%">
							<tr>
								<td align="center" width="50%">
									<form:textarea path="releasetimeStart" cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
								<td align="center" width="50%">
									<form:textarea path="releasetimeEnd"  cssStyle="width:90%" htmlEscape="false" rows="3" maxlength="255" class="input-xlarge "/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
			</table>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsAcquisition:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>