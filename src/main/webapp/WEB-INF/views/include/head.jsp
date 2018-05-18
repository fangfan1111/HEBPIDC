<%@ page trimDirectiveWhitespaces="true" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Expires" content="0"><meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store">
<!-- jQuery 2.2.3 -->
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/font-awesome.css">
<!-- Ionicons -->
<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/bootstrap/css/ionicons.css">
<!-- Theme style -->
<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/dist/css/skins/_all-skins.min.css">
<!--[if lt IE 9]>
<script src="${ctxStatic}/bootstrap3.3.6/dist/html5shiv.min.js"></script>
<script src="${ctxStatic}/bootstrap3.3.6/dist/respond.min.js"></script>
  <![endif]-->
<!-- Bootstrap 3.3.6 -->
<script src="${ctxStatic}/bootstrap3.3.6/bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${ctxStatic}/bootstrap3.3.6/plugins/fastclick/fastclick.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="${ctxStatic}/bootstrap3.3.6/plugins/slimScroll/jquery.slimscroll.min.js"></script>
<link href="${ctxStatic}/jquery-select2/3.4/select2.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-select2/3.4/pinyin.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/common/base.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/common/base.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/common/select.js"></script>
<!-- 引入layer插件 -->
<script src="${ctxStatic}/layer-v3.0.1/layer/layer.js"></script>
<script type="text/javascript">var ctx = '${ctx}', ctxStatic='${ctxStatic}';</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/plupload/plupload.full.min.js"></script>
<script type="text/javascript">document.ondragstart = function(event) {return false;}</script>
<script type="text/javascript">function goHistory(){window.location.href="<%= request.getHeader("Referer")%>";}</script>
<!-- 引入省市区三级联动 -->
<script src="${ctxStatic}/cityselect/CiSelect.js"></script>