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
import cn.huazx.ebp.modules.test.entity.TestData;
import cn.huazx.ebp.modules.test.service.TestDataService;

/**
 * 用户登录Controller
 * @author y
 * @version 2016-12-01
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testData")
public class TestDataController extends BaseController {

	@Autowired
	private TestDataService testDataService;
	
	@ModelAttribute
	public TestData get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return testDataService.get(id);
		}else{
			return new TestData();
		}
	}
	
	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = {"list", ""})
	public String list(TestData testData, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TestData> page = testDataService.findPage(new Page<TestData>(request, response), testData); 
		model.addAttribute("page", page);
		return "modules/test/testDataList";
	}

	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "form")
	public String form(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return "modules/test/testDataForm";
	}
	
	@RequiresPermissions("test:testData:view")
	@RequestMapping(value = "view")
	public String view(TestData testData, Model model) {
		model.addAttribute("testData", testData);
		return "modules/test/testDataFormView";
	}

	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "save")
	public String save(TestData testData, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testData)){
			return form(testData, model);
		}
		testDataService.save(testData);
		addMessage(redirectAttributes, "保存用户登录成功");
		return "redirect:"+Global.getAdminPath()+"/test/testData/?repage";
	}
	
	@RequiresPermissions("test:testData:edit")
	@RequestMapping(value = "delete")
	public String delete(TestData testData, RedirectAttributes redirectAttributes) {
		testDataService.delete(testData);
		addMessage(redirectAttributes, "删除用户登录成功");
		return "redirect:"+Global.getAdminPath()+"/test/testData/?repage";
	}

}