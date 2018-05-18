<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>订单管理管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/order/testOrder/">订单管理列表</a></li>
		<shiro:hasPermission name="order:testOrder:edit"><li><a href="${ctx}/order/testOrder/form">订单管理添加</a></li></shiro:hasPermission>
	</ul></div>
	<div class="box-body">
	<form:form id="searchForm" modelAttribute="testOrder" action="${ctx}/order/testOrder/" method="post" class="breadcrumb form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<fieldset>
<div class="form-group">		
			<label class="col-sm-1 control-label" for="orderNo">订单业务流水号 ：</label>
			<div class="col-sm-1">
				<form:input path="orderNo" htmlEscape="false" maxlength="64" class="form-control input-sm"/>
			</div>
			<label class="col-sm-1 control-label" for="testOrderDetailList[0].commodityName">商品名称 ：</label>
			<div class="col-sm-1">
				<form:input path="testOrderDetailList[0].commodityName" htmlEscape="false" maxlength="100" class="form-control input-sm"/>
			</div>
			<label class="col-sm-1 control-label" for="orderTime">下单时间 ：</label>
			<div class="col-sm-2">
                <input id="beginOrderTime" name="beginOrderTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                       value="<fmt:formatDate value="${testOrder.beginOrderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endOrderTime\',{d:0})}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/> 起
                <input id="endOrderTime" name="endOrderTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                       value="<fmt:formatDate value="${testOrder.endOrderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginOrderTime\',{d:1})}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/> 止
			</div>
			<label class="col-sm-1 control-label" for="payType">支付方式：</label>
            <div class="col-sm-1">
                <form:radiobuttons path="payType" items="${fns:getDictList('pay_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </div>
			<label class="col-sm-1 control-label" for="sysUserId">用户 ：</label>
			<div class="col-sm-2">
				<sys:treeselect id="sysUserId" name="sysUserId" value="${testOrder.sysUserId}" labelName="loginName" labelValue="${testOrder.loginName}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-sml" allowClear="true" notAllowSelectParent="true"/>
			</div>
			<label class="col-sm-1 control-label" for="mobilePhone">手机号 ：</label>
			<div class="col-sm-2">
				<form:input path="mobilePhone" htmlEscape="false" maxlength="11" class="form-control input-sm"/>
			</div>
			<label class="col-sm-1 control-label" for="orderStatus">订单状态：</label>
            <div class="col-sm-2">
                <form:radiobuttons path="orderStatus" items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </div>
			<label class="col-sm-1 control-label" for="createDate">创建时间 ：</label>
			<div class="col-sm-2">
                <input id="beginCreateDate" name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                       value="<fmt:formatDate value="${testOrder.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({maxDate:'#F{$dp.$D(\'endCreateDate\',{d:0})}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/> 起
                <input id="endCreateDate" name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                       value="<fmt:formatDate value="${testOrder.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                       onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginCreateDate\',{d:0})}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/> 止
			</div>
		</div>
			<input id="btnSubmit" class="btn btn-primary pull-right" type="submit" value="查询"/>
		</fieldset>
	</form:form>
	</div>
	<sys:message content="${message}"/>
	<div class="content-padding" style="margin-top:6px;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
        <tr>
            <th>订单编号</th>
            <th>商品总额</th>
            <th>支付方式</th>
            <th>用户</th>
            <th>配送地址</th>
            <th>联系电话</th>
            <th>下单时间</th>
            <th>订单状态</th>
            <th>创建时间</th>
            <th>更新时间</th>
            <th>备注</th>
            <shiro:hasPermission name="order:testOrder:edit"><th>操作</th></shiro:hasPermission>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="testOrder">
            <tr>
                <td><a href="${ctx}/order/testOrder/view?id=${testOrder.id}">
                    ${testOrder.orderNo}
                </a></td>
                <td>
                    ${testOrder.totalAmount}
                </td>
                <td>
                    <c:choose>
                        <c:when test="${testOrder.payType eq '0'}">货到付款</c:when>
                        <c:when test="${testOrder.payType eq '1'}">支付宝</c:when>
                        <c:otherwise>微信</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    ${testOrder.loginName}
                </td>
                <td>
                    ${testOrder.address}
                </td>
                <td>
                    ${testOrder.mobilePhone}
                </td>
                <td>
                    <fmt:formatDate value="${testOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${testOrder.orderStatus eq '0'}">暂存</c:when>
                        <c:when test="${testOrder.orderStatus eq '1'}">已提交</c:when>
                        <c:when test="${testOrder.orderStatus eq '2'}">已发货</c:when>
                        <c:otherwise>已完成</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <fmt:formatDate value="${testOrder.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    <fmt:formatDate value="${testOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>
                    ${testOrder.remarks}
                </td>
                <shiro:hasPermission name="order:testOrder:edit"><td>
                    <a href="${ctx}/order/testOrder/form?id=${testOrder.id}">修改</a>
                    <a href="${ctx}/order/testOrder/delete?id=${testOrder.id}" onclick="return confirmx('确认要删除该订单管理吗？', this.href)">删除</a>
                </td></shiro:hasPermission>
            </tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div></div>
</body>
</html>