<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>找回密码</title>
	<script src="${ctxStatic}/jquery.steps-1.1.0/jquery.steps.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/jquery.steps-1.1.0/css/jquery.steps.css">
	<script type="text/javascript">document.ondragstart = function(event) {return false;}</script>
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
		height: auto !important;
		height: 400px;
		min-height: 400px;
	}

	.btn.btn-large {
		font-size: 15px;
		min-width: 108px;
		line-height: 32px;
		border-radius: 3px;
		border: 0px none;
		cursor: pointer;
		padding: 0px 22px;
		margin: 0px 0px 0px 10px;
		text-decoration: none;
	}

	.ps_con {
		padding: 65px 15px 65px 350px;
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

	.control-label {
		font-weight: normal;
		color: #666;
		margin-top: 10px;
	}
	</style>
	<script type="text/javascript">

		$(function(){
			 $("#successdiv").hide();
			 $("#errordiv").hide();
			 $("#checkdiv").hide();
		});
		$("#example-basic").steps({
			headerTag: "h3",
			bodyTag: "section",
			transitionEffect: "slideLeft",
			autoFocus: true
		});

		function ajaxChck()
		{
			layer.msg('信息验证中...');
			var returns=true;
			var url="${ctx}/ajaxCheckEmail";
			var usernme=$("#userName").val();
			var emails=$("#email").val();
			$.ajax({
				type:"POST",
				url:url,
				data: "username="+usernme+"&emails="+emails,
				cache: false,
				async : false,
				dataType: "json",
				   success: function (data ,textStatus, jqXHR)
					{
						if("true"==data.flag){
							layer.msg('邮件发送中...');
						}else{
							 $("#checkdiv").show();
						//	layer.msg('验证失败！用户名或者邮箱不匹配。', {icon: 5});
							//alert("验证失败！用户名或者邮箱不匹配。");
							returns= false;
						}
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
						layer.msg('请求失败！请稍后再试。', {icon: 5});
						returns= false;
					}

			});
			return returns;
		}

		function ajaxSubmit()
		{
			var returns=true;
			var url="${ctx}/forgets";
			var emails=$("#email").val();
			$.ajax({
				type:"POST",
				url:url,
				data: "email="+emails,
				cache: false,
				async : false,
				dataType: "json",
				   success: function (data ,textStatus, jqXHR)
					{
						if("true"==data.flag){
					   $("#successdiv").show();
						}else{
							 $("#errordiv").show();
							returns= false;
						}
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
						 $("#errordiv").show();
						returns= false;
					}

			});
			return returns;
		}
		function reajaxSubmit()
		{
			layer.msg('邮件发送中...');
			var returns=true;
			var url="${ctx}/forgets";
			var emails=$("#email").val();
			$.ajax({
				type:"POST",
				url:url,
				data: "email="+emails,
				cache: false,
				async : false,
				dataType: "json",
				   success: function (data ,textStatus, jqXHR)
					{
						if("true"==data.flag){
					   $("#successdiv").show();
						}else{
							 $("#errordiv").show();
							returns= false;
						}
					},
					error:function (XMLHttpRequest, textStatus, errorThrown) {
						 $("#errordiv").show();
						returns= false;
					}

			});
			return returns;
		}
	</script>
</head>
<body>

	<form id="example-advanced-form">
		<h3>填写账户名</h3>
		<fieldset>
			<legend>帐号信息</legend>
			<label class="control-label" for="userName-2">填写您注册账号：*</label> <input
				id="userName" name="userName" type="text" style="width: 300px;"
				class="form-control required">
		</fieldset>
		<h3>填写邮箱信息</h3>
		<fieldset>
			<legend>邮箱地址</legend>
			<label class="control-label">填写您注册账号的邮箱地址：*</label> <input
				name="email" id="email" type="text" style="width: 300px;"
				class="required email form-control" />
		</fieldset>
		<h3>信息确认并验证</h3>
		<fieldset>
			<legend>信息提示</legend>
			您填写的用户名为：<label id="ckname"></label> <br>
			您填写的邮箱为:<label id="ckemail"></label><br>
			请确认后，点击"下一步"通过邮箱获取重置密码地址。
			<div id="checkdiv">
				<div class="left_con">
					<img alt="失败" src="${ctxStatic}/custom/images/msg_warn.png"
						class="ico_suc">
				</div>
				<div class="right_con">
					<p class="p_con">
						<label>用户信息验证失败。 <br /> <a href="${ctx}/forget" style="color: red;">刷新重试</a></label>
					</p>
				</div>
			</div>
			

		</fieldset>
		    <h3>完成</h3>
		    <fieldset>
		        <legend>结果信息</legend>
		<div id="successdiv">
				<div class="left_con">
					<img alt="成功" src="${ctxStatic}/custom/images/msg_success.png"
						class="ico_suc">
				</div>
				<div class="right_con">
					<p class="p_con">
						<label class="control-label">请访问邮件中给出的网页链接地址， <br />
							根据页面提示完成密码重设。
						</label>
					</p>
				</div>
			</div>
			<div id="errordiv">
				<div class="left_con">
					<img alt="失败" src="${ctxStatic}/custom/images/msg_warn.png"
						class="ico_suc">
				</div>
				<div class="right_con">
					<p class="p_con">
						<label>邮件发送失败。 <br /> <a href="#" onclick="reajaxSubmit();" style="color: red;">重新发送</a></label>
					</p>
				</div>
			</div>
		    </fieldset>
	</form>
	<script>
var form = $("#example-advanced-form").show();
 
form.steps({
    headerTag: "h3",
    bodyTag: "fieldset",
    transitionEffect: "slideLeft",
    onStepChanging: function (event, currentIndex, newIndex)
    {
        // Allways allow previous action even if the current form is not valid!
        if (currentIndex > newIndex)
        {
            return true;
        }
        // Forbid next action on "Warning" step if the user is to young
       
        // Needed in some cases if the user went back (clean up)
        if (currentIndex < newIndex)
        {
            // To remove error styles
            form.find(".body:eq(" + newIndex + ") label.error").remove();
            form.find(".body:eq(" + newIndex + ") .error").removeClass("error");
        }
        if(currentIndex==2)
        {
        	var nestflag=ajaxChck();
        	if(nestflag)
        	{
            ajaxSubmit();       		
        	}
        	return nestflag;
        }
        return form.valid();
    },
    onStepChanged: function (event, currentIndex, priorIndex)
    {
		$("#ckname").text($("#userName").val());
   		$("#ckemail").text($("#email").val()); 
    	
//     	 if(currentIndex==2)
//          {
//          	var nestflag=ajaxChck();
//          	return nestflag;
//          }
    },
    onFinishing: function (event, currentIndex)
    {
       
        return form.valid();
    },
    onFinished: function (event, currentIndex)
    {

    }
}).validate({
    errorPlacement: function errorPlacement(error, element) { element.before(error); },
    rules: {
        confirm: {
            equalTo: "#password-2"
        }
    }
});
</script>
</body>
</html>