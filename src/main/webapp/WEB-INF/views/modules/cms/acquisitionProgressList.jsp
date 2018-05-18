<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>采集进度</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cmsAcquisitionTemp" action="${ctx}/cms/cmsAcquisition/v_progress" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<c:choose>
				<c:when test="${!empty list}">
					<li><label>采集源：</label>
						<form:select path="acquisitionId" class="input-medium">
							<c:forEach items="${list}" var="cmsAcquisition">
								<form:option value="${cmsAcquisition.id}">${cmsAcquisition.acqName}</form:option>
							</c:forEach>
						</form:select>
					</li>
					<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查看"/></li>
				</c:when>
				<c:otherwise>
					没有采集任务正在执行
				</c:otherwise>
			</c:choose>
			<li class="clearfix"></li>
		</ul>
	</form:form>
</body>
</html>