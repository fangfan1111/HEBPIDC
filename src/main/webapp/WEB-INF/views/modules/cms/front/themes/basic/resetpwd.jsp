<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>重设密码</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<style type="text/css">
	.password_box {
	    margin-top: 50px;
	    border-radius: 0px;
	    border: 0px none;
	    overflow: hidden;
		position: relative;
		height:auto!important;height:400px; min-height:400px;
	}
	.btn.btn-large{
		font-size: 15px;
		min-width: 108px;
		line-height: 32px;
		border-radius: 3px;
	 	border: 0px none;
		cursor: pointer;
		padding: 0px 22px;
		margin: 0px 80px 0px 10px;
		text-decoration: none;
	} 
	.btn-primary{background:#f04848;}
	.btn-primary:hover{background:#f25b5b;}
	.ps_con {
	    padding: 15px 15px 65px 500px;
	    min-height: 215px;
	    overflow: hidden;
	}
	.tool_bar {
	    padding: 10px;
	    text-align: center;
	}
	.imgps_con {
	    padding: 65px 15px 65px 500px;
	    min-height: 265px;
	    overflow: hidden;
	}
	.left_con {
	    float: left;
	    margin-right: 10px;
	    margin-top: 4px;
	}
	.ico_suc {
		vertical-align: middle;
		border: 0px none;
	}
	.right_con {
	    overflow: hidden;
	}
	.control-label{font-weight:normal;color:#666;}
	 </style>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#inputForm").validate({
			rules: {
				newPassword: {rangelength:[6,16]}
			},
			messages: {
				newPassword:{rangelength: $.format("密码最小长度:{0}, 最大长度:{1}。")},
				confirmNewPassword: {equalTo: "输入与上面相同的密码"}
			},
			errorContainer: "#messageBox",
			errorPlacement: function(error, element) {
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
		<div class="password_box">
			<c:choose>
				<c:when test="${msg=='init'}">
					<form:form id="inputForm" action="${ctx}/resetpwd" class="form-inline" method="post">
						<input type="hidden" name="check" value="${check}">
						<div class="ps_con">
							<div class="p_con_wrp">
								<p class="p_con">
									<label class="control-label">新密码：</label>
								</p>
								<input name="newPassword"  id="newPassword" type="password" style="width:300px;"  class="required form-control" />
								<span class="help-inline"><font color="red">*</font> </span>
								<p class="p_con">
									<label class="control-label">重复输入新密码:</label>
								</p>
								<input id="confirmNewPassword" name="confirmNewPassword" style="width:300px;" type="password" value="" maxlength="50"  class="required form-control" equalTo="#newPassword"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
						<div class="tool_bar">
							<input type="submit" class="btn btn-large btn-primary" value="重置密码"/>
						</div>
					</form:form>
				</c:when>
				<c:otherwise>
						<c:choose>
							<c:when test="${msg=='您的密码已重设成功'}">
								<div class="imgps_con">
									<div class="left_con">
										<img alt="成功" src="${ctxStatic}/custom/images/msg_success.png" class="ico_suc">
									</div>
									<div class="right_con">
										<p style="padding:15px">
											<label class="control-label">${msg}</label>
										</p>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="imgps_con">
									<div class="left_con">
										<img alt="失败" src="${ctxStatic}/custom/images/msg_warn.png" class="ico_suc">
									</div>
									<div class="right_con">
										<p style="padding:15px">
											<label class="control-label">${msg}</label>
										</p>
									</div>
								</div>
								<div class="tool_bar">
									<a href="${ctx}/forget" class="btn btn-large btn-primary">重新找回密码</a>
								</div>
							</c:otherwise>
						</c:choose>
					
       			</c:otherwise>
			</c:choose>
		</div>
</body>
</html>