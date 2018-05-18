<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<body>
		<c:choose>
			<c:when test="${!empty acqu}">
					<div style="border-right:#ffffff 1px solid;border-top:#ffffff 1px solid;background:#dcdcdc;width:600px;border-bottom:#cccccc 1px solid;height:14px;text-align:left">
					<div style="overflow:hidden;width:100%;position:absolute;height:12px">
						<img id="bar" src="${ctxStatic}/custom/images/vote_bar.gif"/>
					</div>
					<div id="percent" style="font-size:10px;width:600px;font-weight:blod;font-family:arial;position:absolute;height:14px;text-align:center"></div>
					</div>
					<p></p>
					<div id="messageBox" style="font-size:11px;width:600px;color:#999999;font-family:arial;position:relative;height:14px;text-align:center"></div>
					<p></p>
					<c:choose>
						<c:when test="${list!= null && fn:length(list) > 0}">
							${acqu.acqName}共有${acqu.totalNum}个地址 正在分析第${acqu.currNum}个地址<p/>
							第${acqu.currNum}个地址共有${acqu.totalItem}个内容<p/>
						</c:when>
						<c:otherwise>
							<div>正在分析${acqu.acqName}...</div>
						</c:otherwise>
					</c:choose>
			</c:when>
			<c:otherwise>
					<c:choose>
						<c:when test="${list!= null && fn:length(list) > 0}">
								<div style="border-right:#ffffff 1px solid;border-top:#ffffff 1px solid;background:#dcdcdc;width:600px;border-bottom:#cccccc 1px solid;height:14px;text-align:left">
								<div style="overflow:hidden;width:100%;position:absolute;height:12px">
									<img id="bar" src="${ctxStatic}/custom/images/vote_bar.gif"/>
								</div>
								<div id="percent" style="font-size:10px;width:600px;color:white;font-family:arial;position:absolute;height:14px;text-align:center"></div>
								</div>
								<p></p>
								<div id="messageBox" style="font-size:11px;width:600px;color:#999999;font-family:arial;position:relative;height:14px;text-align:center"></div>
								<p></p>
						</c:when>
						<c:otherwise>
							<div>没有采集任务正在执行</div>
						</c:otherwise>
					</c:choose>
			</c:otherwise>
		</c:choose>
		<c:if test="${list!= null && fn:length(list) > 0}">
			<c:forEach var="temp" items="${list}">
				<p>第${temp.seq}条
				${temp.contentUrl}
				${temp.title}
				 <c:choose>
				 	<c:when test="${temp.description eq 'SUCCESS'}">
				 		采集成功！
				 	</c:when>
				 	<c:when test="${temp.description eq 'TITLESTARTNOTFOUND'}">
				 		采集失败!原因: 标题起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'TITLEENDNOTFOUND'}">
				 		采集失败!原因: 标题结束点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'CONTENTSTARTNOTFOUND'}">
				 		采集失败!原因: 正文起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'CONTENTENDNOTFOUND'}">
				 		采集失败!原因: 正文结束点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'AUTHORSTARTNOTFOUND'}">
				 		采集失败!原因: 作者起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'AUTHORENDNOTFOUND'}">
				 		采集失败!原因: 作者结束点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'VIEWSTARTNOTFOUND'}">
				 		采集失败!原因: 发布时间起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'VIEWENDNOTFOUND'}">
				 		采集失败!原因: 发布时间结束点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'ORIGINSTARTNOTFOUND'}">
			 			采集失败!原因: 来源起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'ORIGINENDNOTFOUND'}">
				 		采集失败!原因: 来源结束点不匹配
				 	</c:when>
				 	
				 	<c:when test="${temp.description eq 'DESCRISTARTNOTFOUND'}">
				 		采集失败!原因: 摘要起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'DESCRIENDNOTFOUND'}">
				 		采集失败!原因: 摘要结束点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'RELEASESTARTNOTFOUND'}">
				 		采集失败!原因: 发布时间起始点不匹配
				 	</c:when>
				 	<c:when test="${temp.description eq 'RELEASEENDNOTFOUND'}">
				 		采集失败!原因: 发布时间结束点不匹配
				 	</c:when>
			 		<c:when test="${acquisitionHistory.description eq 'RELEASEDATEUNKNOW'}">
				 		采集失败!原因: 发布时间格式不正确
				 	</c:when>
				 	<c:when test="${temp.description eq 'TITLEEXIST'}">
				 		采集失败!原因: 标题已存在
				 	</c:when>
			 		<c:when test="${acquisitionHistory.description eq 'FILESTARTNOTFOUND'}">
				 		采集失败!原因: 附件起始点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'FILEENDNOTFOUND'}">
				 		采集失败!原因: 附件结束点不匹配
				 	</c:when>
				 	<c:when test="${acquisitionHistory.description eq 'TABLEUNKNOW'}">
				 		采集失败!原因: 表格格式不匹配
				 	</c:when>
				 	<c:otherwise>
				 		采集失败!原因: 采集地址解析失败
				 	</c:otherwise>
				 </c:choose></p>
			</c:forEach>
		</c:if>
</body>
</html>
<script>
	var  percent=${percent};
</script>