/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.entity;

import org.hibernate.validator.constraints.Length;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 订单入库表Entity
 *
 * @author popo
 * @version 2017-12-30
 */
public class VplOrderImport extends DataEntity<VplOrderImport> {

    private static final long serialVersionUID = 1L;
    private String orderId;        // 订单编号
    private String cusName;        // 客户名称
    private String proModel;        // 产品型号
    private String leng;        // 长
    private String wide;        // 宽
    private String counts;        // 订单数量
    private String hasCounts;          //已经出货数量
    private String price;        //客户报价
    private String sideType;        // 面板类型
    private String workType;        // 颜色加工类型
    private Date orderDate;        // 下单日期

    public VplOrderImport() {
        super();
    }

    public VplOrderImport(String id) {
        super(id);
    }

    @Length(min = 0, max = 32, message = "订单编号长度必须介于 0 和 32 之间")
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    @Length(min = 0, max = 32, message = "客户名称长度必须介于 0 和 32 之间")
    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    @Length(min = 0, max = 32, message = "产品型号长度必须介于 0 和 32 之间")
    public String getProModel() {
        return proModel;
    }

    public void setProModel(String proModel) {
        this.proModel = proModel;
    }

    public String getLeng() {
        return leng;
    }

    public void setLeng(String leng) {
        this.leng = leng;
    }

    public String getWide() {
        return wide;
    }

    public void setWide(String wide) {
        this.wide = wide;
    }

    @Length(min = 0, max = 32, message = "订单数量长度必须介于 0 和 32 之间")
    public String getCounts() {
        return counts;
    }

    public void setCounts(String counts) {
        this.counts = counts;
    }

    @Length(min = 0, max = 32, message = "出货数量必须是数字")
    public String getHasCounts() {
        return hasCounts;
    }

    public void setHasCounts(String hasCounts) {
        this.hasCounts = hasCounts;
    }

    @Length(min = 0, max = 32, message = "单价必须是数字")
    public String getPrice() { return price; }

    public void setPrice(String price) { this.price = price;}

    @Length(min = 0, max = 8, message = "面板类型长度必须介于 0 和 8 之间")
    public String getSideType() {
        return sideType;
    }

    public void setSideType(String sideType) {
        this.sideType = sideType;
    }

    @Length(min = 0, max = 8, message = "颜色加工类型长度必须介于 0 和 8 之间")
    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

}