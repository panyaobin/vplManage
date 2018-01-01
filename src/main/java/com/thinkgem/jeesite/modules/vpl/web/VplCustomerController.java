/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;
import com.thinkgem.jeesite.modules.vpl.service.VplCustomerService;

import java.util.Arrays;
import java.util.List;

/**
 * 客户管理Controller
 *
 * @author popo
 * @version 2017-11-09
 */
@Controller
@RequestMapping(value = "${adminPath}/vpl/vplCustomer")
public class VplCustomerController extends BaseController {

    @Autowired
    private VplCustomerService vplCustomerService;

    @Autowired
    private DictService dictService;


    @ModelAttribute
    public VplCustomer get(@RequestParam(required = false) String id) {
        VplCustomer entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = vplCustomerService.get(id);
        }
        if (entity == null) {
            entity = new VplCustomer();
        }
        return entity;
    }

    @RequiresPermissions("vpl:vplCustomer:view")
    @RequestMapping(value = {"list", ""})
    public String list(VplCustomer vplCustomer, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
        Dict dict = new Dict();
        dict.setType("vpl_side_type");
        List<Dict> dictList = dictService.findList(dict);
        model.addAttribute("vplCustomer", vplCustomer);
        model.addAttribute("dictList", dictList);
        model.addAttribute("page", page);
        return "modules/vpl/vplCustomerList";
    }

    @RequiresPermissions("vpl:vplCustomer:view")
    @RequestMapping(value = "form")
    public String form(VplCustomer vplCustomer, Model model, HttpServletRequest request, HttpServletResponse response) {
        Dict dict = new Dict();
        dict.setType("vpl_side_type");
        List<Dict> dictList = dictService.findList(dict);
        model.addAttribute("vplCustomer", vplCustomer);
        model.addAttribute("dictList", dictList);
        if (StringUtils.isNotBlank(vplCustomer.getCusNo())) {
            Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
            System.out.println(page);
            model.addAttribute("vplCustomer", page.getList().get(0));
            String[] p = page.getList().get(0).getPrice().split(",");
            model.addAttribute("price1", p);
        }

        return "modules/vpl/vplCustomerForm";
    }

    @RequiresPermissions("vpl:vplCustomer:edit")
    @RequestMapping(value = "save")
    public String save(VplCustomer vplCustomer, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, vplCustomer)) {
            return form(vplCustomer, model, request, response);

        }
        String[] type_a = vplCustomer.getTypeId().split(",");
        //String [] price_a=vplCustomer.getPrice().split(",");
        for (int i = 0; i < type_a.length; i++) {
            VplCustomer vp = new VplCustomer();
            if (StringUtils.isNotBlank(vplCustomer.getId())){
                vp.setId(String.valueOf(Integer.parseInt(vplCustomer.getId())+i));
            }
            vp.setCusNo(vplCustomer.getCusNo());
            vp.setCusName(vplCustomer.getCusName());
            vp.setTypeId(type_a[i]);
            vp.setPrice(vplCustomer.getPrice1().get(i));
            vp.setRemarks(vplCustomer.getRemarks());
            vplCustomerService.save(vp);
        }
        addMessage(redirectAttributes, "保存客户管理成功");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplCustomer/?repage";
    }

    @RequiresPermissions("vpl:vplCustomer:edit")
    @RequestMapping(value = "delete")
    public String delete(VplCustomer vplCustomer, RedirectAttributes redirectAttributes) {
        vplCustomerService.delete(vplCustomer);
        addMessage(redirectAttributes, "删除客户管理成功");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplCustomer/?repage";
    }

    //查询用户报价
    @RequiresPermissions("vpl:vplCustomer:view")
    @RequestMapping(value = "selPrice")
    @ResponseBody
    public String selPrice(VplCustomer vplCustomer,String cusNo, Model model) {
        vplCustomer.setCusNo(cusNo);
        VplCustomer vc=vplCustomerService.getCusPrice(vplCustomer);
        return vc.getPrice();
    }
}