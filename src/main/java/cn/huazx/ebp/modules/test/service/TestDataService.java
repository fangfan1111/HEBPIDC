package cn.huazx.ebp.modules.test.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.huazx.ebp.common.persistence.Page;
import cn.huazx.ebp.common.service.CrudService;
import cn.huazx.ebp.modules.test.entity.TestData;
import cn.huazx.ebp.modules.test.dao.TestDataDao;

/**
 * 用户登录Service
 * @author y
 * @version 2016-12-01
 */
@Service
@Transactional(readOnly = true)
public class TestDataService extends CrudService<TestDataDao, TestData> {

	public TestData get(String id) {
		return super.get(id);
	}
	
	public List<TestData> findList(TestData testData) {
		return super.findList(testData);
	}
	
	public Page<TestData> findPage(Page<TestData> page, TestData testData) {
		return super.findPage(page, testData);
	}
	
	@Transactional(readOnly = false)
	public void save(TestData testData) {
		super.save(testData);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestData testData) {
		super.delete(testData);
	}
	
}