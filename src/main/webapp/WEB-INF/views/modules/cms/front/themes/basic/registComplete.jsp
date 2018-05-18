<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>注册成功</title>
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
		font-size: 14px;
		min-width: 50px;
		line-height: 25px;
		border-radius: 3px;
	 	border: 0px none;
		cursor: pointer;
		padding: 0px 10px;
		margin: 5px 12px 0px 0px;
		text-decoration: none;
	} 
	.btn-primary{background:#f04848;}
	.btn-primary:hover{background:#f25b5b;}
	.btn-primary1{background:#286090;color:#fff;}
	.btn-primary:hover1{background:#f25b5b;color:#fff;}
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
	    margin:65px auto;
	    width:1000px;
	    min-height: 265px;
	    overflow: hidden;
	}
	.left_con {
		width:46px;
		height:46px;
	    margin:10px auto;
	}
	.ico_suc {
		vertical-align: middle;
		border: 0px none;
	}
	.right_con {
	    overflow: hidden;
	    width:1000px;
	    text-align:center;
	    line-height:35px;
	}
	.control-label{font-weight:normal;color:#666;font-size: 14px;}
	.control-label span{font-weight:bold;color:red;font-size: 14px;}
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
								<div class="imgps_con">
									<div class="left_con">
										<img alt="成功" src="${ctxStatic}/custom/images/msg_success.png" class="ico_suc">
									</div>
									<div class="right_con">
										<p style="padding:10px;">
											<label class="control-label">恭喜您<span>注册成功</span>，您的登陆账号为：<span>${LoginName}</span>。
											<br/>您可以:<a href="${ctx}"  class="btn btn-large btn-primary" style="margin-top:0px;margin-left:15px;">返回首页</a>
													   <a href="javascript:void(0)" onclick="loginIn();" class="btn btn-large btn-primary1" style="color:#fff;margin-top:0px;">立即登录</a>
											</label>
										</p>
									</div>
								</div>
		</div>
</body>
</html>