<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
function typeSelect(){
	var t=$('input:radio[name=type]:checked').val();
	if(t=="single"){
		$("#single").show();	
		$("#list").hide();
		$("#ids").hide();
	}else if(t=="ids"){
		$("#ids").show();
		$("#single").hide();	
		$("#list").hide();
	}else{
		$("#single").hide();	
		$("#list").show();
		$("#ids").hide();
	}
}
function singleTypeSelect(){
	var s=$('input:radio[name=singleType]:checked').val();
	if(s=="a_"){
		$("#id").show();
	}else{
		$("#id").hide();
	}
}
function sysSelect(){
	var sys=$('input:radio[name=sys]:checked').val();
	if(sys=="true"){
		$("#tpl").show();
		$("#tpl1").show();
		$("#tpl-params").show();
		$("#newDiv").hide();
		tpl1Select();
		$("#showDesc").hide();
		$("#descLen").hide();
	}else{
		$("#tpl").hide();
		$("#tpl1").hide();
		$("#tpl2").hide();
		$("#tpl3").hide();
		$("#tpl-params").hide();
		$("#tpl1-params").hide();
		$("#tpl2-params").hide();
		$("#showDesc").show();
		$("#newDiv").show();
		disableDesc();
	}
}
//系统模板选择
function tplSelect(){
	var tpl=$('input:radio[name=tpl]:checked').val();
	$("#tpl1").hide();
	$("#tpl2").hide();
	$("#tpl3").hide();
	$("#tpl"+tpl).show();
	$("#tpl1-params").hide();
	$("#tpl2-params").hide();
	$("#tpl3-params").hide();
	$("#tpl"+tpl+"-params").show();
	if(tpl==2){
		tpl2Select();
	}
	if(tpl==1){
		tpl1Select();
	}
}
function disableDesc(){
	var desc=$('input:radio[name=showDesc]:checked').val();
	if(desc=="1"){
		$("#descLen").show();
	}else{
		$("#descLen").hide();
	}
}
//普通分类下三个分类
function tpl1Select(){
	var tp1=$('input:radio[name=tpl1]:checked').val();
	$("#tpl1-params").show();
	$("#tpl2-params").hide();
	$("#tpl3-params").hide();
	for(var a=1;a<=3;a++){
		$("#tpl1-"+a+"-params").hide();
	}
	$("#tpl1-"+tp1+"-params").show();
	if(tp1==3){
		$("#tpl1-1-params").show();
	}
}
//滚动列表下四分类
function tpl2Select(){
	var tp2=$('input:radio[name=tpl2]:checked').val();
	$("#tpl1-params").show();
	for(var a=1;a<=3;a++){
		$("#tpl1-"+a+"-params").hide();
	}
	if(tp2==1||tp2==3){
		//文字类
		$("#tpl1-1-params").show();
	}else{
		//图文类
		$("#tpl1-2-params").show();
	}
}
</script>
请选择分类(可不选)&nbsp;&nbsp;
列表<input  type="radio" name="type" onclick="typeSelect()" value="list" checked="checked"/>
分页<input  type="radio" name="type"  onclick="typeSelect()" value="page" />
单个<input type="radio" name="type"  onclick="typeSelect()" value="single" />
多个id<input  type="radio" name="type"  onclick="typeSelect()" value="ids" />
<br/>

<div id="single" style="display: none;">
请选择分类(可不选)&nbsp;&nbsp;
下一篇<input  type="radio" name="singleType" onclick="singleTypeSelect()" value="n_" checked="checked"/>
上一篇<input  type="radio" name="singleType" onclick="singleTypeSelect()" value="p_" />
某一篇<input type="radio" name="singleType" onclick="singleTypeSelect()" value="a_" />

<div id="id" style="display: none;">
某一篇
<input name="id" id="contentId"  required="true" class="required digits" maxlength="10"/><br/>
</div>
</div>

<div id="ids" style="display: none;">
指定ID(,分隔)
<input name="ids" id="ids"  required="true" class="required" maxlength="100"/><br/>
标题长度
<input name="idsTitLen"  required="true" class="required digits" maxlength="10"/><br/>
日期格式<input name="idsDateFormat"  value="yyyy-MM-dd"/><br/>
</div>


