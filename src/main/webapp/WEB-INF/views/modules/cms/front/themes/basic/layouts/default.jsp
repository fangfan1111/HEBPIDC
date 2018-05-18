<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
	<title><sitemesh:title default="欢迎光临"/> - ${site.title}</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<sitemesh:head/>
	<script type="text/javascript">
	$(function(){
		  var urlstr = window.location.href;
		  var urlstatus = false;
		  $("#menu li a").each(function () {
			 var href = $(this).attr('href');
			 var index = $("#menu li a").index(this);
	    	if (urlstr.indexOf(href) > -1&&href!=''&&index!=0) {
		      $(this).parent("li").addClass('kjy_a');urlstatus = true;
		    } else {
		      $(this).parent("li").removeClass('kjy_a');
		    }
		  });
		  if (!urlstatus) {$("#menu li ").eq(0).addClass('kjy_a'); }
	})
</script>
</head>
<body>
	<div class="jdc_header">
    	<div class="jdc_hd_01">
        	<div class="sjfw_hd02">${site.title}</div>
            <div class="sj_admin">
            <c:set value="${fns:getUser()}" var="user"/>
            <c:choose>
            	<c:when test="${not empty user.id}">
            		<span class="out"><a href="${pageContext.request.contextPath}${fns:getAdminPath()}/logout">退出</a></span>
		            <span class="admin">
		            	当前用户：<a href="#" class="hh_hover">${user.loginName}</a>
		            	<div class="admin_gnlb">
		                	<ul>
		                        <li><a href="${pageContext.request.contextPath}${fns:getAdminPath()}">个人信息</a></li>
		                	</ul>
                    		<div class="bj_bottom"></div>
                		</div>
		            </span>
            	</c:when>
            	<c:otherwise>
            		  <a href="${pageContext.request.contextPath}${fns:getAdminPath()}" class="sj_denglv one">登录</a> | 
			          <a href="${ctx}/register">注册</a> 
	    		</c:otherwise>   
            </c:choose>
            </div>
        </div>
    </div>
    <div class="jdc_daoh nav" style="width:100%;height:35px;background:#808080;">
    	<div class="jdc_dh01">
        	<ul id="menu">
        		<li><a href="${ctx}">首页</a></li>
                <c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
	                    <c:if test="${status.index lt 5}">
		                    <c:set var="menuCategoryId" value=",${category.id},"/>
				    		<li><a href="${category.url}" target="${category.target}">${category.name}</a></li>
			    	   </c:if>
	    	   </c:forEach>
            </ul>
        </div>
    </div>
	 <sitemesh:body/>
    <div class="jdc_footer">
    	<div class="jdc_ft01">
    		 ${site.copyright}
    	</div>
    </div>
</body>
</html>