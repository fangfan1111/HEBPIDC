<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>订单管理管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("label").each(function(){
				var ss = $(this).attr("for").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).attr("id") == ss[i]){
						$(this).show();;
					}
				}
			});
		}
	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/order/testOrder/">订单管理列表</a></li>
		<li class="active"><a href="${ctx}/order/testOrder/view?id=${testOrder.id}">订单管理查看</a></li>
	</ul><br/></div>
	<form:form id="inputForm" modelAttribute="testOrder" action="${ctx}/order/testOrder/save" method="post" class="form-horizontal">
		<div class="box-body">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">订单业务流水号：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${testOrder.orderNo}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">下单时间：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm"><fmt:formatDate value="${testOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">商品总额：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${testOrder.totalAmount}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">支付方式：</label>
			<div class="col-sm-10 controls">
				<div class="input-xlarge">${fns:getDictLabel(testOrder.payType,'pay_type','')}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">用户：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${testOrder.loginName}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">省市区三级联动：</label>
			<div class="col-sm-10 controls">
				<div class="input-xlarge">${testOrder.addressCode}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">详细地址：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${testOrder.address}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">手机号：</label>
			<div class="col-sm-10 controls">
				<div class="form-control input-sm">${testOrder.mobilePhone}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">订单状态：</label>
			<div class="col-sm-10 controls">
				<div class="input-xlarge">${fns:getDictLabel(testOrder.orderStatus,'order_status','')}</div>
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">备注：</label>
			<div class="col-sm-10 controls">
				<div class="form-control">${testOrder.remarks}</div>
			</div>
		</div>
			<div class="form-group">
				<label class="control-label">订单详情表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>商品名称</th>
								<th>单价</th>
								<th>数量</th>
								<th>备注</th>
							</tr>
						</thead>
						<tbody id="testOrderDetailList">
						</tbody>
					</table>
					<script type="text/template" id="testOrderDetailTpl">//<!--
						<tr id="testOrderDetailList{{idx}}">
							<td class="hide">
								<input id="testOrderDetailList{{idx}}_id" name="testOrderDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="testOrderDetailList{{idx}}_delFlag" name="testOrderDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<div class="input-small">{{row.commodityName}}</div>
							</td>
							<td>
								<div class="input-small">{{row.price}}</div>
							</td>
							<td>
								<div class="input-small">{{row.number}}</div>
							</td>
							<td>
								<div class="input-small">{{row.remarks}}</div>
							</td>
						</tr>//-->
					</script>
					<script type="text/javascript">
                        var testOrderDetailRowIdx = 0, testOrderDetailTpl = $("#testOrderDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                        $(document).ready(function() {
                            var data = ${fns:toJson(testOrder.testOrderDetailList)};
                            for (var i=0; i<data.length; i++){
                                addRow('#testOrderDetailList', testOrderDetailRowIdx, testOrderDetailTpl, data[i]);
                                testOrderDetailRowIdx = testOrderDetailRowIdx + 1;
                            }
                        });
					</script>
				</div>
			</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		</div>
	</form:form>
</body>
</html>