/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderImport;
import com.thinkgem.jeesite.modules.vpl.service.VplCustomerService;
import com.thinkgem.jeesite.modules.vpl.service.VplOrderImportService;
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
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderDelivery;
import com.thinkgem.jeesite.modules.vpl.service.VplOrderDeliveryService;

import java.util.ArrayList;
import java.util.List;

/**
 * 订单出货Controller
 * @author popo
 * @version 2018-01-01
 */
@Controller
@RequestMapping(value = "${adminPath}/vpl/vplOrderDelivery")
public class VplOrderDeliveryController extends BaseController {

	@Autowired
	private VplOrderImportService vplOrderImportService;

	@Autowired
	private VplOrderDeliveryService vplOrderDeliveryService;

	@Autowired
	private VplCustomerService vplCustomerService;
	
	@ModelAttribute
	public VplOrderDelivery get(@RequestParam(required=false) String id) {
		VplOrderDelivery entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = vplOrderDeliveryService.get(id);
		}
		if (entity == null){
			entity = new VplOrderDelivery();
		}
		return entity;
	}
	
	@RequiresPermissions("vpl:vplOrderDelivery:view")
	@RequestMapping(value = {"list", ""})
	public String list(VplOrderDelivery vplOrderDelivery, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery); 
		model.addAttribute("page", page);
		return "modules/vpl/vplOrderDeliveryList";
	}

	@RequiresPermissions("vpl:vplOrderDelivery:view")
	@RequestMapping(value = "form")
	public String form(VplOrderDelivery vplOrderDelivery, Model model) {
		model.addAttribute("vplOrderDelivery", vplOrderDelivery);
		return "modules/vpl/vplOrderDeliveryForm";
	}

	@RequiresPermissions("vpl:vplOrderDelivery:edit")
	@RequestMapping(value = "save")
	public String save(VplOrderDelivery vplOrderDelivery, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, vplOrderDelivery)){
			return form(vplOrderDelivery, model);
		}
		vplOrderDeliveryService.save(vplOrderDelivery);
		addMessage(redirectAttributes, "保存订单出货成功");
		return "redirect:"+Global.getAdminPath()+"/vpl/vplOrderDelivery/?repage";
	}
	
	@RequiresPermissions("vpl:vplOrderDelivery:edit")
	@RequestMapping(value = "delete")
	public String delete(VplOrderDelivery vplOrderDelivery, RedirectAttributes redirectAttributes) {
		vplOrderDeliveryService.delete(vplOrderDelivery);
		addMessage(redirectAttributes, "删除订单出货成功");
		return "redirect:"+Global.getAdminPath()+"/vpl/vplOrderDelivery/?repage";
	}

	/**
	 * 批量出货，根据出货单号录入出货信息，同时修改订单的出货数量
	 * @param ids 批量出货的 id
	 * @param redirectAttributes 全局页面提示语
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "orderDelivery")
	public String orderDelivery(String ids, RedirectAttributes redirectAttributes, Model model, HttpServletRequest request, HttpServletResponse response) {
		List<VplOrderImport> list=new ArrayList<VplOrderImport>();
		if (null != ids && ids.length() != 0) {
			String[] arr = ids.split(",");
			for (int i = 0; i <arr.length; i++) {
				VplOrderImport vplOrderImport = new VplOrderImport();
				vplOrderImport=vplOrderImportService.get(arr[i]);
				list.add(vplOrderImport);
			}
			model.addAttribute("_cusName",vplOrderImportService.get(arr[0]).getCusName());
			VplCustomer vplCustomer=new VplCustomer();
			vplCustomer.setCusName(vplOrderImportService.get(arr[0]).getCusName());
			Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);

			//每次查询出
			VplOrderDelivery vplOrderDelivery=new VplOrderDelivery();

			System.out.println(vplOrderImportService.get(arr[0]).getCusName()+"-----------------------------------");

			vplOrderDelivery.setCusName(vplOrderImportService.get(arr[0]).getCusName());
			Page<VplOrderDelivery> page2 = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
			if(page2.getList().size()>0){
				int id=Integer.parseInt(page2.getList().get(0).getDeliveryId());
				model.addAttribute("_cusId",id+1);
			}else{
				model.addAttribute("_cusId",Integer.valueOf(page.getList().get(0).getCusNo())*100000+1);
			}

		}
		model.addAttribute("orderDeList",list);
		return "modules/vpl/vplOrderDeliveryList";
	}
}