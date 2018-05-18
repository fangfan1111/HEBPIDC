<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>${category.name}</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="description" content="${category.description}" />
	<meta name="keywords" content="${category.keywords}" />
	<link href="${ctxStatic}/bootstrap/2.3.1/css_flat/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
		body {
		    font-size: 12px;
		    color: #000;
		    font-family: "微软雅黑";
		}
	</style>
	<script type="text/javascript">
				function page(n,s){
					location="${ctx}/list-${category.id}${urlSuffix}?pageNo="+n+"&pageSize="+s;
				}
	</script>
</head>
<body>
  <div class="lb_main">
    	<div class="lb_m_left" id="left">
        	<div class="lb_m_l1">栏目列表</div>
            <ul class="lb_m_l2" style="margin:0 0 0 15px;">
            	<cms:frontCategoryList categoryList="${categoryList}"/>
            </ul>
            <div class="lb_m_l1">推荐阅读</div>
            <div class="lb_m_l02" style="height:200px;">
            		<cms:frontArticleHitsTop category="${category}"/>
            </div>
        </div>
        <div class="lb_m_right" id="right">
        	<div class="lb_m_r1"><cms:frontCurrentPosition category="${category}"/></div>
            <c:if test="${category.module eq 'article'}">
				<ul class="lb_m_r2">
					<c:forEach items="${page.list}" var="article">
						<li><span><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,96)}</a></li>
					</c:forEach>
				</ul>
				<div class="pagination">${page}</div>
	  		</c:if>
		    <c:if test="${category.module eq 'link'}">
			<ul class="lb_m_r2">
				<c:forEach items="${page.list}" var="link">
					<li><a href="${link.href}" target="_blank" style="color:${link.color}"><c:out value="${link.title}" /></a></li>
				</c:forEach>
			</ul>
		    </c:if>
            <div class="lb_page"></div>
        </div>
    </div>
</body>
</html>