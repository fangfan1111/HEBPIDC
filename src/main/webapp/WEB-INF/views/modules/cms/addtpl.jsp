<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模板管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
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
			//	div += "<option value =\"comment\">评论</option>";
			//	div += "<option value =\"topic\">专题</option>";
			//	div += "<option value =\"vote\">投票</option>";
			//	div += "<option value =\"guestbook\">留言</option>";
			//	div += "<option value =\"advertise\">广告</option>";
			//	div += "<option value =\"link\">友情链接</option>";
			//	div += "<option value =\"tag\">Tag</option>";
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
		<li><a href="${ctx}/cms/template/list?root=${root}">模板列表</a></li>
		<shiro:hasPermission name="cms:template:edit"><li  class="active"><a href="${ctx}/cms/template/add?root=${root}">创建模板</a></li></shiro:hasPermission>
	</ul><br/></div>
	<form id="inputForm" action="${ctx}/cms/template/save" method="post" class="form-horizontal">
		<input type="hidden" name="root" value="${root}"/>
		<div class="control-group">
			<label class="control-label">文件名:</label>
			<div class="controls">
				<input name="filename" type="text" class="required"/> .html
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" id="tempImport" >引入标签</a>
			</div>
		</div>
		<div class="control-group">
            <textarea name="source" id="source" style="width:98%;height:280px" class="required"></textarea>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:template:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>