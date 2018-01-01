/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 订单出货Entity
 * @author popo
 * @version 2018-01-01
 */
public class VplOrderDelivery extends DataEntity<VplOrderDelivery> {
	
	private static final long serialVersionUID = 1L;
	private String deliveryId;		// 出货单ID
	private String proModel;		// 产品型号
	private String leng;		// 长
	private String wide;		// 宽
	private String price;		// 客户报价
	private String counts;		// 出货数量
	private String orderId;		// 订单号
	private String sideType;		// 面板类型
	private String cusName;		// 客户名称
	private Date deliveryDate;		// 出货日期
	
	public VplOrderDelivery() {
		super();
	}

	public VplOrderDelivery(String id){
		super(id);
	}

	@Length(min=0, max=255, message="出货单ID长度必须介于 0 和 255 之间")
	public String getDeliveryId() {
		return deliveryId;
	}

	public void setDeliveryId(String deliveryId) {
		this.deliveryId = deliveryId;
	}
	
	@Length(min=0, max=255, message="产品型号长度必须介于 0 和 255 之间")
	public String getProModel() {
		return proModel;
	}

	public void setProModel(String proModel) {
		this.proModel = proModel;
	}
	
	@Length(min=0, max=32, message="长长度必须介于 0 和 32 之间")
	public String getLeng() {
		return leng;
	}

	public void setLeng(String leng) {
		this.leng = leng;
	}
	
	@Length(min=0, max=32, message="宽长度必须介于 0 和 32 之间")
	public String getWide() {
		return wide;
	}

	public void setWide(String wide) {
		this.wide = wide;
	}
	
	@Length(min=0, max=255, message="客户报价长度必须介于 0 和 255 之间")
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	@Length(min=0, max=255, message="出货数量长度必须介于 0 和 255 之间")
	public String getCounts() {
		return counts;
	}

	public void setCounts(String counts) {
		this.counts = counts;
	}
	
	@Length(min=0, max=255, message="订单号长度必须介于 0 和 255 之间")
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	
	@Length(min=0, max=255, message="面板类型长度必须介于 0 和 255 之间")
	public String getSideType() {
		return sideType;
	}

	public void setSideType(String sideType) {
		this.sideType = sideType;
	}
	
	@Length(min=0, max=255, message="客户名称长度必须介于 0 和 255 之间")
	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}
	
}