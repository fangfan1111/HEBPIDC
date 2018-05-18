package cn.huazx.ebp.modules.test.dao;

import cn.huazx.ebp.common.persistence.TreeDao;
import cn.huazx.ebp.common.persistence.annotation.MyBatisDao;
import cn.huazx.ebp.modules.test.entity.TestTree;

/**
 * 树结构生成DAO接口
 * @author ThinkGem
 * @version 2016-11-30
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}