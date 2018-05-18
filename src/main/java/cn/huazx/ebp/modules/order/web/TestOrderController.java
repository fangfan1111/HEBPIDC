package cn.huazx.ebp.modules.order.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.jdi.PathSearchingVirtualMachine;
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
import cn.huazx.ebp.modules.order.entity.TestOrder;
import cn.huazx.ebp.modules.order.service.TestOrderService;

import java.util.Date;

/**
 * 订单管理Controller
 *
 * @author ff
 * @version 2018-04-25
 */
@Controller
@RequestMapping(value = "${adminPath}/order/testOrder")
public class TestOrderController extends BaseController {

    @Autowired
    private TestOrderService testOrderService;

    @ModelAttribute
    public TestOrder get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return testOrderService.get(id);
        } else {
            return new TestOrder();
        }
    }

    @RequiresPermissions("order:testOrder:view")
    @RequestMapping(value = {"list", ""})
    public String list(TestOrder testOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<TestOrder> page = testOrderService.findPage(new Page<TestOrder>(request, response), testOrder);
        model.addAttribute("page", page);
        return "modules/order/testOrderList";
    }

    @RequiresPermissions("order:testOrder:view")
    @RequestMapping(value = "form")
    public String form(TestOrder testOrder, Model model) {
        if (testOrder.getOrderNo() == null && testOrder.getOrderTime() == null) {
            testOrderService.getOrderNoByatuo(testOrder);
            testOrderService.setOrderTimeAtuo(testOrder);
            model.addAttribute("testOrder", testOrder);
            return "modules/order/testOrderForm";
        } else {
            model.addAttribute("testOrder", testOrder);
            return "modules/order/testOrderForm";
        }
    }

    @RequiresPermissions("order:testOrder:view")
    @RequestMapping(value = "view")
    public String view(TestOrder testOrder, Model model) {
        model.addAttribute("testOrder", testOrder);
        return "modules/order/testOrderFormView";
    }

    @RequiresPermissions("order:testOrder:edit")
    @RequestMapping(value = "save")
    public String save(TestOrder testOrder, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, testOrder)) {
            return form(testOrder, model);
        }
        testOrderService.save(testOrder);
        addMessage(redirectAttributes, "保存订单成功");
        return "redirect:" + Global.getAdminPath() + "/order/testOrder/?repage";
    }

    @RequiresPermissions("order:testOrder:edit")
    @RequestMapping(value = "delete")
    public String delete(TestOrder testOrder, RedirectAttributes redirectAttributes) {
        testOrderService.delete(testOrder);
        addMessage(redirectAttributes, "删除订单成功");
        return "redirect:" + Global.getAdminPath() + "/order/testOrder/?repage";
    }

}