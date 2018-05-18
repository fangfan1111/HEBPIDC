<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>分配角色</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
	
		var officeTree;
		var selectedTree;//zTree已选择对象
		
		// 初始化
		$(document).ready(function(){
			officeTree = $.fn.zTree.init($("#officeTree"), setting, officeNodes);
			selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
		});

		var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:false},
				data: {simpleData: {enable: true}},
				callback: {onClick: treeOnClick}};
		
		var officeNodes=[
	            <c:forEach items="${officeList}" var="office">
	            {id:"${office.id}",
	             pId:"${not empty office.parent?office.parent.id:0}", 
	             name:"${office.name}"},
	            </c:forEach>];
	
		var pre_selectedNodes =[
   		        <c:forEach items="${userList}" var="user">
   		        {id:"${user.id}",
   		         pId:"0",
   		         name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
   		        </c:forEach>];
		
		var selectedNodes =[
		        <c:forEach items="${userList}" var="user">
		        {id:"${user.id}",
		         pId:"0",
		         name:"<font color='red' style='font-weight:bold;'>${user.name}</font>"},
		        </c:forEach>];
		
		var pre_ids = "${selectIds}".split(",");
		var ids = "${selectIds}".split(",");
		//点击选择项回调
		function treeOnClick(event, treeId, treeNode, clickFlag){
			$.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
			if("officeTree"==treeId){
				$.get("${ctx}/sys/role/users?officeId=" + treeNode.id, function(userNodes){
					$.fn.zTree.init($("#userTree"), setting, userNodes);
				});
			}
			if("userTree"==treeId){
				//alert(treeNode.id + " | " + ids);
				//alert(typeof ids[0] + " | " +  typeof treeNode.id);
				if($.inArray(String(treeNode.id), ids)<0){
					selectedTree.addNodes(null, treeNode);
					ids.push(String(treeNode.id));
				}
			};
			if("selectedTree"==treeId){
// 				alert(treeId);
// 				alert(String(treeNode.id)+"---"+treeNode.name);
				var rname=treeNode.name.replace(/<.*?>/ig,"");
// 				alert(treeNode.name.indexOf(pre_ids)+"===="+rname);
// 				if($.inArray(String(treeNode.id), pre_ids)<0){
		         if(pre_ids != rname){
		        	selectedTree.removeNode(treeNode);
					ids.splice($.inArray(String(treeNode.id), ids), 1);
				}else{
					if(treeNode.name.indexOf('red')<0){
						selectedTree.removeNode(treeNode);
						ids.splice($.inArray(String(treeNode.id), ids), 1);
					}else{
					window.top.layer.alert('角色原有成员不能清除！', {
       				  	skin: 'layui-layer-lan' //样式类名
       				  	,closeBtn: 0
       					});
					}
					//window.top.$.jBox.tip("角色原有成员不能清除！", 'info');
				}
			}
		};
		function closes()
		{
			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
           layer.close(index);
		}
		function clearAssign(){
			
	    	window.top.layer.confirm('确定清除角色【${role.name}】下的已选人员？', {
				icon: 3,
				title:'系统提示',
				  btn: ['确定','取消'] //按钮
				}, function(index){
					var tips="";
							//配置一个透明的询问框
					if(pre_ids.sort().toString() == ids.sort().toString()){
						window.top.layer.alert('未给角色【${role.name}】分配新成员！', {
	       				  	skin: 'layui-layer-lan' //样式类名
	       				  	,closeBtn: 0
	       					});
					//	tips = "未给角色【${role.name}】分配新成员！";
					}else{
						window.top.layer.alert('已选人员清除成功！', {
	       				  	skin: 'layui-layer-lan' //样式类名
	       				  	,closeBtn: 0
	       					});
						//tips = "已选人员清除成功！";
					}
					ids=pre_ids.slice(0);
					selectedNodes=pre_selectedNodes;
					$.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
// 			    	top.$.jBox.tip(tips, 'info');
					window.top.layer.close(index);
					
				}, function(){
					//top.$.jBox.tip("取消清除操作！", 'info');
				});	
			
			
			
// 			var submit = function (v, h, f) {
// 			    if (v == 'ok'){
// 					var tips="";
// 					if(pre_ids.sort().toString() == ids.sort().toString()){
// 						tips = "未给角色【${role.name}】分配新成员！";
// 					}else{
// 						tips = "已选人员清除成功！";
// 					}
// 					ids=pre_ids.slice(0);
// 					selectedNodes=pre_selectedNodes;
// 					$.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
// 			    	top.$.jBox.tip(tips, 'info');
// 			    } else if (v == 'cancel'){
// 			    	// 取消
// 			    	top.$.jBox.tip("取消清除操作！", 'info');
// 			    }
// 			    return true;
// 			};
// 			tips="确定清除角色【${role.name}】下的已选人员？";
// 			top.$.jBox.confirm(tips, "清除确认", submit);
		};
	</script>
</head>
<body>
	<div id="assignRole" class="row-fluid span12">
		<div class="span4" style="border-right: 1px solid #A8A8A8;float:left;margin-left:25px;padding-right:20px;margin-top:20px;width:40%;">
			<p>所在部门：</p>
			<div id="officeTree" class="ztree"></div>
		</div>
		<div class="span3" style="float:left;margin-top:20px;margin-left:25px;width:20%;">
			<p>待选人员：</p>
			<div id="userTree" class="ztree"></div>
		</div>
		<div class="span3" style="padding-left:16px;border-left: 1px solid #A8A8A8;float:left;margin-top:20px;margin-left:25px;width:20%x;">
			<p>已选人员：</p>
			<div id="selectedTree" class="ztree"></div>
		</div>
	</div>

</body>
</html>
