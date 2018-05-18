<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	<link href="${ctxStatic}/bootstrap/2.3.1/css_flat/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
		body {
		    font-size: 12px;
		    color: #000;
		    font-family: "微软雅黑";
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#comment").hide();
			if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
				$("#comment").show();
				page(1);
			}
		});
		function page(n,s){
			$.get("${ctx}/comment",{theme: '${site.theme}', 'category.id': '${category.id}',
				contentId: '${article.id}', title: '${article.title}', pageNo: n, pageSize: s, date: new Date().getTime()
			},function(data){
				$("#comment").html(data);
				comment(0);
			});
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
            <div class="nr_zw">
            	<h3>${article.title}</h3>
                <span class="nr_tb">文章内容</span>
                <div class="clear"></div>
                <p><c:if test="${not empty article.description}">摘要：${article.description}</c:if></p>
                <p>${article.articleData.content}</p>
                <c:if test="${not empty article.files}">
                	<p>
	                	<input type="hidden" id="files" name="files" value="${article.files}" />
						<sys:ckfinder readonly="true" input="files" type="files" uploadPath="/cms/article" selectMultiple="true"/>
                	</p>
                </c:if>
                <div class="nr_xie">
                	<span>发布者：${article.user.name}</span><span>点击数：<em>${article.hits}</em></span><span>发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </span><span>更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </div>
                 <div class="row">
					<div id="comment" class=" span10">
						正在加载评论...
					</div>
			     </div>
                <span class="nr_tb2">相关文章</span>
                <div class="clear"></div>
                <ul class="nr_ul">
                    <c:forEach items="${relationList}" var="relation">
						<li><a href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a></li>
					</c:forEach>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>