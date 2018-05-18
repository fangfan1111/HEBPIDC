<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="utf-8" />
		<title>${fns:getConfig('productName')}</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <meta http-equiv="Expires" content="0">
        <meta http-equiv="Cache-Control" content="no-cache">
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
      <script src="${ctxStatic}/bootstrap3.3.6/dist/js/html5shiv.min.js"></script>
      <script src="${ctxStatic}/bootstrap3.3.6/dist/js/respond.min.js"></script>
      <![endif]-->
    <!-- Bootstrap 3.3.6 -->
    <script src="${ctxStatic}/bootstrap3.3.6/bootstrap/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${ctxStatic}/bootstrap3.3.6/plugins/fastclick/fastclick.js"></script>
     <link rel="stylesheet" href="${ctxStatic}/bootstrap3.3.6/dist/css/add-style.css">
    <script src="${ctxStatic}/bootstrap3.3.6/dist/js/menu_js.js"></script>
    <!-- 引入layer插件 -->
    <script src="${ctxStatic}/layer-v3.0.1/layer/layer.js"></script>
    <!-- SlimScroll 1.3.0 -->
    <script src="${ctxStatic}/bootstrap3.3.6/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <script src="${ctxStatic}/common/base.min.js" type="text/javascript"></script>

		<script type="text/javascript">
		function getNotifyNum(){
		    $.ajax({
		        type: "GET",
		        cache: false,
		        url: "${ctx}/oa/oaNotify/self/count?updateSession=0&t="+new Date().getTime(),
		        //data: "id=123",
		        dataType:"json",
		        async: true,
		        error: function(data, error) {
                },
		        success: function(data)
		        {
		         $("#labelwar").text(data);
		         $("#limessage").text('您有['+data+']条未读信息，点击查看全部。');
		         $("#labelwars").text(data);   
		         $("#limessages").text('您有['+data+']条未读信息，点击查看全部。');
		        }
		    });
		}
		    getNotifyNum();
			setInterval(getNotifyNum, 50000);
			
			$(document).ready(function() {
				$("#mainFrame").height($(document).height()-$("#navbar").height()-35);
				// 绑定菜单单击事件
				$("#menu a").click(function(){
				
					var firstmenuflag=$(this).attr("href");
					if(firstmenuflag != "javascript:")
					{
					//alert("一级菜单"+firstmenuflag+"---");
					$(".main-sidebar").css("display","none");
					$(".content-wrapper").css("margin-left","0");
					$("#menu li").removeClass("active");
					$(this).parent().addClass("active");
					//document.frames[0].location.href =firstmenuflag; 
					}else{
					// 一级菜单焦点
					$(".main-sidebar").css("display","block");					
					//手机界面有问题，暂时注释，但是切换到无左侧菜单是右侧显示有问题
					//$(".content-wrapper").css("margin-left","230px");
					var swidth=document.body.clientWidth;
					if(swidth>750){
						$(".content-wrapper").css("margin-left","230px");
					}else{
						$(".content-wrapper").css("margin-left","0px");
					}
					OpenFlag=0;
					$("#menu li").removeClass("active");
					$(this).parent().addClass("active");
					// 显示二级菜单
					var menuId = "#menu-" + $(this).attr("data-id");
					if ($(menuId).length > 0){
						$(menuId).show();
						// 默认选中第一个菜单
						$("#left li .treeview-menu a:first i").click();
						$("#left li .treeview-menu li:first li:first a:first i").click();
					}else{
						// 获取二级菜单数据
						$.get($(this).attr("data-href"), function(data){
							if (data.indexOf("id=\"loginForm\"") != -1){
								alert('未登录或登录超时。请重新登录，谢谢！');
								top.location = "${ctx}";
								return false;
							}
							$("#left").html("").append(data);
							//二级
							$("#left li a").click(function(){
								//alert(3);
								if($(this).attr('class')!='dropdown-toggle'){
									$("#left li").removeClass("active");
									$(this).parent().addClass("active");
								}
							}); 
							// 默认选中第一个菜单
                            var menu_href_a = $("#left li .treeview-menu a:first ").attr("href");
                            var menu_href_b = $("#left li .treeview-menu li:first li:first a:first ").attr("href");
                            var menu_href_c = $("#left li .treeview-menu li:first li:first li:first a:first ").attr("href");
                            $("#left li a:first i").click();
                            if(menu_href_a != 'javascript:;'&&menu_href_a != 'undefined'){
                                $("#left li .treeview-menu a:first i").click();
                            }
                            if(menu_href_b !=  'javascript:;'&&menu_href_b != 'undefined'){
                                $("#left li .treeview-menu li:first li:first a:first i").click();
                            }
                            if(menu_href_c !=  'javascript:;'&&menu_href_c != 'undefined'){
                                $("#left li .treeview-menu li:first li:first li:first a:first i").click();
                            }
						});
					}
					}
					return false;
				});
				$("#menu a:first span").click();
			});
	$(function(){
              timer=setInterval(function(){
           var scrollTop=document.compatMode=="CSS1Compat" ? document.documentElement.scrollTop||document.body.scrollTop : document.body.scrollTop;
           var ispeed=Math.floor(-scrollTop/6);
           if(scrollTop==0){
               clearInterval(timer);
           }
           document.documentElement.scrollTop=document.body.scrollTop=scrollTop+ispeed;
       },30);

		 var height = document.compatMode=="CSS1Compat" ? document.documentElement.clientHeight : document.body.clientHeight;
		$("#mainFrame").load(function () {
		    var mainheight = $(this).contents().find("body").height() + 100;
		    if(mainheight<500)
		    	{
		    	mainheight=500;
		    	}
		    mainheight=mainheight>height?mainheight:height;
		    $(this).height(mainheight);
		});
	});
		</script>
		<style>
			@media screen and (max-width: 750px) {
			.content-wrapper{margin-left:0;}
			}
		</style>
	</head>
	<body class="hold-transition skin-blue-light sidebar-mini">
