/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.vpl.entity.VplOrderImport;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单入库表DAO接口
 * @author popo
 * @version 2017-12-30
 */
@MyBatisDao
public interface VplOrderImportDao extends CrudDao<VplOrderImport> {
    VplOrderImport findListByProModel(@Param(value ="proModel") String proModel, @Param(value="orderId")String orderId);
}