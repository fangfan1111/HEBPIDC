package cn.huazx.ebp.modules.order.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.huazx.ebp.common.persistence.Page;
import cn.huazx.ebp.common.service.CrudService;
import cn.huazx.ebp.common.utils.StringUtils;
import cn.huazx.ebp.modules.order.entity.TestOrder;
import cn.huazx.ebp.modules.order.dao.TestOrderDao;
import cn.huazx.ebp.modules.order.entity.TestOrderDetail;
import cn.huazx.ebp.modules.order.dao.TestOrderDetailDao;

/**
 * 订单管理Service
 * @author ff
 * @version 2018-04-25
 */
@Service
@Transactional(readOnly = true)
public class TestOrderService extends CrudService<TestOrderDao, TestOrder> {

	@Autowired
	private TestOrderDetailDao testOrderDetailDao;

	public TestOrder get(String id) {
		TestOrder testOrder = super.get(id);
		testOrder.setTestOrderDetailList(testOrderDetailDao.findList(new TestOrderDetail(testOrder.getId())));
		return testOrder;
	}
	
	public List<TestOrder> findList(TestOrder testOrder) {
		return super.findList(testOrder);
	}

	public Page<TestOrder> findPage(Page<TestOrder> page, TestOrder testOrder) {
		return super.findPage(page, testOrder);
	}
	
	@Transactional(readOnly = false)
	public void save(TestOrder testOrder) {
		super.save(testOrder);
		for (TestOrderDetail testOrderDetail : testOrder.getTestOrderDetailList()){
			if (TestOrderDetail.DEL_FLAG_NORMAL.equals(testOrderDetail.getDelFlag())){
				if (StringUtils.isBlank(testOrderDetail.getId())){
					testOrderDetail.setOrderId(testOrder.getId());
					testOrderDetail.preInsert();
					testOrderDetailDao.insert(testOrderDetail);
				}else{
					testOrderDetail.preUpdate();
					testOrderDetailDao.update(testOrderDetail);
				}
			}else{
				testOrderDetailDao.delete(testOrderDetail);
			}
		}
	}
	
	@Transactional(readOnly = false)
	public void delete(TestOrder testOrder) {
		super.delete(testOrder);
		testOrderDetailDao.delete(new TestOrderDetail(testOrder.getId()));
	}

	/**
	 * 生成订单编号
	 * @param testOrder
	 * @return
	 */
	public TestOrder getOrderNoByatuo(TestOrder testOrder) {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String number = sdf.format(date);
		Random rnd = new Random();
		int num = rnd.nextInt(100000);
		String s = String.valueOf(num);
		String orderNo = number + s;
		testOrder.setOrderNo(orderNo);
		return testOrder;
	}

	/**
	 * 生成订下单时间
	 * @param testOrder
	 * @return
	 */
	public TestOrder setOrderTimeAtuo(TestOrder testOrder) {
		Date date = new Date();
		testOrder.setOrderTime(date);
		return testOrder;
	}



}