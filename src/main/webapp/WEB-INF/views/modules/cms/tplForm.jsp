<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模板管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#value").focus();
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
			$("#tempImport").click(function() {
				var div = "<div id=\"tempDialog\" >";
					div += "<div style=\"color: red;\">&nbsp;&nbsp;请先定位插入标签位置(未定位插入到模板开始位置)</div>";
					div += "<form id=\"tempForm\" class=\"form-horizontal\">";
					div += "<table class=\"table-form\">";
					div += "<tr>";
					div += "<td class=\"tit\">模块</td>";
					div += "<td><select id=\"module\" name=\"module\"  onchange=\"selectModule()\" class=\"required input-xlarge\">";
					div += "<option value =\"channel\">栏目</option>";
					div += "<option value =\"content\">内容</option>";
			//		div += "<option value =\"comment\">评论</option>";
			//		div += "<option value =\"topic\">专题</option>";
			//		div += "<option value =\"vote\">投票</option>";
			//		div += "<option value =\"guestbook\">留言</option>";
			//		div += "<option value =\"advertise\">广告</option>";
			//		div += "<option value =\"link\">友情链接</option>";
			//		div += "<option value =\"tag\">Tag</option>";
					div += "</select></td>";
					div += "</tr>";
					div += "<tr>";
					div += "<td class=\"tit\">参数</td>";
					div += "<td><div id=\"operator\"></div></td>";
					div += "</tr>";
					div += "</table>";
					div += "<div class=\"form-actions\" >";
					div += "<input id=\"btnSubmit\" class=\"btn btn-primary\" type=\"submit\" value=\"插入标签\" />";
					div += "</div>";
					div += "</form>";
					div += "</div>";
				$.jBox(div, {  
				    title: "引入页签",  
				    width: 500,  
				    height: 350,  
				    buttons: { '关闭': true }  
				});
				$("#operator").load("${ctx}/cms/template/directive/module?module=channel");
				$("#tempForm").validate({
				    submitHandler: function(form) {
					var options = {
					        url: '${ctx}/cms/template/directive/getcode',
					        type: 'post',
					        dataType: 'json',
					        data: $("#tempForm").serialize(),
					        success:  function (data) {
								insert(data);
								window.jBox.close();
					        }
					    };
				    $.ajax(options);
				    return false;
				    }
				});
			});
			
		});
		function selectModule(){
			var module=$("#module").val();
			$("#operator").load("${ctx}/cms/template/directive/module?module="+module);
		}
		//未定位鼠标则插入开始位置
		function insert(str){
		    var source = document.getElementById("source");
		    var sourcelen = source.value.length;
		    source.focus();
		    if(typeof document.selection != "undefined")
		    {
		        document.selection.createRange().text = str;  
		    }
		    else
		    {
		    	source.value = source.value.substr(0,source.selectionStart)+str+source.value.substring(source.selectionStart,sourcelen);
		    }
		}
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li class="active"><a>模板管理</a></li>
	</ul><br/></div>
	<form:form id="inputForm" modelAttribute="template" action="${ctx}/cms/template/o_save" method="post" class="form-horizontal">
        <form:hidden path="name" />
		<div class="form-group">
			<label class="control-label col-sm-1">文件名:</label>
			<div class="controls col-sm-10">
				<form:input path="filename" htmlEscape="false" readonly="true" maxlength="50" class="required"/>
				<input name="root" type="hidden" value="${root}">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" id="tempImport" >引入标签</a>
			</div>
		</div>
		<div class="control-group">
            <form:textarea id="source" path="source" htmlEscape="true" cssStyle="width:98%;height:280px"/>
            <%--<sys:ckeditor replace="source" uploadPath="/cms/template" />--%>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>