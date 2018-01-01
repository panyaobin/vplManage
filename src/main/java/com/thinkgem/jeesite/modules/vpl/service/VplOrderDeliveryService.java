/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderDelivery;
import com.thinkgem.jeesite.modules.vpl.dao.VplOrderDeliveryDao;

/**
 * 订单出货Service
 * @author popo
 * @version 2018-01-01
 */
@Service
@Transactional(readOnly = true)
public class VplOrderDeliveryService extends CrudService<VplOrderDeliveryDao, VplOrderDelivery> {

	public VplOrderDelivery get(String id) {
		return super.get(id);
	}
	
	public List<VplOrderDelivery> findList(VplOrderDelivery vplOrderDelivery) {
		return super.findList(vplOrderDelivery);
	}
	
	public Page<VplOrderDelivery> findPage(Page<VplOrderDelivery> page, VplOrderDelivery vplOrderDelivery) {
		return super.findPage(page, vplOrderDelivery);
	}
	
	@Transactional(readOnly = false)
	public void save(VplOrderDelivery vplOrderDelivery) {
		super.save(vplOrderDelivery);
	}
	
	@Transactional(readOnly = false)
	public void delete(VplOrderDelivery vplOrderDelivery) {
		super.delete(vplOrderDelivery);
	}
	
}