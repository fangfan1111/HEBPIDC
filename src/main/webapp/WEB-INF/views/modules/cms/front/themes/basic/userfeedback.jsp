<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>在线反馈</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
	<style type="text/css">
		.frm_tips{color: #8D8D8D}
		#nav {background: none repeat scroll 0% 0% transparent;width: 100%;z-index: 1;}
		#nav .nav-2 { height: 20px; background: url("${ctxStatic}/custom/images/reg_hr_e84a6d3b.png") no-repeat scroll center top transparent;}
		#head {font-size: 18px;color: #353644;font-weight: normal;font-family: "KaiTi";}
		.btn.btn-large{width:150px;height:34px;font-size: 16px;font-weight: bold;cursor: pointer;color: #FFF;background-image: none;border-radius: 3px;border: medium none;transition: all 0.3s ease 0s;margin-left:135px;float:left;}
		.group_01{width:480px;margin:0 auto;overflow:hidden;}
		.control-label{float:left;width:75px;text-align:right;font-weight:normal;color:#666;}
		.form-control{width:300px;height:28px;border:1px #ddd solid;border-radius:0;float:left;margin-left:15px;}
		.frm_tips{float:left;margin-top:10px;margin-left:15px;}
		.help-inline{float:left;margin-top:7px;margin-left:10px;}
		.control-group{margin-top:15px;}
		.btn-primary{background:#f04848;}
		.btn-primary:hover{background:#f25b5b;}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			<c:if test="${not empty message}">alert("${message}");</c:if>
			//验证反馈
			$("#inputForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					validateCode: {remote: "验证码不正确", required: "请填写验证码"}
				}
			});
		});
	</script>
</head>
<body>
	<div style="padding:5px 220px 10px 220px;">
		<div id="head" style="font-size:18px;color:red;">
			在线反馈
		</div>
		<div id="nav">
			<div class="nav-2">
				<div class="mod-nav clearfix">
					<h1 class="page-type-notab"></h1>
				</div>
			</div>
		</div>
		<form:form id="inputForm" action="${ctx}/termssearch/userFavorite/savefeedback" method="post" class="form-horizontal">
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">反馈类型:</label>
					<div class="controls">
						 <select name="feedbackType" id="feedbackType" style="width:255px;  padding:5px; height:30px;" class="required">
	                            	 <option value ="">请选择</option>
	                            	 <c:forEach items="${fns:getDictList('user_feed_back')}" var="dict">
							             <option value ="${dict.value}">${dict.label}</option>
									</c:forEach>
                           </select>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">反馈内容:</label>
					<div class="controls">
						<textarea name="feedbackInfo" id="feedbackInfo" tabindex="3" rows="6" style="width:400px; padding:5px; height:250px;font-size:14px;" maxlength="200" class="required"></textarea>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="group_01">
					<label class="control-label">验证码:</label>
					<div class="controls">
						<sys:validateCode inputCssStyle="width:80px;height:28px;border:1px #ddd solid;border-radius:0;float:left;margin-left:15px;margin-right:10px;" name="validateCode" />
					</div>
				</div>
			</div>
			<div style="padding:5px 220px 10px 220px;">
				<input class="btn btn-large btn-primary" type="submit" value="提交反馈"/>
			</div>
		</form:form>
	</div>
</body>
</html>