/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderImportList;
import com.thinkgem.jeesite.modules.vpl.service.VplCustomerService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderImport;
import com.thinkgem.jeesite.modules.vpl.service.VplOrderImportService;

import java.util.List;

/**
 * 订单入库表Controller
 *
 * @author popo
 * @version 2017-12-30
 */
@Controller
@RequestMapping(value = "${adminPath}/vpl/vplOrderImport")
public class VplOrderImportController extends BaseController {

    @Autowired
    private VplOrderImportService vplOrderImportService;

    @Autowired
    private VplCustomerService vplCustomerService;

    @Autowired
    private DictService dictService;


    @ModelAttribute
    public VplOrderImport get(@RequestParam(required = false) String id) {
        VplOrderImport entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = vplOrderImportService.get(id);
        }
        if (entity == null) {
            entity = new VplOrderImport();
        }
        return entity;
    }

    @RequiresPermissions("vpl:vplOrderImport:view")
    @RequestMapping(value = {"list", ""})
    public String list(VplOrderImport vplOrderImport,String remarks, HttpServletRequest request, HttpServletResponse response, Model model) {
        //订单列表页面初始化时加载所有的客户代码
        VplCustomer vplCustomer = new VplCustomer();
        Page<VplCustomer> page_cus = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
        model.addAttribute("page_cus", page_cus);

        Page<VplOrderImport> page = vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), vplOrderImport);
        model.addAttribute("page", page);
        model.addAttribute("vplOrderImport", vplOrderImport);
        if (StringUtils.isNotBlank(remarks)&&remarks.equals("online")){
            return "modules/vpl/vplOrderOnlineList";
        }
        return "modules/vpl/vplOrderImportList";
    }

    @RequiresPermissions("vpl:vplOrderImport:view")
    @RequestMapping(value = "form")
    public String form(VplOrderImport vplOrderImport, Model model, HttpServletRequest request, HttpServletResponse response) {
        //订单录入页面初始化时加载所有的客户代码
        VplCustomer vplCustomer = new VplCustomer();
        Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
        model.addAttribute("page", page);

        //订单录入页面初始化时加载所有的颜色类型
        Dict dict = new Dict();
        dict.setType("vpl_work_type");
        List<Dict> workTypeList = dictService.findPage(new Page<Dict>(request, response), dict).getList();
        model.addAttribute("workTypeList", workTypeList);

        //订单录入页面初始化时加载所有的面板类型
        Dict dict2 = new Dict();
        dict2.setType("vpl_side_type");
        List<Dict> sideTypeList = dictService.findPage(new Page<Dict>(request, response), dict2).getList();
        model.addAttribute("sideTypeList", sideTypeList);

        model.addAttribute("vplOrderImport", vplOrderImport);
        return "modules/vpl/vplOrderImportForm";
    }

    @RequiresPermissions("vpl:vplOrderImport:edit")
    @RequestMapping(value = "save")
    public String save(VplOrderImportList orderImportList, VplOrderImport vplOrderImport, Model model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, vplOrderImport)) {
            return form(vplOrderImport, model, request, response);
        }
        for (int i = 0; i < orderImportList.getOrderImportList().size(); i++) {
            //这里判断是否有产品型号信息，判断有多少条数据
            if (StringUtils.isNotBlank(orderImportList.getOrderImportList().get(i).getProModel())) {
                VplOrderImport voi = new VplOrderImport();
                //此3个字段为属性固定传参，下面的数据为集合传递
                voi.setCusName(vplOrderImport.getCusName());
                voi.setOrderId(vplOrderImport.getOrderId());
                voi.setOrderDate(vplOrderImport.getOrderDate());

                //这里的数据为集合传递
                voi.setProModel(orderImportList.getOrderImportList().get(i).getProModel());
                voi.setLeng(orderImportList.getOrderImportList().get(i).getLeng());
                voi.setWide(orderImportList.getOrderImportList().get(i).getWide());
                voi.setCounts(orderImportList.getOrderImportList().get(i).getCounts());
                voi.setSideType(orderImportList.getOrderImportList().get(i).getSideType());
                voi.setWorkType(orderImportList.getOrderImportList().get(i).getWorkType());
                voi.setPrice(orderImportList.getOrderImportList().get(i).getPrice());
                voi.setRemarks(orderImportList.getOrderImportList().get(i).getRemarks());
                voi.setHasCounts("0");
                vplOrderImportService.save(voi);
            }
        }
        //vplOrderImportService.save(vplOrderImport);
        addMessage(redirectAttributes, "保存订单入库表成功");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplOrderImport/?repage";
    }

    @RequiresPermissions("vpl:vplOrderImport:edit")
    @RequestMapping(value = "delete")
    public String delete(VplOrderImport vplOrderImport, RedirectAttributes redirectAttributes) {
        vplOrderImportService.delete(vplOrderImport);
        addMessage(redirectAttributes, "删除订单入库表成功");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplOrderImport/?repage";
    }

    /**
     * 查看在线产品，总数量-已出货数量！=0的
     * @param vplOrderImport
     * @param redirectAttributes
     * @return
     */
    @RequiresPermissions("vpl:vplOrderImport:view")
    @RequestMapping(value = "getOnline")
    public String getOnline(VplOrderImport vplOrderImport, RedirectAttributes redirectAttributes) {
        return "modules/vpl/vplOrderOnlineList";
    }

}