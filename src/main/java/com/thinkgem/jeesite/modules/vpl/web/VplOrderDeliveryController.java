/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.vpl.entity.*;
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
import com.thinkgem.jeesite.modules.vpl.service.VplOrderDeliveryService;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
		return "modules/vpl/vplOrderDeliveryList_2";
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
		String counts=vplOrderDeliveryService.get(vplOrderDelivery.getId()).getCounts();
		String proModel= vplOrderDeliveryService.get(vplOrderDelivery.getId()).getProModel();
		String orderId= vplOrderDeliveryService.get(vplOrderDelivery.getId()).getOrderId();
		VplOrderImport vplOrderImport=vplOrderImportService.findListByProModel(proModel,orderId);
		vplOrderImport.setHasCounts(String.valueOf((Integer.parseInt(vplOrderImport.getHasCounts()))-(Integer.parseInt(counts))));
		vplOrderImportService.save(vplOrderImport);
		vplOrderDeliveryService.delete(vplOrderDelivery);
		addMessage(redirectAttributes, "送货单成功成功作废！");
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

			VplCustomer vplCustomer=new VplCustomer();
			vplCustomer.setCusNo(vplOrderImportService.get(arr[0]).getCusName());
			Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
            model.addAttribute("_cusName",page.getList().get(0).getCusName());
			//每次查询出
			VplOrderDelivery vplOrderDelivery=new VplOrderDelivery();

			System.out.println(vplOrderImportService.get(arr[0]).getCusName()+"-----------------------------------");

			vplOrderDelivery.setCusName(vplOrderImportService.get(arr[0]).getCusName());
			Page<VplOrderDelivery> page2 = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
			if(page2.getList().size()>0){
				int id=Integer.parseInt(page2.getList().get(0).getDeliveryId());
				model.addAttribute("_cusId",id+1);
			}else{
                System.out.println(list.get(0).getCusName());
				model.addAttribute("_cusId",Integer.valueOf(list.get(0).getCusName())*100000+1);
			}

		}
		model.addAttribute("orderDeList",list);
		return "modules/vpl/vplOrderDeliveryList";
	}

	/**
	 * 打印功能，跳转页面打印预览
	 * @param orderDeList
	 * @param vplOrderDelivery
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "printView")
	public String printView(VplOrderDeliveryList  orderDeList, VplOrderDelivery vplOrderDelivery, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException {
	    for (int i = 0; i <orderDeList.getOrderDeList().size() ; i++) {
			if (StringUtils.isNotBlank(orderDeList.getOrderDeList().get(i).getProModel())){
				//在线产品录入送货单列表
				VplOrderDelivery vpl=new VplOrderDelivery();
				vpl.setDeliveryId(vplOrderDelivery.getDeliveryId());
				vpl.setProModel(orderDeList.getOrderDeList().get(i).getProModel());
				vpl.setLeng(orderDeList.getOrderDeList().get(i).getLeng());
				vpl.setWide(orderDeList.getOrderDeList().get(i).getWide());
				vpl.setCounts(orderDeList.getOrderDeList().get(i).getCounts());
				vpl.setPrice(orderDeList.getOrderDeList().get(i).getPrice());
				vpl.setSideType(orderDeList.getOrderDeList().get(i).getSideType());
				vpl.setCusName(vplOrderDelivery.getCusName());
				vpl.setDeliveryDate(vplOrderDelivery.getDeliveryDate());
				vpl.setOrderId(orderDeList.getOrderDeList().get(i).getOrderId());
				vpl.setRemarks(orderDeList.getOrderDeList().get(i).getRemarks());
				vpl.setDeliveryDate(new Date());
				vplOrderDeliveryService.save(vpl);
				addMessage(redirectAttributes, "送货单录入成功");

				//出货单提交之后，修改订单中 出货数量
				//通过每条数据的订单号和客户型号，查找到对应的订单号，从而修改数量
				/*VplOrderImport tsyim=new VplOrderImport();
				tsyim.setProModel(orderDeList.getOrderDeList().get(i).getProModel());
				tsyim.setOrderId(orderDeList.getOrderDeList().get(i).getOrderId());
				Page<VplOrderImport> page = vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), tsyim);*/

				//通过订单号和产品型号查询出该订单已出货数量
				//传入已经出货数量，累计修改已出货数量
				VplOrderImport tsyim1 =vplOrderImportService.findListByProModel(orderDeList.getOrderDeList().get(i).getProModel(),orderDeList.getOrderDeList().get(i).getOrderId());
				model.addAttribute("date",new Date());
				tsyim1.setHasCounts(String.valueOf(Integer.parseInt(tsyim1.getHasCounts())+Integer.parseInt(orderDeList.getOrderDeList().get(i).getCounts())));
				vplOrderImportService.save(tsyim1);
			}
		}
		model.addAttribute("orderDelList",orderDeList.getOrderDeList());
		System.out.println(orderDeList.getClass()+"-----------------------");
		model.addAttribute("tsyOrderDelivery",vplOrderDelivery);
		Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
		model.addAttribute("page", page);
		/*if (tsyOrderDelivery.getCusName().equals("凯强")){
			return "modules/tsy/tsyPrintView_tsy";
		}*/
		return "modules/vpl/vplPrintView";
	}

}