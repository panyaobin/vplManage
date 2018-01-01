/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.List;

/**
 * 订单录入Entity
 *
 * @author popo
 * @version 2017-12-30
 */
public class VplOrderImportList extends DataEntity<VplOrderImportList> {

    private static final long serialVersionUID = 1L;

    private List<VplOrderImport> orderImportList;

    public List<VplOrderImport> getOrderImportList() {
        return orderImportList;
    }

    public void setOrderImportList(List<VplOrderImport> orderImportList) {
        this.orderImportList = orderImportList;
    }
}