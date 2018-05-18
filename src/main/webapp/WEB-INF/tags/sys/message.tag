<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="content" type="java.lang.String" required="true" description="消息内容"%>
<%@ attribute name="type" type="java.lang.String" description="消息类型：info、success、warning、error、loading"%>
<script type="text/javascript">$.jBox.closeTip();</script>
<c:if test="${not empty content}">
	<script type="text/javascript">$.jBox.tip("${content}","${ctype}",{persistent:true,opacity:0});$("#messageBox").show();</script>
</c:if>