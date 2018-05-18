<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script type="text/javascript">
function listSelect(){
	var list=$('input:radio[name=list]:checked').val();
	if(list=="true"){
		$("#voteId").hide();
		$("#count").show();
	}else{
		$("#voteId").show();
		$("#count").hide();
	}
}

</script>
是否列表&nbsp;&nbsp;
列表<input onclick="listSelect(this.value)" type="radio" name="list" value="true" checked="checked"/>
单个<input onclick="listSelect(this.value)" type="radio" name="list" value="false"/>
<br/>
<div id="count" >
条数
<input name="count"  required="true" class="required digits" maxlength="10"/><br/>
</div>

<select id="voteId" name="voteId" style="display: none;">
<!-- <#if voteList?size gt 0>
<#list voteList as c>
	<option value="${c.id}">${c.title}</option>
</#list>
</#if> -->
</select>