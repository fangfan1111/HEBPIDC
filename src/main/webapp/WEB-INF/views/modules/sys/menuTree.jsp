<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="menuList" value="${fns:getMenuList()}"/>
<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
	<c:if test="${menu.parent.id eq (not empty param.parentId ? param.parentId:1)&&menu.isShow eq '1'}">
	<c:choose>
	<c:when test="${fns:hasMenuChild(menu.id)}">
	<li class="treeview">
	<a href="javascript:;" class="dropdown-toggle">
	<i class="fa ${not empty menu.icon ? menu.icon : 'circle-arrow-right'}"></i>
	<span class="menu-text">${menu.name}</span>
	<span class="pull-right-container">
    <i class="fa fa-angle-left pull-right"></i>
    </span>
     </a>
	<ul class="treeview-menu">
	<c:forEach items="${menuList}" var="menu2">
	<c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
	<c:choose>
	<c:when test="${fns:hasMenuChild(menu2.id)}">
	<li>
	<a href="javascript:;" class="dropdown-toggle">
	<i class="fa ${not empty menu2.icon ? menu2.icon : 'double-angle-right'}"></i>
	<span class="menu-text">${menu2.name}</span>
	<span class="pull-right-container">
    <i class="fa fa-angle-left pull-right"></i>
    </span>
	</a>
	<!-- 菜单支持到4级，想要支持更多级，修改下面的最后一级即可 -->
    <ul class="treeview-menu">
    <c:forEach items="${menuList}" var="menu3">
	<c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}">
	<c:choose>
	<c:when test="${fns:hasMenuChild(menu3.id)}">
	<li>
	<a href="javascript:;" class="dropdown-toggle">
	<i class="fa ${not empty menu3.icon ? menu3.icon : 'double-angle-right'}"></i>
	<span class="menu-text">${menu3.name}</span>
	<span class="pull-right-container">
    <i class="fa fa-angle-left pull-right"></i>
    </span>
	</a>
	<ul class="treeview-menu">
	<c:forEach items="${menuList}" var="menu4">
	<c:if test="${menu4.parent.id eq menu3.id&&menu4.isShow eq '1'}">
	<li>
	<a href="${fn:indexOf(menu4.href, '://') eq -1 ? ctx : ''}${not empty menu4.href ? menu4.href : '/404'}" onclick="goIframes('${fn:indexOf(menu4.href, '://') eq -1 ? ctx : ''}${not empty menu4.href ? menu4.href : '/404'}','${menu4.target}')" target="${not empty menu4.target ? menu4.target : 'mainFrame'}" >
	<i class="fa ${not empty menu4.icon ? menu4.icon : 'double-angle-right'}"></i>
	<span class="menu-text">${menu4.name}</span>
	</a>
	</li>
	</c:if>
	</c:forEach>
	</ul>
	</li>
	</c:when>
	<c:otherwise>
	<li>
	<a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}" onclick="goIframes('${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}','${menu3.target}')"   target="${not empty menu3.target ? menu3.target : 'mainFrame'}" >
	<i class="fa ${not empty menu3.icon ? menu3.icon : 'double-angle-right'}"></i>
	<span class="menu-text">${menu3.name}</span>
	</a>
	</li>
	</c:otherwise>
	</c:choose>
	</c:if>
	</c:forEach>
	</ul>
<!-- 															<ul class="treeview-menu"> -->
<%-- 																<c:forEach items="${menuList}" var="menu3"> --%>
<%-- 																	<c:if test="${menu3.parent.id eq menu2.id&&menu3.isShow eq '1'}"> --%>
<!-- 																			<li> -->
<%-- 																				<a href="${fn:indexOf(menu3.href, '://') eq -1 ? ctx : ''}${not empty menu3.href ? menu3.href : '/404'}"  target="${not empty menu3.target ? menu3.target : 'mainFrame'}" > --%>
<%-- 																				<i class="fa ${not empty menu3.icon ? menu3.icon : 'double-angle-right'}"></i> --%>
<%-- 																				<span class="menu-text">${menu3.name}</span> --%>
<!-- 																				</a> -->
<!-- 																			</li> -->
<%-- 																	</c:if> --%>
<%-- 																</c:forEach> --%>
<!-- 															</ul> -->
	</li>
	</c:when>
	<c:otherwise>
	<li>
	<a href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}" onclick="goIframes('${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}','${menu2.target}')"  target="${not empty menu2.target ? menu2.target : 'mainFrame'}" >
	<i class="fa ${not empty menu2.icon ? menu2.icon : 'double-angle-right'}"></i>
	<span class="menu-text">${menu2.name}</span>
	</a>
	</li>
	</c:otherwise>
	</c:choose>
	</c:if>
	</c:forEach>
	</ul>
	</li>
	</c:when>
	<c:otherwise>
	<li>
	<a  href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${not empty menu.href ? menu.href : '/404'}" onclick="goIframes('${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${not empty menu.href ? menu.href : '/404'}','${menu.target}')"  target="${not empty menu.target ? menu.target : 'mainFrame'}" >
	<i class="fa ${not empty menu.icon ? menu.icon : 'circle-arrow-right'}"></i>
	<span class="menu-text">${menu.name}</span>
	</a>
	</li>
	</c:otherwise>
	</c:choose>
	</c:if>
</c:forEach>
