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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;
import com.thinkgem.jeesite.modules.vpl.service.VplCustomerService;

import java.util.List;

/**
 * 客户管理Controller
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
	public VplCustomer get(@RequestParam(required=false) String id) {
		VplCustomer entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = vplCustomerService.get(id);
		}
		if (entity == null){
			entity = new VplCustomer();
		}
		return entity;
	}
	
	@RequiresPermissions("vpl:vplCustomer:view")
	@RequestMapping(value = {"list", ""})
	public String list(VplCustomer vplCustomer, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
		model.addAttribute("page", page);
		return "modules/vpl/vplCustomerList";
	}

	@RequiresPermissions("vpl:vplCustomer:view")
	@RequestMapping(value = "form")
	public String form(VplCustomer vplCustomer, Model model) {
		Dict dict = new Dict();
		dict.setType("vpl_side_type");
		List<Dict> dictList=dictService.findList(dict);
		model.addAttribute("vplCustomer", vplCustomer);
		model.addAttribute("dictList", dictList);
		return "modules/vpl/vplCustomerForm";
	}

	@RequiresPermissions("vpl:vplCustomer:edit")
	@RequestMapping(value = "save")
	public String save(VplCustomer vplCustomer, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, vplCustomer)){
			return form(vplCustomer, model);

		}
		vplCustomerService.save(vplCustomer);
		addMessage(redirectAttributes, "保存客户管理成功");
		return "redirect:"+Global.getAdminPath()+"/vpl/vplCustomer/?repage";
	}
	
	@RequiresPermissions("vpl:vplCustomer:edit")
	@RequestMapping(value = "delete")
	public String delete(VplCustomer vplCustomer, RedirectAttributes redirectAttributes) {
		vplCustomerService.delete(vplCustomer);
		addMessage(redirectAttributes, "删除客户管理成功");
		return "redirect:"+Global.getAdminPath()+"/vpl/vplCustomer/?repage";
	}

}