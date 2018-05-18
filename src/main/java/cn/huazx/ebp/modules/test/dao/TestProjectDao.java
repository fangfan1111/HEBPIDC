package cn.huazx.ebp.modules.test.dao;

import cn.huazx.ebp.common.persistence.CrudDao;
import cn.huazx.ebp.common.persistence.annotation.MyBatisDao;
import cn.huazx.ebp.modules.test.entity.TestProject;

/**
 * 111DAO接口
 * @author 111
 * @version 2016-11-30
 */
@MyBatisDao
public interface TestProjectDao extends CrudDao<TestProject> {
	
}