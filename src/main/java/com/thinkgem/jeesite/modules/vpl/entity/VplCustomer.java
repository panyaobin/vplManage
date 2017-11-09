/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 客户管理Entity
 * @author popo
 * @version 2017-11-09
 */
public class VplCustomer extends DataEntity<VplCustomer> {
	
	private static final long serialVersionUID = 1L;
	private String cusNo;		// 客户代码
	private String cusName;		// 客户名称
	private String typeId;		// 面数类型ID
	private String price;		// price
	
	public VplCustomer() {
		super();
	}

	public VplCustomer(String id){
		super(id);
	}

	@Length(min=0, max=16, message="客户代码长度必须介于 0 和 16 之间")
	public String getCusNo() {
		return cusNo;
	}

	public void setCusNo(String cusNo) {
		this.cusNo = cusNo;
	}
	
	@Length(min=0, max=255, message="客户名称长度必须介于 0 和 255 之间")
	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	
	@Length(min=0, max=255, message="面数类型ID长度必须介于 0 和 255 之间")
	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
}