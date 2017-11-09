/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vpl.entity.VplCustomer;

/**
 * 客户管理DAO接口
 * @author popo
 * @version 2017-11-09
 */
@MyBatisDao
public interface VplCustomerDao extends CrudDao<VplCustomer> {
	
}