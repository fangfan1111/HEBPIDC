<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
是否分页&nbsp;&nbsp;
是<input  type="radio" name="page" value="true" />
否<input type="radio" name="page" value="false" checked="checked"/>
<br/>
推荐&nbsp;&nbsp;
所有<input  type="radio" name="recommend" value="all" checked="checked"/>
是<input  type="radio" name="recommend" value="true" />
否<input type="radio" name="recommend" value="false" />
<br/>
审核&nbsp;&nbsp;
所有<input  type="radio" name="checked" value="all" />
是<input  type="radio" name="checked" value="true" checked="checked"/>
否<input type="radio" name="checked" value="false" />
<br/>
标题长度
<input name="titleLen"  required="true" class="required digits" maxlength="10"/><br/>
内容长度
<input name="contentLen"  required="true" class="required digits" maxlength="10"/><br/>

条数
<input name="count"  required="true" class="required digits" maxlength="10"/><br/>

<select id="ctgId" name="ctgId">
<option value="0">请选择类型(可不选)</option>
<c:if test="${(ctgList)!= null && fn:length(ctgList) > 0}">
	<c:forEach items="${ctgList}" var="c">
		<option value="${c.value}">${c.label}</option>
	</c:forEach>
</c:if>
</select>