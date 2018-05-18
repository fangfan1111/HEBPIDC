<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>文章管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
			$("#title").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
                    if ($("#categoryId").val()==""){
                        $("#categoryName").focus();
                        top.$.jBox.tip('请选择归属栏目','warning');
                    }else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
                        top.$.jBox.tip('请填写正文','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
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
		function clesubmit(flag){
			$("#delFlag").val(flag);
			$('#inputForm').submit();
		}
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/article/?category.id=${article.category.id}">文章列表</a></li>
		<li class="active"><a href="<c:url value='${fns:getAdminPath()}/cms/article/form?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">文章<shiro:hasPermission name="cms:article:edit">${not empty article.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:article:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/></div>
	<div class="box-body">
	<form:form id="inputForm" modelAttribute="article" action="${ctx}/cms/article/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="delFlag"/>
		<sys:message content="${message}"/>
		<div class="form-group">
			<label class="col-sm-2 control-label">归属栏目:</label>
			<div class="col-sm-10 controls">
                <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="form-control input-sm required"/>&nbsp;
<!--                 <span> -->
<!--                     <input id="url" type="checkbox"  onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label> -->
<!--                 </span> -->
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">标题:</label>
			<div class="col-sm-10 controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="form-control input-sm measure-input required"/>
<!-- 				&nbsp;<label>颜色:</label> -->
<%-- 				<form:select path="color" class="input-mini"> --%>
<%-- 					<form:option value="" label="默认"/> --%>
<%-- 					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" /> --%>
<%-- 				</form:select> --%>
			</div>
		</div>
		
		<div class="form-group">
			<label class="col-sm-2 control-label">颜色:</label>
			<div class="col-sm-10 controls">
<form:select path="color" class="input-mini">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">指定模板:</label>
			<div class="col-sm-10 controls">
				
				<form:select path="tplContent" cssStyle="width:260px;">
					<form:option value="">--默认--</form:option>
					<c:forEach items="${tplList}" var="item">
					 	<form:option value="${item }">${item }</form:option>
					</c:forEach>
				</form:select>
			</div>
		</div>
			<div class="form-group">
			<label class="col-sm-2 control-label">外部链接:</label>
			<div class="col-sm-10">
				<input id="url" type="checkbox"  onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()">
			</div>
		</div>
        <div id="linkBody" class="form-group" style="display:none">
            <label class="col-sm-2 control-label">外部链接:</label>
            <div class="col-sm-10 controls">
                <form:input path="link" htmlEscape="false" maxlength="200" class="form-control input-sm input-xlarge"/>
                <span class="help-inline">绝对或相对地址。</span>
            </div>
        </div>
		<div class="form-group">
			<label class="col-sm-2 control-label">关键字:</label>
			<div class="col-sm-10 controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
				<span class="help-inline">多个关键字，用空格分隔。</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">权重:</label>
			<div class="col-sm-10 controls">
				<form:input path="weight" htmlEscape="false" maxlength="200" class="input-mini required digits"/>&nbsp;
				<span>
					<input id="weightTop" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><label for="weightTop">置顶</label>
				</span>
				&nbsp;过期时间：
				<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				<span class="help-inline">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</span>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">来源:</label>
			<div class="col-sm-10 controls">
				<form:input path="articleData.copyfrom" htmlEscape="false" maxlength="200" class="form-control input-sm"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">摘要:</label>
			<div class="col-sm-10 controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="form-control"/>
			</div>
		</div>
<!-- 		<div class="form-group"> -->
<!-- 			<label class="col-sm-2 control-label">图片:</label> -->
<!-- 			<div class="col-sm-10 controls"> -->
<%--                 <input type="hidden" id="image" name="image" value="${article.imageSrc}" /> --%>
<%-- 				<sys:myuploadlocal input="image" type="images" uploadPath="/cms" isSaveLocal="false" uploadMaxSize="10" uploadMimeTypes="jpg,jpeg,png,gif"  multiSelection="true"  saveRealName="false"/> --%>
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="form-group">
			<label class="col-sm-2 control-label">附件:</label>
			<div class="col-sm-10 controls">
                <input type="hidden" id="files" name="files" value="${article.files}" />
				<sys:myuploadlocal input="files" type="files" uploadPath="/cms" isSaveLocal="false" uploadMaxSize="0" uploadMimeTypes="doc,docx,txt,avi,zip,rar,pdf,xls,xlsx" multiSelection="true"  saveRealName="false" />
<%-- 				<sys:ckfinder input="files" type="files" uploadPath="/cms/article" selectMultiple="true"/> --%>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">正文:</label>
			<div class="col-sm-10 controls">
				<form:textarea id="content" htmlEscape="true" path="articleData.content" rows="4" maxlength="200" class="form-control"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">相关文章:</label>
			<div class="col-sm-10 controls">
				<form:hidden id="articleDataRelation" path="articleData.relation" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<ol id="articleSelectList"></ol>
				<a id="relationButton" href="javascript:" class="btn">添加相关</a>
				<script type="text/javascript">
					var articleSelect = [];
					function articleSelectAddOrDel(id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<articleSelect.length; i++){
							if (articleSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						if(isExtents){
							articleSelect.splice(index,1);
						}else{
							articleSelect.push([id,title]);
						}
						articleSelectRefresh();
					}
					function articleSelectRefresh(){
						$("#articleDataRelation").val("");
						$("#articleSelectList").children().remove();
						for (var i=0; i<articleSelect.length; i++){
							$("#articleSelectList").append("<li>"+articleSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"articleSelectAddOrDel('"+articleSelect[i][0]+"','"+articleSelect[i][1]+"');\">×</a></li>");
							$("#articleDataRelation").val($("#articleDataRelation").val()+articleSelect[i][0]+",");
						}
					}
					$.getJSON("${ctx}/cms/article/findByIds",{ids:$("#articleDataRelation").val()},function(data){
						for (var i=0; i<data.length; i++){
							articleSelect.push([data[i][1],data[i][2]]);
						}
						articleSelectRefresh();
					});
					$("#relationButton").click(function(){
						var heef='${ctx}/cms/article/selectList?pageSize=8';
						window.top.layer.open({
							  type: 2,
							  maxmin: true,
							  title: '添加相关',
							  shadeClose: true,
							  shade: 0.8,
							  area: ['80%', '60%'],
							  content: heef //iframe的url
							}); 
					});
				</script>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">是否允许评论:</label>
			<div class="col-sm-10 controls">
				<form:radiobuttons path="articleData.allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">推荐位:</label>
			<div class="col-sm-10 controls">
				<form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">发布时间:</label>
			<div class="col-sm-10 controls">
				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<!--<shiro:hasPermission name="cms:article:audit">
			<div class="form-group">
				<label class="control-label">发布状态:</label>
				<div class="controls">
					<form:radiobuttons path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</shiro:hasPermission>-->
		
		<c:if test="${not empty article.id}">
			<div class="form-group">
				<label class="col-sm-2 control-label">查看评论:</label>
				<div class="col-sm-10 controls">
					<input id="btnComment" class="btn" type="button" value="查看评论" onclick="viewComment('${ctx}/cms/comment/?module=article&contentId=${article.id}&status=0')"/>
					<script type="text/javascript">
						function viewComment(href){
							window.top.layer.open({
								  type: 2,
								  maxmin: true,
								  title: '查看评论',
								  shadeClose: true,
								  shade: 0.8,
								  area: ['80%', '60%'],
								  content: href //iframe的url
								}); 
// 							$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-180,{
// 								buttons:{"关闭":true},
// 								loaded:function(h){
// 									$(".jbox-content", top.document).css("overflow-y","hidden");
// 									$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
// 									$("body", h.find("iframe").contents()).css("margin","10px");
// 								}
// 							});
							return false;
						}
					</script>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="cms:article:edit">
				<c:if test="${article.delFlag ne '2'}">
						<c:choose>
							<c:when test="${article.delFlag eq '4'}">
								<input id="btnSubmit0" onclick="clesubmit('2')" class="btn btn-primary" type="button" value="提交"/>&nbsp;
							</c:when>
							<c:otherwise>
								<input id="btnSubmit0" onclick="clesubmit('3')" class="btn btn-primary" type="button" value="暂存"/>&nbsp;
								<input id="btnSubmit2" onclick="clesubmit('2')" class="btn btn-primary" type="button" value="提交"/>&nbsp;
							</c:otherwise>
						</c:choose>
   				</c:if>
   				<shiro:hasPermission name="cms:article:audit">
   					<c:choose>
							<c:when test="${article.delFlag ne '1' && article.delFlag eq '2'}">
								<input id="btnSubmit1" onclick="clesubmit('6')" class="btn btn-primary" type="button" value="签发"/>&nbsp;
   								<input id="btnSubmit1" onclick="clesubmit('4')" class="btn btn-primary" type="button" value="返工"/>&nbsp;
   								<input id="btnSubmit1" onclick="clesubmit('5')" class="btn btn-primary" type="button" value="否定"/>&nbsp;
							</c:when>
							<c:otherwise>
								<input id="btnSubmit0" onclick="clesubmit('0')" class="btn btn-primary" type="button" value="发布"/>&nbsp;
							</c:otherwise>
					</c:choose>
				</shiro:hasPermission>
			</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			
		</div>
	</form:form>
	</div>
</body>
</html>