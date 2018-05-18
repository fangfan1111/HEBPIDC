<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>模板列表</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 0;}<%--
		.ztree li span.button.level0, .ztree li a.level0 {display:none;height:0;}
		.ztree li ul.level0 {padding:0;background:none;}--%>
		.accordion-inner{padding:2px;}
	</style>
	<script type="text/javascript">
		var setting = {view:{selectedMulti:false},data:{simpleData:{enable:true}},callback: {onClick: treeOnClick}};
		$(document).ready(function(){
			var zNodes=[
		            <c:forEach items="${templateList}" var="tpl">{id:"${tpl.name}", pId:"${not empty tpl.parent?tpl.parent:0}", name:"${tpl.filename}", fullName:"${tpl.name}", isDirectory: ${tpl.directory}},
		            </c:forEach>];
			zNodes.push({id:zNodes[0].pId, pId:"0", name:"模板根目录", fullName:"模板根目录", isDirectory: true});
			// 初始化树结构
			var tree = $.fn.zTree.init($("#tree"), setting, zNodes);
			// 展开第一级节点
			var nodes = tree.getNodesByParam("level", 0);
			for(var i=0; i<nodes.length; i++) {
				tree.expandNode(nodes[i], true, true, false);
			}
			wSize();
		});
		$(window).resize(function(){
			wSize();
		});
		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
            //noinspection JSUnresolvedVariable
            if(!treeNode.isDirectory){
                window.open("${ctx}/cms/template/form?name="+treeNode.fullName,"cmsMainFrame");
            }else{
            	window.open("${ctx}/cms/template/list?root="+treeNode.id,"cmsMainFrame");
            }
		}
		function wSize(){
			$(".ztree").width($(window).width()-16).height($(window).height()-62);
			$(".ztree").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
			$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
		}
		function refreshTree(){
			$.getJSON("${ctx}/cms/template/treeData",function(data){
				data.push({id:data[0].pId, pId:"0", name:"模板根目录", fullName:"模板根目录", isDirectory: true});
				var tree = $.fn.zTree.init($("#tree"), setting, data);
				// 展开第一级节点
				var nodes = tree.getNodesByParam("level", 0);
				for(var i=0; i<nodes.length; i++) {
					tree.expandNode(nodes[i], true, true, false);
				}
				wSize();
			});
		}
		function setTlp(){
			window.open("${ctx}/cms/template/set","cmsMainFrame");
		}
	</script>
</head>
<body>
	<div class="accordion-group">
	    <div class="accordion-heading">
	    	<a class="accordion-toggle">模板列表<i class="icon-refresh pull-left" onclick="refreshTree();"></i>
	    	<i class=" icon-cog pull-right" onclick="setTlp();"></i></a>
	    </div>
	    <div class="accordion-body">
			<div class="accordion-inner">
				<div id="tree" class="ztree"></div>
			</div>
	    </div>
	</div>
</body>
</html>