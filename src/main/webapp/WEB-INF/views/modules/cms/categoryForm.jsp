<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>栏目管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
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
			gettplChannel();
		});
		function gettplChannel(){
			var module = $("#module").val();
			if("e4e7d7723abe4e24a6364ee07b7d87f4"==module){//单页显示内容
				$("#contentshow").show();
			}else{
				$("#contentshow").hide();
			}
			var options = {
		        url: '${ctx}/cms/category/tplChannelAjax?module='+module,
		        type: 'post',
		        dataType: 'json',
		        success:  function (data) {
					$("#tplChannel option[value!='']").remove(); 
					  $.each(data,function(n,value) {
						  $("#tplChannel").append("<option value='"+value+"'>"+value+"</option>");
					  });
					
		        }
		    };
	    	$.ajax(options);
		}
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/category/">栏目列表</a></li>
		<li class="active"><a href="${ctx}/cms/category/form?id=${category.id}&parent.id=${category.parent.id}">栏目<shiro:hasPermission name="cms:category:edit">${not empty category.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/></div>
	<div class="box-body">
	<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属机构:</label>
			<div class="col-sm-10 controls">
                <sys:treeselect id="office" name="office.id" value="${category.office.id}" labelName="office.name" labelValue="${category.office.name}"
					title="机构" url="/sys/office/treeData" cssClass="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">上级栏目:</label>
			<div class="col-sm-10 controls">
                <sys:treeselect id="category" name="parent.id" value="${category.parent.id}" labelName="parent.name" labelValue="${category.parent.name}"
					title="栏目" url="/cms/category/treeData" extId="${category.id}" cssClass="form-control input-sm required"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目名称:</label>
			<div class="col-sm-10 controls">
				<form:input path="name" htmlEscape="false" maxlength="50"  class="form-control input-sm required"/>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>访问路径:</label>
			<div class="col-sm-10 controls">
				<form:input path="path" htmlEscape="false" maxlength="50"  class="form-control input-sm required"/>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label"><font color="red">*</font>栏目模型:</label>
			<div class="col-sm-10 controls">
				<form:select path="module" cssClass="required" cssStyle="width:260px;" onchange="gettplChannel()">
					<form:option value="">--请选择--</form:option>
					<form:options items="${cmsModelList}" itemLabel="modelName" itemValue="id" htmlEscape="false"/>
				</form:select>
				
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目模板:</label>
			<div class="col-sm-10 controls">
				
				<form:select path="tplChannel" cssStyle="width:260px;">
					<form:option value="">--默认--</form:option>
					<c:forEach items="${channelTplList}" var="item">
					 	<form:option value="${item }">${item }</form:option>
					</c:forEach>
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">栏目静态化:</label>
			<div class="col-sm-10 controls">
				<form:checkbox path="staticChannel" value="1"/> &nbsp;&nbsp;&nbsp;每页记录数:<form:input path="pageSize" htmlEscape="false" maxlength="10" cssStyle="width:20px;" class="required digits"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">内容静态化:</label>
			<div class="col-sm-10 controls">
				<form:checkbox path="staticContent" value="1"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">缩略图:</label>
			<div class="col-sm-10 controls">
				<form:hidden path="image" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:myuploadlocal input="image" type="thumb" uploadPath="/cms/category" isSaveLocal="false" uploadMaxSize="10" uploadMimeTypes="jpg,jpeg,png,gif" multiSelection="false" saveRealName="false"/>
<%-- 				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/category"/> --%>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">外部链接:</label>
			<div class="col-sm-10 controls">
				<form:input path="href" htmlEscape="false" class="form-control input-sm" maxlength="200"/>
				<span class="help-inline">栏目超链接地址，优先级“高”</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">目标:</label>
			<div class="col-sm-10 controls">
				<form:input path="target" htmlEscape="false" class="form-control input-sm" maxlength="200"/>
				<span class="help-inline">栏目超链接打开的目标窗口，新窗口打开，请填写：“_blank”</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">描述:</label>
			<div class="col-sm-10 controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">关键字:</label>
			<div class="col-sm-10 controls">
				<form:input path="keywords" htmlEscape="false" class="form-control input-sm" maxlength="200"/>
				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">排序:</label>
			<div class="col-sm-10 controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="form-control input-sm required digits"/>
				<span class="help-inline">栏目的排列次序</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">在导航中显示:</label>
			<div class="col-sm-10 controls">
				<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在导航中显示该栏目</span>
			</div>
		</div>
		<!-- <div class="form-group">
			<label class="control-label">在分类页中显示列表:</label>
			<div class="controls">
				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在分类页中显示该栏目的文章列表</span>
			</div>
		</div> -->
		<div class="form-group">
			<label class="col-sm-2 control-label">是否允许评论:</label>
			<div class="col-sm-10 controls">
				<form:radiobuttons path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否需要审核:</label>
			<div class="col-sm-10 controls">
				<form:radiobuttons path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group" style="display:none;" id="contentshow">
			<label class="col-sm-2 control-label">内容:</label>
			<div class="col-sm-10 controls">
				<form:textarea id="content" htmlEscape="true" path="content" rows="4" maxlength="200" class="form-control"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:category:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>&nbsp;
		</div>
	</form:form>
	</div>
</body>
</html>