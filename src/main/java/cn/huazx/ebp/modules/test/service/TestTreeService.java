package cn.huazx.ebp.modules.test.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.huazx.ebp.common.service.TreeService;
import cn.huazx.ebp.common.utils.StringUtils;
import cn.huazx.ebp.modules.test.entity.TestTree;
import cn.huazx.ebp.modules.test.dao.TestTreeDao;

/**
 * 树结构生成Service
 * @author ThinkGem
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class TestTreeService extends TreeService<TestTreeDao, TestTree> {

	public TestTree get(String id) {
		return super.get(id);
	}
	
	public List<TestTree> findList(TestTree testTree) {
		if (StringUtils.isNotBlank(testTree.getParentIds())){
			testTree.setParentIds(","+testTree.getParentIds()+",");
		}
		return super.findList(testTree);
	}
	
	@Transactional(readOnly = false)
	public void save(TestTree testTree) {
		super.save(testTree);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestTree testTree) {
		super.delete(testTree);
	}
	
}