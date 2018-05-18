package cn.huazx.ebp.modules.test.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.huazx.ebp.common.persistence.Page;
import cn.huazx.ebp.common.service.CrudService;
import cn.huazx.ebp.modules.test.entity.TestProject;
import cn.huazx.ebp.modules.test.dao.TestProjectDao;

/**
 * 111Service
 * @author 111
 * @version 2016-11-30
 */
@Service
@Transactional(readOnly = true)
public class TestProjectService extends CrudService<TestProjectDao, TestProject> {

	public TestProject get(String id) {
		return super.get(id);
	}
	
	public List<TestProject> findList(TestProject testProject) {
		return super.findList(testProject);
	}
	
	public Page<TestProject> findPage(Page<TestProject> page, TestProject testProject) {
		return super.findPage(page, testProject);
	}
	
	@Transactional(readOnly = false)
	public void save(TestProject testProject) {
		super.save(testProject);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestProject testProject) {
		super.delete(testProject);
	}
	
}