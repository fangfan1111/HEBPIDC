<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<meta http-equiv="Expires" content="0">

	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
	<!-- Bootstrap 3.3.6 -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/font-awesome.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/ionicons.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/dist/css/AdminLTE.min.css">
	<!-- Bootstrap 3.3.6 -->
	<script src="${ctxStatic}/bootstrap3.3.6/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctxStatic}/bootstrap3.3.6/plugins/iCheck/icheck.min.js"></script>
	<link href="${ctxStatic}/bootstrap3.3.6/dist/css/login-bgd03.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
	<!--[if lt IE 9]>
	<script src="${ctxStatic}/bootstrap3.3.6/dist/js/html5shiv.min.js"></script>
	<script src="${ctxStatic}/bootstrap3.3.6/dist/js/respond.min.js"></script>
	<![endif]-->
	<!--<script src="${ctxStatic}/cryptojs/tripledes.js"></script>
	<script src="${ctxStatic}/cryptojs/mode-ecb-min.js"></script>-->
	<script type="text/javascript">

		document.onkeydown=function(){
			if (event.keyCode == 13){
				$("#loginForm").submit();
			}
		}

		$(document).ready(function() {
			$("input[name=username]").focus();
			//<c:if test="${not empty message}">alert("${message}");</c:if>
			//验证用户名
			jQuery.validator.addMethod("requiredUN", function(value, element) {
				var b = true;
				if(value==''||value=='用户名'){b = false;}
				return b;
			}, "请填写用户名");
			//验证密码
			jQuery.validator.addMethod("requiredPW", function(value, element) {
				var b = true;
				if(value==''||value=='密　码'){b = false;}
				return  b;
			}, "请填写密码");
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"},
					username: { requiredUN: true },
					password: { requiredPW: true },
					showPwd: { requiredPW: true }
				},
				messages: {
					validateCode: {remote: "验证码不正确", required: "请填写验证码"}
				},submitHandler: function(form){
					//encryptForm();
					form.submit();
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.appendTo(element.parent());
					}
				}
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		/*function encryptForm(){
			$("#password").val(encrypt($("#password").val()));
		}
		function encrypt(word){
			var encrypted = CryptoJS.DES.encrypt(word, CryptoJS.enc.Utf8.parse('${aes}'), {
				mode: CryptoJS.mode.ECB,
				padding: CryptoJS.pad.Pkcs7
			});
			return encodeURIComponent(encrypted.toString());
		}*/
	</script>

</head>
<body class="hold-transition login-page">
<div class="login-psn">
	<div class="login-bgd">
		<div class="login-dw">
			<ul class="big-box clearfix">
				<li class="oneimg"><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_1.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_1.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_2.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_3.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_4.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_5.jpg" width="100%" height="100%" /></li>
				<li><img src="${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_6.jpg" width="100%" height="100%" /></li>
			</ul>
		</div>
	</div>
	<div class="login_box_main">
		<div class="login-logo">
			<a href="${ctx}/a"><img src="${ctxStatic}/bootstrap3.3.6/dist/images/login-logo.png" /></a>
		</div>
		<div class="login-box">

			<!-- /.login-logo -->
			<div class="login-box-body">
				<div class="login-box-msg"><h3>用户登录</h3><span>还没有账号，马上<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/signup">注册</a></span></div>

				<form id="loginForm"  action="${ctx}/login" method="post">
					<!--<input type="hidden" name="aes" value="${aes}"/>-->
					<div class="form-group">
						<input type="text" id="username" name="username" class="form-text" placeholder="用户名">
					</div>
					<div class="form-group">
						<input type="password" id="password" name="password" autocomplete="off" class="form-text" placeholder="密码">
					</div>
					<c:if test="${isValidateCodeLogin}">
						<div class="validateCode">
							<sys:validateCode name="validateCode" placeholder="验证码" inputCssStyle="margin-bottom:0;width:145px;color:#999;font-size: 14px;font-weight:none;height:48px;border-radius:4px;border:1px solid #CCC;padding:0 12px;"/>
						</div>
					</c:if>
					<div style="margin-top:15px;"><sys:messagelogin content="${message}"/></div>
					<div class="form-forget">

						<!-- /.col -->
						<div class="pull-right forget-color"><a href="${pageContext.request.contextPath}${fns:getFrontPath()}/forget">忘记密码</a></div>
						<!-- /.col -->
					</div>
					<div class="form-button"><button type="submit"  class="btn btn-primary btn-block btn-flat">登 录</button></div>
				</form>

			</div>
			<!-- /.login-box-body -->
		</div>
		<%--          <sys:message content="${message}"/> --%>
		<div class="login-footer">
			<p><a href="">关于我们</a>|<a href="">联系我们</a>|<a href="">帮助中心</a></p>
			<p>版权所有©北京华志信软件股份有限公司  地址：北京市海淀区中关村南大街乙12号天作国际B座11层</p>
		</div>
	</div>
	<!-- /.login-box -->
</div>
<script>
	$(function () {
		$('input').iCheck({
			checkboxClass: 'icheckbox_square-blue',
			radioClass: 'iradio_square-blue',
			increaseArea: '20%' // optional
		});
	});
	$(document).ready(function(){
		var length=$('.big-box').children().length;
		var suij=length-1
		var random_bg=Math.floor(Math.random()*suij+1);
		var bg='url(${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_'+random_bg+'.jpg)';
		var num=100
		var cli=0
		var windowWidth = $(window).width()+17;
		var length=$('.big-box').children().length;
		$(".big-box").width(windowWidth * length);
		$(".big-box li").width(windowWidth);
		$('.oneimg img').attr('src','${ctxStatic}/bootstrap3.3.6/dist/images/bgd-img_'+random_bg+'.jpg')

		var timer=null
		timer=setInterval(autoplay,4000)

		function autoplay(){
			cli++
			num++
			if(cli>length-1){cli=0}

			$('.big-box li').eq(cli).css({zIndex:num}).hide().fadeIn();
		}
	});
</script>
<script type="text/javascript">
	(function(w){if(!("WebSocket"in w&&2===w.WebSocket.CLOSING)){var d=document.createElement("div");d.className="browsehappy";d.innerHTML='<div style="width:100%;height:50px;font-size:20px;line-height:50px;text-align:center;background-color:#fae692;color:#fff;margin-bottom:5px;">\u60A8\u6B63\u5728\u4F7F\u7528\u4F4E\u7248\u672C\u6D4F\u89C8\u5668\uFF0C\u5728\u672C\u9875\u9762\u53EF\u80FD\u4F1A\u5BFC\u81F4\u90E8\u5206\u529F\u80FD\u65E0\u6CD5\u4F7F\u7528\u3002\u5EFA\u8BAE\u60A8\u5347\u7EA7\u5230\u6700\u65B0\u7248\u672C<a target="_blank" href="http://browsehappy.osfipin.com/" style="background-color:#31b0d5;border-color: #269abc;text-decoration: none;padding: 6px 12px;background-image: none;border: 1px solid transparent;border-radius: 4px;color:#FFEB3B;">\u7acb\u5373\u5347\u7ea7</a></div>';var f=function(){var s=document.getElementsByTagName("body")[0];if("undefined"==typeof(s)){setTimeout(f,10)}else{s.insertBefore(d,s.firstChild)}};f()}}(window));
</script>
</body>
</html>