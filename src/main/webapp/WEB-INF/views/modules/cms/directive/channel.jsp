<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
function listSelect(){
	var list=getListValue();
	var channel=getChannelValue();
	if(list=="true"){
		$("#channelList").show();	
		$("#channelSingle").hide();
		$("#hasContent").show();
		if(channel=="true"){
			$("#channeltree").hide();	
		}else{
			$("input[name='listType'][value='childs']").prop("checked","checked");
			$("#channelList").hide();	
			$("#channeltree").show();	
		}
	}else{
		$("#channelList").hide();	
		$("#channelSingle").show();
		$("#hasContent").hide();
		if(channel=="true"){
			$("#channeltree").hide();	
		}else{
			$("input[name='singleType'][value='channel']").prop("checked","checked");
			$("#channelSingle").hide();	
			$("#channeltree").show();	
		}
	}
}

function getListValue(){
	return $('input:radio[name=list]:checked').val();
}
function getChannelValue(){
	return $('input:radio[name=channel]:checked').val();
}
</script>
是否列表&nbsp;&nbsp;
列表<input onclick="listSelect(this.value)" type="radio" name="list" value="true" checked="checked"/>
单个<input onclick="listSelect(this.value)" type="radio" name="list" value="false"/>
<br/>
栏目模板&nbsp;&nbsp;
是<input type="radio" name="channel" value="true"  checked="checked"  onclick="listSelect(this.value)"/>
否<input type="radio" name="channel" value="false" onclick="listSelect(this.value)"/>
<br/>
<div id="hasContent">
包含内容的栏目&nbsp;&nbsp;
是<input type="radio" name="hasContent" value="true" />
所有<input type="radio" name="hasContent" value="false" checked="checked"/>
</div>
<div id="channelList" >
	列表分类
	子栏目<input  type="radio" name="listType" value="childs" checked="checked"/>
	一级栏目<input  type="radio" name="listType" value="top"/>
	兄弟栏目<input  type="radio" name="listType" value="brothers"/>
	<br/>
</div>
<div id="channelSingle" style="display: none;">
	所要栏目 
		当前栏目信息<input type="radio" name="singleType" value="channel" checked="checked"/>
	顶层栏目<input type="radio" name="singleType" value="top"/>
	父栏目<input type="radio" name="singleType" value="parent"/>
	栏目导航<input type="radio" name="singleType" value="navigation"/>
	<br/>
</div>
<div id="channeltree" style="display: none;">
<sys:treeselect id="channelId" name="channelId" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" notAllowSelectRoot="false" cssClass="input-small"/>
</div>
