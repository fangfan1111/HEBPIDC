package cn.huazx.ebp.modules.test.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import cn.huazx.ebp.common.config.Global;
import cn.huazx.ebp.common.persistence.Page;
import cn.huazx.ebp.common.web.BaseController;
import cn.huazx.ebp.common.utils.StringUtils;
import cn.huazx.ebp.modules.test.entity.TestProject;
import cn.huazx.ebp.modules.test.service.TestProjectService;

/**
 * 111Controller
 * @author 111
 * @version 2016-11-30
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testProject")
public class TestProjectController extends BaseController {

	@Autowired
	private TestProjectService testProjectService;
	
	@ModelAttribute
	public TestProject get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return testProjectService.get(id);
		}else{
			return new TestProject();
		}
	}
	
	@RequiresPermissions("test:testProject:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestProject testProject, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestProject> page = testProjectService.findPage(new Page<TestProject>(request, response), testProject); 
		model.addAttribute("page", page);
		return "modules/test/testProjectList";
	}

	@RequiresPermissions("test:testProject:view")
	@RequestMapping(value = "form")
	public String form(TestProject testProject, Model model) {
		model.addAttribute("testProject", testProject);
		return "modules/test/testProjectForm";
	}
	
	@RequiresPermissions("test:testProject:view")
	@RequestMapping(value = "view")
	public String view(TestProject testProject, Model model) {
		model.addAttribute("testProject", testProject);
		return "modules/test/testProjectFormView";
	}

	@RequiresPermissions("test:testProject:edit")
	@RequestMapping(value = "save")
	public String save(TestProject testProject, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testProject)){
			return form(testProject, model);
		}
		testProjectService.save(testProject);
		addMessage(redirectAttributes, "保存111成功");
		return "redirect:"+Global.getAdminPath()+"/test/testProject/?repage";
	}
	
	@RequiresPermissions("test:testProject:edit")
	@RequestMapping(value = "delete")
	public String delete(TestProject testProject, RedirectAttributes redirectAttributes) {
		testProjectService.delete(testProject);
		addMessage(redirectAttributes, "删除111成功");
		return "redirect:"+Global.getAdminPath()+"/test/testProject/?repage";
	}

}