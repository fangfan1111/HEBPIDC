package cn.huazx.ebp.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.huazx.ebp.common.web.BaseController;
@Controller
@RequestMapping(value = "${adminPath}/sys/test")
public class TestControllers extends BaseController{
	@RequestMapping(value = "goupindex")
	public String goupindex() {
		return "modules/test/index2";
	}
	@RequestMapping(value = "goupindexs")
	public String goupindexs() {
		return "modules/test/index";
	}
	@RequestMapping(value = "gotest")
	public String gotest() {
		return "modules/test/test";
	}
	
}
