package cn.huazx.ebp.modules.test.dao;

import cn.huazx.ebp.common.persistence.CrudDao;
import cn.huazx.ebp.common.persistence.annotation.MyBatisDao;
import cn.huazx.ebp.modules.test.entity.TestDataMain;

/**
 * 主子表生成DAO接口
 * @author fjw
 * @version 2016-11-30
 */
@MyBatisDao
public interface TestDataMainDao extends CrudDao<TestDataMain> {
	
}