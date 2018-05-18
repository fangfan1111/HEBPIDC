<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
function typeSelect(){
	var type=$("input:radio[name='page']:checked").val();
	if(type=="true"){
		$("#aid").hide();	
		$("#sid").show();
	}else{
		$("#aid").show();	
		$("#sid").hide();
	}
}
</script>
广告<input  type="radio" name="page" value="false" onclick="typeSelect()"/>
广告版位<input type="radio" name="page" value="true" checked="checked" onclick="typeSelect()"/>
<br/>
<div id="aid"  style="display: none;">
广告  &nbsp;&nbsp;
<select name="aid">
<!-- <#if adList?size gt 0>
<#list adList as c>
	<option value="${c.id}">${c.name}</option>
</#list>
</#if> -->
</select>
</div>
<div id="sid" >
广告版位&nbsp;&nbsp;
<select name="sid">
<!-- <#if spList?size gt 0>
<#list spList as c>
	<option value="${c.id}">${c.name}</option>
</#list>
</#if> -->
</select>
</div>