<div class="wrapper">

  <header class="main-header">

    <!-- Logo -->
    <a href="${ctx}" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>菜单</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>${fns:getConfig('productName')}</b></span>
    </a>

    <nav class="navbar navbar-static-top" style="position: static;">
    <div style="position:relative;">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
            <i class="fa fa-bars"></i>
          </button>
	  <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse pull-left" id="navbar-collapse">
        	<div id="nav-menu" class="nav-menu">
          		<ul class="nav navbar-nav" id="menu">
    				<c:set var="firstMenu" value="true"/>
						<c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
							<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
								<li style="font-size:16px;" class="${not empty firstMenu && firstMenu ? ' active' : ''}">
									<c:if test="${empty menu.href}">
										<a  href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.name}</span></a>
									</c:if>
									<c:if test="${not empty menu.href}">
										<a href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}" data-id="${menu.id}" target="mainFrame" onclick="goIframes('${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}','${menu.target}')"><span>${menu.name}</span></a>
									</c:if>
								</li>
								<c:if test="${firstMenu}">
									<c:set var="firstMenuId" value="${menu.id}"/>
								</c:if>
								<c:set var="firstMenu" value="false"/>
							</c:if>
						</c:forEach>
          		</ul>
        	</div>
        	<div class="fa fa-caret-left leftbutton"><a href="javascript:;"></a></div>
          <div class="fa fa-caret-right rightbutton"><a href="javascript:;"></a></div>
        </div>
        <!-- /.navbar-collapse -->
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <li class="dropdown messages-menu md-hidden">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">您有4条消息</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        AdminLTE Design Team
                        <small><i class="fa fa-clock-o"></i> 2 hours</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Developers
                        <small><i class="fa fa-clock-o"></i> Today</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Sales Department
                        <small><i class="fa fa-clock-o"></i> Yesterday</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Reviewers
                        <small><i class="fa fa-clock-o"></i> 2 days</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">查看全部消息</a></li>
            </ul>
          </li>
          <li class="dropdown notifications-menu md-hidden">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span id="labelwar" class="label label-warning">0</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header" >消息提醒</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <a href="${ctx}/oa/oaNotify/self" target="mainFrame" style="color:#333;">
                      <i class="fa fa-users text-aqua"></i> 
                     <label id="limessage"></label> 
                    </a>
                
              </li>
              <li class="footer"><a href="${ctx}/oa/oaNotify/self" target="mainFrame">查看全部</a></li>
            </ul>
          </li>

          <li class="dropdown tasks-menu md-hidden">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">您有9条代办消息</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Create a nice theme
                        <small class="pull-right">40%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">40% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Some task I need to do
                        <small class="pull-right">60%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">60% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Make beautiful transitions
                        <small class="pull-right">80%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">80% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">查看全部代办任务</a>
              </li>
            </ul>
          </li>
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <c:choose>
		    <c:when test="${not empty fns:getUser().photo}">
			<img class="user-image" alt="User Image" src="${fns:getUser().photo}"/>
		    </c:when>
			<c:otherwise>
			 <img class="user-image" alt="User Image" src="${ctxStatic}/images/userinfo.jpg" />
			  </c:otherwise>   
			    </c:choose>
              <span class="hidden-xs" style="padding-left:3px;">${fns:getUser().name}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
              <c:choose>
		    <c:when test="${not empty fns:getUser().photo}">
			<img class="img-circle" alt="User Image" src="${fns:getUser().photo}"/>
		    </c:when>
			<c:otherwise>
			 <img class="img-circle" alt="User Image" src="${ctxStatic}/images/userinfo.jpg" />
			  </c:otherwise>   
			    </c:choose>
                <p>
                   ${fns:getUser().name}--${fns:getUser().company.name}
                  <small>${fns:getUser().email}</small>
                </p>
              </li>
              <span class="nav navbar-nav nav-more">
              	<li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:#333;">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">您有4条消息</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        AdminLTE Design Team
                        <small><i class="fa fa-clock-o"></i> 2 hours</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Developers
                        <small><i class="fa fa-clock-o"></i> Today</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Sales Department
                        <small><i class="fa fa-clock-o"></i> Yesterday</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="${ctxStatic}/bootstrap3.3.6/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Reviewers
                        <small><i class="fa fa-clock-o"></i> 2 days</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">查看全部消息</a></li>
            </ul>
          </li>
          <li class="dropdown notifications-menu">
            <a href="${ctx}/oa/oaNotify/self" target="mainFrame" class="dropdown-toggle" style="color:#333;">
              <i class="fa fa-bell-o"></i>
              <span id="labelwars" class="label label-warning">0</span>
            </a>
          </li>
          
          <li class="dropdown tasks-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color:#333;">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">您有9条代办消息</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Create a nice theme
                        <small class="pull-right">40%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">40% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Some task I need to do
                        <small class="pull-right">60%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">60% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Make beautiful transitions
                        <small class="pull-right">80%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">80% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">查看全部代办任务</a>
              </li>
            </ul>
          </li>
              </span>
              
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="${ctx}/sys/user/modifyPwd" target="mainFrame" class="btn btn-default btn-flat">修改密码</a>
                </div>
                <div class="pull-right">
                  <a href="${ctx}/logout" class="btn btn-default btn-flat">退出</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
	</div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <section class="sidebar">
      <ul class="sidebar-menu" id="left">
      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
