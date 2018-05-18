package cn.huazx.ebp.modules.order.entity;

import org.hibernate.validator.constraints.Length;

import cn.huazx.ebp.common.persistence.DataEntity;

/**
 * 订单管理Entity
 * @author ff
 * @version 2018-04-25
 */
public class TestOrderDetail extends DataEntity<TestOrderDetail> {
	
	private static final long serialVersionUID = 1L;
	private String orderId;		// 订单编号 父类
	private String commodityName;		// 商品名称
	private String price;		// 单价
	private String number;		// 数量
	
	public TestOrderDetail() {
		super();
	}

	public TestOrderDetail(String orderId) {
		this.orderId = orderId;
	}

	@Length(min=0, max=64, message="订单编号长度必须介于 0 和 64 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=100, message="商品名称长度必须介于 0 和 100 之间")
	public String getCommodityName() {
		return commodityName;
	}

	public void setCommodityName(String commodityName) {
		this.commodityName = commodityName;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	@Length(min=0, max=11, message="数量长度必须介于 0 和 11 之间")
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
}