<!-- <div id="list">
调用系统模板&nbsp;&nbsp;
是<input  type="radio" onclick="sysSelect()" name="sys" value="true" />
否<input type="radio" onclick="sysSelect()" name="sys" value="false" checked="checked"/>
<br/>
<div id="tpl" style="display: none;">
系统模板选择&nbsp;&nbsp;
普通列表<input  type="radio" onclick="tplSelect()" name="tpl" value="1" checked="checked"//>
滚动列表<input type="radio" onclick="tplSelect()" name="tpl" value="2" >
焦点图<input type="radio" onclick="tplSelect()" name="tpl" value="3" >
滚动列表、焦点图分页无效
</div> -->
<input type="hidden" name="sys" value="false"/>

<div id="tpl1" style="display: none;">
普通列表&nbsp;&nbsp;
文字列表<input  type="radio" name="tpl1" onclick="tpl1Select()" value="1" checked="checked" />
图文列表<input type="radio" name="tpl1" onclick="tpl1Select()" value="2" >
文字带点击量列表<input type="radio" name="tpl1" onclick="tpl1Select()" value="3" >
</div>
<div id="tpl2" style="display: none;">
滚动列表&nbsp;&nbsp;
文字向上滚动列表<input  type="radio" name="tpl2" onclick="tpl2Select()" value="1" checked="checked"//>
图文向上滚动列表<input type="radio" name="tpl2"  onclick="tpl2Select()" value="2" >
文字向左滚动列表<input type="radio" name="tpl2"  onclick="tpl2Select()" value="3" >
图文向左滚动列表<input type="radio" name="tpl2"  onclick="tpl2Select()" value="4" >
</div>
<div id="tpl3" style="display: none;">
焦点图&nbsp;&nbsp;
焦点图1<input  type="radio" name="tpl3" value="1" checked="checked"//>
焦点图2<input type="radio" name="tpl3" value="2" >
焦点图3<input type="radio" name="tpl3" value="3" >
</div>
<div id="tpl1-params" style="display: none;">
	<div id="tpl1-1-params">
		行高<input name="lineHeight" maxlength="3"/><br/>
		列表头图片<input name="headMarkImg"  /><br/>
		列表头编号
		无列表头编号<input type="radio" name="headMark" value="1" >
		小黑点<input type="radio" name="headMark" value="2" >
		小红点<input type="radio" name="headMark" value="3" >
		单箭头<input type="radio" name="headMark" value="4" >
		双箭头<input type="radio" name="headMark" value="all" checked="checked" ><br/>
		是否有下划线
		是<input type="radio" name="bottomLine" value="1" />
		否<input type="radio" name="bottomLine" value="0" checked="checked"/><br/>
		日期位置
		后面左边<input type="radio" name="datePosition" value="1" />
		后面右边<input type="radio" name="datePosition" value="2" checked="checked" />
		前面<input type="radio" name="datePosition" value="3" /><br/>
		类别
		无<input type="radio" name="ctgForm" value="0"  checked="checked" />
		栏目<input type="radio" name="ctgForm" value="1"/>
		站点<input type="radio" name="ctgForm" value="2" />
	</div>
	<div id="tpl1-2-params" style="display: none;">
		图片宽度<input name="picWidth"  /><br/>
		每行图片显示高度<input name="picHeight"  /><br/>
		图片右边距<input name="rightPadding"  /><br/>
		图片是否左浮动
		是<input type="radio" name="picFloat" value="1" />
		否<input type="radio" name="picFloat" value="0"  checked="checked"/>
	</div>
	<div id="tpl1-3-params" style="display: none;">
		访问量
		总访问量 <input type="radio" name="view" value="1"  checked="checked" />
		月访问量<input type="radio" name="view" value="2"/>
		周访问量<input type="radio" name="view" value="3" />
		日访问量<input type="radio" name="view" value="4" /><br/>
		访问量数字之前的描述的词汇<input name="viewTitle"  />
	</div>
