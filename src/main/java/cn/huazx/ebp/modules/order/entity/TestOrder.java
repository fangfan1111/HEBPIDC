package cn.huazx.ebp.modules.order.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import java.util.List;
import com.google.common.collect.Lists;

import cn.huazx.ebp.common.persistence.DataEntity;

/**
 * 订单管理Entity
 * @author ff
 * @version 2018-04-25
 */
public class TestOrder extends DataEntity<TestOrder> {
	
	private static final long serialVersionUID = 1L;
	private String orderNo;		// 订单业务流水号
	private Date orderTime;		// 下单时间
	private String totalAmount;		// 商品总额
	private String payType;		// 支付方式：
	private String sysUserId;		// 用户id
	private String loginName;		// 用户名称
	private String addressCode;		// 省市区三级联动
	private String address;		// 详细地址
	private String mobilePhone;		// 手机号
	private String orderStatus;		// 订单状态：
	private Date beginOrderTime;		// 开始 下单时间
	private Date endOrderTime;		// 结束 下单时间
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private List<TestOrderDetail> testOrderDetailList = Lists.newArrayList();		// 子表列表
	
	public TestOrder() {
		super();
	}

	public TestOrder(String id) {
		super(id);
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	@Length(min=0, max=64, message="订单业务流水号长度必须介于 0 和 64 之间")
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="下单时间不能为空")
	public Date getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	
	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	@Length(min=0, max=1, message="支付方式：长度必须介于 0 和 1 之间")
	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}
	
	@Length(min=0, max=64, message="用户长度必须介于 0 和 64 之间")
	public String getSysUserId() {
		return sysUserId;
	}

	public void setSysUserId(String sysUserId) {
		this.sysUserId = sysUserId;
	}
	
	@Length(min=0, max=6, message="省市区三级联动长度必须介于 0 和 6 之间")
	public String getAddressCode() {
		return addressCode;
	}

	public void setAddressCode(String addressCode) {
		this.addressCode = addressCode;
	}
	
	@Length(min=0, max=300, message="详细地址长度必须介于 0 和 300 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=11, message="手机号长度必须介于 0 和 11 之间")
	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	
	@Length(min=0, max=1, message="订单状态：长度必须介于 0 和 1 之间")
	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	public Date getBeginOrderTime() {
		return beginOrderTime;
	}

	public void setBeginOrderTime(Date beginOrderTime) {
		this.beginOrderTime = beginOrderTime;
	}
	
	public Date getEndOrderTime() {
		return endOrderTime;
	}

	public void setEndOrderTime(Date endOrderTime) {
		this.endOrderTime = endOrderTime;
	}
		
	public Date getBeginCreateDate() {
		return beginCreateDate;
	}

	public void setBeginCreateDate(Date beginCreateDate) {
		this.beginCreateDate = beginCreateDate;
	}
	
	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}
		
	public List<TestOrderDetail> getTestOrderDetailList() {
		return testOrderDetailList;
	}

	public void setTestOrderDetailList(List<TestOrderDetail> testOrderDetailList) {
		this.testOrderDetailList = testOrderDetailList;
	}
}