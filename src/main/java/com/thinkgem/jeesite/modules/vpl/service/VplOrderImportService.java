/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderImport;
import com.thinkgem.jeesite.modules.vpl.dao.VplOrderImportDao;

/**
 * 订单入库表Service
 * @author popo
 * @version 2017-12-30
 */
@Service
@Transactional(readOnly = true)
public class VplOrderImportService extends CrudService<VplOrderImportDao, VplOrderImport> {

	public VplOrderImport get(String id) {
		return super.get(id);
	}
	
	public List<VplOrderImport> findList(VplOrderImport vplOrderImport) {
		return super.findList(vplOrderImport);
	}
	
	public Page<VplOrderImport> findPage(Page<VplOrderImport> page, VplOrderImport vplOrderImport) {
		return super.findPage(page, vplOrderImport);
	}
	
	@Transactional(readOnly = false)
	public void save(VplOrderImport vplOrderImport) {
		super.save(vplOrderImport);
	}
	
	@Transactional(readOnly = false)
	public void delete(VplOrderImport vplOrderImport) {
		super.delete(vplOrderImport);
	}

}