</div>
<div id="tpl2-params" style="display: none;">
		显示区域高度
		<input name="rollDisplayHeight"  />【按像素px计算】<br/>
		滚动区行高
		<input name="rollLineHeight"  />【按像素px计算】<br/>
		<@s.m "directive.content.tpl.params.rollCols"/>
		<input name="rollCols"  />滚动列数<br/>
		滚动速度
		<input name="rollSpeed"  />【滚动速度，值越小越快，最小为1】<br/>
		滚动停顿时间
		<input name="rollSleepTime"  />【值越大停顿越久】<br/>
		滚动行数
		<input name="rollRows"  />【一个滚动周期滚动的行数】<br/>
		滚动跨度
		<input name="rollSpan"  />【一次滚动的像素，跨度越大，滚动就越快，但越不流畅】<br/>
		是否停顿
		是<input type="radio" name="isSleep" value="1" />
		否<input type="radio" name="isSleep" value="0" checked="checked"/>
</div>
<div id="tpl3-params" style="display: none;">
		flash宽度
		<input name="flashWidth"  />【按像素px计算】<br/>
		flash高度
		<input name="flashHeight"  />【按像素px计算】<br/>
		文本高度
		<input name="textHeight"  />【按像素px计算】<br/>
</div>

<div id="tpl-params" style="display: none;">
		是否显示标题样式
		是<input type="radio" name="showTitleStyle" value="1" />
		否<input type="radio" name="showTitleStyle" value="0" checked="checked"/><br/>
		是否使用简短标题
		是<input type="radio" name="useShortTitle" value="1" checked="checked"/>
		否<input type="radio" name="useShortTitle" value="0" /><br/>
</div>
内容来源&nbsp;&nbsp;<!--优先级从高到低（例设置了tag 忽略tag下其他参数）--><br/>
<!-- TagID或Tag名称<input type="text" name="tag" >
专题ID<input type="text" name="topic" /><br/> -->
栏目ID<input type="text" name="channelId" style="width:120px;"/>
栏目路径<input type="text" name="channelPath"  style="width:120px;"/>
<br/>
栏目选项&nbsp;&nbsp;
多个栏目<input  type="radio" name="channelOption" value="0" />
子栏目<input type="radio" name="channelOption" value="1" checked="checked"/>
副栏目<input type="radio" name="channelOption" value="2" />
<br/>
<!-- 内容类型&nbsp;&nbsp;
普通 <input name="typeId" value="0" type="checkbox">
图文 <input name="typeId" value="1" type="checkbox">
焦点 <input name="typeId" value="2" type="checkbox">
头条 <input name="typeId" value="3" type="checkbox">
<br/>

推荐&nbsp;&nbsp;
所有<input  type="radio" name="recommend" value="all" checked="checked"/>
是<input  type="radio" name="recommend" value="1" />
否<input type="radio" name="recommend" value="0"/>
<br/>
是否有标题图&nbsp;&nbsp;
所有<input  type="radio" name="image" value="all" checked="checked"/>
是<input  type="radio" name="image" value="1" />
否<input type="radio" name="image" value="0" />
<br/> -->
<div id="newDiv">
是否带new标记&nbsp;&nbsp;
是<input  type="radio" name="new" value="1" />
否<input type="radio" name="new" value="0" checked="checked"//>
<br/>
</div>
日期格式<input name="dateFormat"  value="yyyy-MM-dd"/><br/>

是否新窗口打开
是<input type="radio" name="target" value="1"  checked="checked"/>
否<input type="radio" name="target" value="0" /><br/>
标题&nbsp;&nbsp;
<input  type="text" name="title"/>
<br/>
排序&nbsp;&nbsp;
<select name="orderBy">
	<option value="0">ID降序</option>
	<option value="1">ID升序</option>
	<option value="2" selected>发布时间降序</option>
	<option value="3">发布时间升序</option>
</select>
<br/>
标题长度
<input name="titLen"  required="true" class="required digits" maxlength="10"/><br/>

<div id="showDesc">
是否显示描述&nbsp;&nbsp;
是<input  type="radio" name="showDesc" onclick="disableDesc()" value="1" />
否<input type="radio" name="showDesc" onclick="disableDesc()" value="0" checked="checked"/>
</div>
<div id="descLen" style="display: none;">
简介长度
<input name="descLen"  required="true" class="required digits" maxlength="10"/><br/>
</div>
条数
<input name="count"  required="true" class="required digits" maxlength="10"/><br/>
</div>