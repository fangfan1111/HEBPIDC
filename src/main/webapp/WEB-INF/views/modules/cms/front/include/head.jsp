<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10" />
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
<c:if test="${site.theme eq 'basic'}">
	<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/bootstrap.min.css">
	<script src="${ctxStatic}/bootstrap3.3.6/bootstrap/js/bootstrap.min.js"></script>
	<link href="${ctxStatic}/common/base.min.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStaticTheme}/style.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStaticTheme}/script.js" type="text/javascript"></script>
	<link href="${ctxStatic}/custom/css/style_0519.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/custom/css/sjpt0624_style.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/custom/JavaScript/jquery-hd.js" type="text/javascript"></script>
	<script src="${ctxStatic}/custom/JavaScript/base_gd.js" type="text/javascript"></script>
	<script src="${ctxStatic}/custom/JavaScript/slider.js" type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/custom/JavaScript/frontindex.js" type="text/javascript"></script>
	<link href="${ctxStatic}/xcConfirm/css/xcConfirm.css" rel="stylesheet" />
	<script src="${ctxStatic}/xcConfirm/js/xcConfirm.js" type="text/javascript"></script>
</c:if>
<!-- 引入layer插件 -->
<script src="${ctxStatic}/layer-v3.0.1/layer/layer.js"></script>
<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}',contextPath = '${pageContext.request.contextPath}',ctxa='${pageContext.request.contextPath}${fns:getAdminPath()}';</script>