<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>首页</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<script src="${ctxStatic}/custom/JavaScript/dzan.js" type="text/javascript"></script>
	<script>
		$(function(){
			<c:if test="${not empty message}">
				loginIn();
			</c:if>
		})
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
	</script>
</head>
<body>
   <div class="jdc_main">
    	<div class="jumbotron flexslider" id="demo01">
  			<ul class="slides">
  				<c:forEach items="${fnc:getArticleList(site.id, 'a85a903c44724dc08a35d7c08d0b412d', 10, '')}" var="article">
			             <li class="slide_li">
		                	
			                	<a target="_blank" href="${article.url}" style="color:#FFF">
			                		<c:choose>
				            			<c:when test="${not empty article.image}">
				            				<img src="${article.image}" />
				            			</c:when>
			            				<c:otherwise>
			            					<h1>
			            					${article.title}
			            					</h1>
											<p>${fns:replaceHtml(article.articleData.content)}</p>
			            				</c:otherwise>   
			            			</c:choose>
			                	</a>
		                </li>
				</c:forEach>
            </ul>
		</div>
		<div class="jdc_mn1">
        	<div class="jdc_mn11"><span>软件介绍</span></div>
            <ul>
            	<c:forEach items="${fnc:getArticleList(site.id, 10, 6, '')}" var="article">
					<li><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,35)}</a></li>
				</c:forEach>
            </ul>
            <p><a href="${ctx}/list-10${urlSuffix}">更多...</a></p>
        </div>
         <div class="jdc_mn1" style="margin-left:15px;">
        	<div class="jdc_mn11"><span>质量检验</span></div>
            <ul>
            	<c:forEach items="${fnc:getArticleList(site.id, 6, 6, '')}" var="article">
					<li><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,35)}</a></li>
				</c:forEach>
            </ul>
            <p><a href="${ctx}/list-6${urlSuffix}">更多...</a></p>
        </div>
        <div class="jdc_mn1" style="margin-left:15px;">
        	<div class="jdc_mn11"><span>法律法规</span></div>
            <ul>
            	<c:forEach items="${fnc:getArticleList(site.id,'8c6633b99fda4179add125dc9b7b184d', 6, '')}" var="article">
					<li><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,35)}</a></li>
				</c:forEach>
            </ul>
            <p><a href="${ctx}/list-8c6633b99fda4179add125dc9b7b184d${urlSuffix}">更多...</a></p>
        </div>
      </div>
</body>
</html>