/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderDelivery;

/**
 * 订单出货DAO接口
 * @author popo
 * @version 2018-01-01
 */
@MyBatisDao
public interface VplOrderDeliveryDao extends CrudDao<VplOrderDelivery> {
	
}