<!--     <section class="content-header"> -->
<!--       <h1> -->
<!--         Dashboard -->
<!--         <small>Version 2.0</small> -->
<!--       </h1> -->
<!--       <ol class="breadcrumb"> -->
<!--         <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li> -->
<!--         <li class="active">Dashboard</li> -->
<!--       </ol> -->
<!--     </section> -->

    <!-- Main content -->
    <section class="content" id="div1">
    
      <!-- Info boxes -->
<!--       <div class="row"> -->

<iframe id="mainFrame" name="mainFrame"  style="Z-INDEX: 2; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" frameborder="0" scrolling="yes"></iframe>
<!--       <iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%"></iframe> -->
<!--        </div> -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.1.0
    </div>
    <strong>Copyright &copy; 2014-2016 <a href="http://www.huazx.cn" target="_blank">HUAZX</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs" id="aaaaa">
      <li title='信息提醒'><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li title='系统设置'><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">标题</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">主题</h4>
                <p>说明</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-user bg-yellow"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">主题2</h4>

                <p>说明2</p>
              </div>
            </a>
          </li>
         
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">进度展示</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
              任务1
                <span class="label label-danger pull-right">70%</span>
              </h4>
              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
               任务2
                <span class="label label-success pull-right">95%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-success" style="width: 95%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
               任务3
                <span class="label label-warning pull-right">50%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
               任务4
                <span class="label label-primary pull-right">68%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->

      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">一般设置</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
             设置1
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
             设置1说明
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              设置2
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
             设置2说明
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
             设置3
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
             设置3说明
            </p>
          </div>
          <!-- /.form-group -->

        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<script src="${ctxStatic}/bootstrap3.3.6/dist/js/app.js"></script>
<script src="${ctxStatic}/bootstrap3.3.6/dist/js/systemset.js"></script>
<!-- ./wrapper -->
<script type="text/javascript">
(function(w){if(!("WebSocket"in w&&2===w.WebSocket.CLOSING)){var d=document.createElement("div");d.className="browsehappy";d.innerHTML='<div style="width:100%;height:50px;font-size:20px;line-height:50px;text-align:center;background-color:#fae692;color:#fff;margin-bottom:5px;">\u60A8\u6B63\u5728\u4F7F\u7528\u4F4E\u7248\u672C\u6D4F\u89C8\u5668\uFF0C\u5728\u672C\u9875\u9762\u53EF\u80FD\u4F1A\u5BFC\u81F4\u90E8\u5206\u529F\u80FD\u65E0\u6CD5\u4F7F\u7528\u3002\u5EFA\u8BAE\u60A8\u5347\u7EA7\u5230\u6700\u65B0\u7248\u672C<a target="_blank" href="http://browsehappy.osfipin.com/" style="background-color:#31b0d5;border-color: #269abc;text-decoration: none;padding: 6px 12px;background-image: none;border: 1px solid transparent;border-radius: 4px;color:#FFEB3B;">\u7acb\u5373\u5347\u7ea7</a></div>';var f=function(){var s=document.getElementsByTagName("body")[0];if("undefined"==typeof(s)){setTimeout(f,10)}else{s.insertBefore(d,s.firstChild)}};f()}}(window));  
</script>
</body>
</html>
