<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>订单管理管理</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}

		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
                $(obj).parent().parent().addClass("error");
				$(obj).parent().parent().html('');
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
            countTotalAmount();
		}

        /* 计算商品总价 */
        function countTotalAmount() {
            var links = document.getElementById("testOrderDetailList").getElementsByTagName("tr");
            var reg1 = /^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$/;
            var reg2 = /^[+]{0,1}(\d+)$/;
            var j=0;
            var jj=0;
            var jjj=0;
            var price,number;
            for (var i = 0; i < links.length; i++){
                var classes = $("#testOrderDetailList"+i).attr("class");
				if (classes == null || classes == ''){
					price = $("#testOrderDetailList"+i+"_price").val();
					number = $("#testOrderDetailList"+i+"_number").val();
					if (price !=null && number!=null && reg1.test(price) && reg2.test(number)){
						j = price * number;
						jj +=j;
						//jj.toFixed(2);//保留两位小时(四舍五入)
						jjj=Math.floor(jj * 100)/100; //不四舍五入
					}
				}
            }
            $("#totalAmount").val(jjj);
        }

	</script>
</head>
<body>
<div class="nav-tabs-custom">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/order/testOrder/">订单管理列表</a></li>
		<li class="active"><a href="${ctx}/order/testOrder/form?id=${testOrder.id}">订单管理<shiro:hasPermission name="order:testOrder:edit">${not empty testOrder.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="order:testOrder:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	</div>
	<form:form id="inputForm" modelAttribute="testOrder" action="${ctx}/order/testOrder/save" method="post" class="form-horizontal">
	<div class="box-body">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				订单业务流水号：</label>
			<div class="col-sm-10 controls">
				<form:input path="orderNo" htmlEscape="false" readonly="true" maxlength="64" cssClass="form-control required"/>
		
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				下单时间：</label>
			<div class="col-sm-10 controls">
				<input name="orderTime" type="text" readonly="readonly" maxlength="20" class="input-medium required"
					value="<fmt:formatDate value="${testOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
		
			</div>
		</div>
		<div class="form-group">
            <label class="col-sm-2 control-label">
				<font color="red">*</font>
				商品总额(单位：元)：</label>
            <div class="col-sm-10 controls">
                <form:input path="totalAmount" id="totalAmount" htmlEscape="false" readonly="true" cssClass="form-control required"/>

            </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				支付方式：</label>
            <div class="col-sm-10 controls">
                <form:radiobuttons path="payType" items="${fns:getDictList('pay_type')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass="required"/>

            </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				用户：</label>
			<div class="col-sm-10 controls">
				<sys:treeselect id="sysUserId" name="sysUserId" value="${testOrder.sysUserId}" labelName="loginName" labelValue="${testOrder.loginName}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
		
			</div>
		</div>
		<div class="form-group">
            <label class="col-sm-2 control-label">
				<font color="red">*</font>
				省市区三级联动：</label>
            <div class="col-sm-10 controls">
                <select name="province" style="width: 200px;"></select>
                <select name="city" style="width: 200px;"></select>
                <select name="area" style="width: 200px"></select>
                <form:hidden id="addressCode" path="addressCode" cssClass="required"/>

            </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				详细地址：</label>
			<div class="col-sm-10 controls">
				<form:input path="address" htmlEscape="false" maxlength="300" cssClass="form-control required"/>
		
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				手机号：</label>
			<div class="col-sm-10 controls">
				<input id="mobilePhone" name="mobilePhone" value="${testOrder.mobilePhone}" maxlength="11" class="form-control required mobile"
					   type="text"/>
		
			</div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
				<font color="red">*</font>
				订单状态：</label>
            <div class="col-sm-10 controls">
                <form:radiobuttons path="orderStatus" items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false" cssClass=" required"/>

            </div>
		</div>
		<div class="form-group">
			<label class="col-sm-2 control-label">
			备注：</label>
			<div class="col-sm-10 controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" cssClass="form-control "/>
		
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
								<th>单价(单位：元)</th>
								<th>数量(单位：件)</th>
								<th>备注</th>
								<shiro:hasPermission name="order:testOrder:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="testOrderDetailList">
						</tbody>
						<shiro:hasPermission name="order:testOrder:edit"><tfoot>
							<tr><td colspan="6"><a href="javascript:" onclick="addRow('#testOrderDetailList', testOrderDetailRowIdx, testOrderDetailTpl);testOrderDetailRowIdx = testOrderDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="testOrderDetailTpl">//<!--
						<tr id="testOrderDetailList{{idx}}">
							<td class="hide">
								<input id="testOrderDetailList{{idx}}_id" name="testOrderDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="testOrderDetailList{{idx}}_delFlag" name="testOrderDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="testOrderDetailList{{idx}}_commodityName" name="testOrderDetailList[{{idx}}].commodityName" type="text" value="{{row.commodityName}}" maxlength="100" class="form-control input-sm "/>
							</td>
							<td>
								<input id="testOrderDetailList{{idx}}_price" name="testOrderDetailList[{{idx}}].price" maxlength="8" oninput="countTotalAmount()" type="text" value="{{row.price}}" class="form-control input-sm price"/>
							</td>
							<td>
								<input id="testOrderDetailList{{idx}}_number" name="testOrderDetailList[{{idx}}].number" maxlength="8" oninput="countTotalAmount()" type="text" value="{{row.number}}" maxlength="11" class="form-control input-sm digits"/>
							</td>
							<td>
								<textarea id="testOrderDetailList{{idx}}_remarks" name="testOrderDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="form-control input-sm ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="order:testOrder:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#testOrderDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
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

                        /*省市区三级联动*/
                        var addressCode = $('#addressCode').val();
                        var sheng;
                        var shengName;
                        var di;
                        var diName;
                        var xian;
                        var xianName;
                        //根据县区区划代码获取省市区名称
                        for (var i = 0; i < AddressList.length; i++) {
                            if (AddressList[i].code == addressCode) {
                                xianName = AddressList[i].name;//获取县区名称
                                sheng = AddressList[i].sheng;
                                di = AddressList[i].di;
                                xian = AddressList[i].xian;
                            }
                        }
                        //获取省份名称
                        for (var i = 0; i < AddressList.length; i++) {
                            if (sheng == AddressList[i].sheng && AddressList[i].di == "00" && AddressList[i].xian == "00") {
                                shengName = AddressList[i].name;
                            }
                        }
                        //获取市名称
                        for (var i = 0; i < AddressList.length; i++) {
                            if (sheng == AddressList[i].sheng && di == AddressList[i].di && AddressList[i].xian == "00") {
                                diName = AddressList[i].name;
                            }
                        }
                        var temp = new CiSelect("province","city","area",shengName,diName,xianName);//初始化省市区并设置默认值

                        $(document).ready(function() {
                            $("select").change(function(){
                                var value;
                                //编码不足六位默认补0，显示简码请第二个参数传true，示例：temp.getCode(temp.DomProvince,true)
                                value = temp.getCode();//默认获取省市区的编码，不传参默认为所选区县的完整编码
                                $("#addressCode").val(value);

                                /*var text;
                                //text = temp.getText();//默认获取完整省市区名称
                                text = temp.getText(temp.DomProvince)+" ";//获取省份名称
                                text += temp.getText(temp.DomCity)+" ";//获取城市名称
                                text += temp.getText(temp.DomArea);//获取区县名称
                                $("#addressCode").val(text);*/
                            });
                        });

                        function getValue() {
                            var value;
                            //编码不足六位默认补0，显示简码请第二个参数传true，示例：temp.getCode(temp.DomProvince,true)
                            value = temp.getCode();//默认获取省市区的编码，不传参默认为所选区县的完整编码
                            //value = temp.getCode(temp.DomProvince)//获取省份编码，
                            //value = temp.getCode(temp.DomProvince,true)//获取省份简码，
                            //value = temp.getCode(temp.DomCity)//获取地区编码
                            //value = temp.getCode(temp.DomArea)//获取区县编码
                            alert("地区编码为："+value);
                        }
                        function getIndex(){//获取下拉框选中项的索引
                            alert(
                                "\n省："+temp.getIndex(temp.DomProvince)+
                                "\n市："+temp.getIndex(temp.DomCity)+
                                "\n区："+temp.getIndex(temp.DomArea)
                            );
                        }
					</script>
				</div>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="order:testOrder:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>