package cn.huazx.ebp.modules.order.dao;

import cn.huazx.ebp.common.persistence.CrudDao;
import cn.huazx.ebp.common.persistence.annotation.MyBatisDao;
import cn.huazx.ebp.modules.order.entity.TestOrder;

/**
 * 订单管理DAO接口
 * @author ff
 * @version 2018-04-25
 */
@MyBatisDao
public interface TestOrderDao extends CrudDao<TestOrder> {
	
}