/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.List;

/**
 * 送货单管理Entity
 * @author popo
 * @version 2017-10-21
 */
public class VplOrderDeliveryList extends DataEntity<VplOrderDeliveryList> {

	private static final long serialVersionUID = 1L;

	private List<VplOrderDelivery> orderDeList;

    public List<VplOrderDelivery> getOrderDeList() {
        return orderDeList;
    }

    public void setOrderDeList(List<VplOrderDelivery> orderDeList) {
        this.orderDeList = orderDeList;
    }
}