/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;
import com.thinkgem.jeesite.modules.vpl.dao.VplCustomerDao;

/**
 * 客户管理Service
 * @author popo
 * @version 2017-11-09
 */
@Service
@Transactional(readOnly = true)
public class VplCustomerService extends CrudService<VplCustomerDao, VplCustomer> {

	public VplCustomer get(String id) {
		return super.get(id);
	}
	
	public List<VplCustomer> findList(VplCustomer vplCustomer) {
		return super.findList(vplCustomer);
	}
	
	public Page<VplCustomer> findPage(Page<VplCustomer> page, VplCustomer vplCustomer) {
		return super.findPage(page, vplCustomer);
	}
	
	@Transactional(readOnly = false)
	public void save(VplCustomer vplCustomer) {
		super.save(vplCustomer);
	}
	
	@Transactional(readOnly = false)
	public void delete(VplCustomer vplCustomer) {
		super.delete(vplCustomer);
	}
	
}