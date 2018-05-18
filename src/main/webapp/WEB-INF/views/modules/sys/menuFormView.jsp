<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>菜单管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>

</head>
<body>
	<form:form id="inputForm" modelAttribute="menu" class="form-horizontal">

		<div class="box-body">
		 
		    <div class="form-group">
		   
		    <label> 上级菜单:</label>
		    <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name" labelValue="${menu.parent.name}"
					title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="form-control required"/>
		    </div>
		     <div class="form-group">
		     <label> <font color="red">*</font> 名称:</label>
		   <form:input path="name" htmlEscape="false" maxlength="50" class="required form-control "/>
		    </div>
		    
		     <div class="form-group">
		     <label> <font color="red">*</font> 链接:</label>
		   <form:input path="href" htmlEscape="false" maxlength="2000" class="form-control "/> 
 					<span class="help-inline">点击菜单跳转的页面</span>
		    </div>
		    
		     <div class="form-group">
		     <label> 目标:</label>
		 <form:input path="target" htmlEscape="false" maxlength="10" class="form-control "/> 
					<span class="help-inline">链接打开的目标窗口，默认：mainFrame</span>
		    </div>
		    
		       <div class="form-group">
		     <label> 图标:</label>
		 <sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
		    </div>
		    
		    <div class="form-group">
		     <label> 排序:</label>
		<form:input path="sort" htmlEscape="false" maxlength="50" class="required digits form-control "/> 
 					<span class="help-inline">排列顺序，升序。</span>
		    </div>
		    
		     <div class="form-group">
		     <label>可见:</label>
		<form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required i-checks "/> 
					<span class="help-inline">该菜单或操作是否显示到系统菜单中</span>
		    </div>
		    
		    <div class="form-group">
		     <label>权限标识:</label>
		<form:input path="permission" htmlEscape="false" maxlength="100" class="form-control "/> 
 					<span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
		    </div>
		    
		     <div class="form-group">
		     <label>备注:</label>
		<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="form-control "/>
		    </div>
		</div>
		</form:form>
<%-- 		<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal"> --%>
	
<!-- 		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer"> -->
<!-- 		   <tbody> -->
<!-- 		      <tr> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">上级菜单:</label></td> -->
<%-- 		         <td class="width-35" >${menu.parent.id}</td> --%>
<!-- 		         <td  class="width-15 active"><label class="pull-right"><font color="red">*</font> 名称:</label></td> -->
<%-- 		         <td  class="width-35" >${menu.name}</td> --%>
<!-- 		      </tr> -->
<!-- 		      <tr> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">链接:</label></td> -->
<%-- 		         <td class="width-35" >${menu.href} --%>
<!-- 					</td> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">目标:</label></td> -->
<%-- 		         <td  class="width-35" >${menu.target} --%>
<!-- 					</td> -->
<!-- 		      </tr> -->
<!-- 		      <tr> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">图标:</label></td> -->
<%-- 		         <td class="width-35" >${menu.icon}</td> --%>
<!-- 		         <td  class="width-15 active"><label class="pull-right">排序:</label></td> -->
<%-- 		         <td  class="width-35" >${menu.sort} --%>
<!-- 					</td> -->
<!-- 		      </tr> -->
<!-- 		      <tr> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">可见:</label></td> -->
<%-- 		         <td class="width-35" >${menu.isShow}  --%>
<!-- 					</td> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">权限标识:</label></td> -->
<%-- 		         <td  class="width-35" >${menu.permission} --%>
<!-- 					</td> -->
<!-- 		      </tr> -->
<!-- 		      <tr> -->
<!-- 		         <td  class="width-15 active"><label class="pull-right">备注:</label></td> -->
<%-- 		         <td class="width-35" >${menu.remarks}</td> --%>
<!-- 		         <td  class="width-15 active"><label class="pull-right"></label></td> -->
<!-- 		         <td  class="width-35" ></td> -->
<!-- 		      </tr> -->
<!-- 		    </tbody> -->
<!-- 		  </table> -->
<%-- 	</form:form> --%>
</body>
</html>