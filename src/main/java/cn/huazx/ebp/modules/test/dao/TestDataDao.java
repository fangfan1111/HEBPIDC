package cn.huazx.ebp.modules.test.dao;

import cn.huazx.ebp.common.persistence.CrudDao;
import cn.huazx.ebp.common.persistence.annotation.MyBatisDao;
import cn.huazx.ebp.modules.test.entity.TestData;

/**
 * 用户登录DAO接口
 * @author y
 * @version 2016-12-01
 */
@MyBatisDao
public interface TestDataDao extends CrudDao<TestData> {
	
}