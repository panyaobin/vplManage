/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.vpl.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.utils.excel.ExcelFactory;
import com.thinkgem.jeesite.common.utils.utils.excel.XSSFExcel;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import com.thinkgem.jeesite.modules.vpl.entity.*;
import com.thinkgem.jeesite.modules.vpl.service.VplCustomerService;
import com.thinkgem.jeesite.modules.vpl.service.VplOrderImportService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.vpl.service.VplOrderDeliveryService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 订单出货Controller
 *
 * @author popo
 * @version 2018-01-01
 */
@Controller
@RequestMapping(value = "${adminPath}/vpl/vplOrderDelivery")
public class VplOrderDeliveryController extends BaseController {

    @Autowired
    private VplOrderImportService vplOrderImportService;

    @Autowired
    private VplOrderDeliveryService vplOrderDeliveryService;

    @Autowired
    private VplCustomerService vplCustomerService;

    @Autowired
    private DictService dictService;

    @ModelAttribute
    public VplOrderDelivery get(@RequestParam(required = false) String id) {
        VplOrderDelivery entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = vplOrderDeliveryService.get(id);
        }
        if (entity == null) {
            entity = new VplOrderDelivery();
        }
        return entity;
    }

    @RequiresPermissions("vpl:vplOrderDelivery:view")
    @RequestMapping(value = {"list", ""})
    public String list(VplOrderDelivery vplOrderDelivery, String startDateStr, String endDateStr, HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
        if (StringUtils.isNotBlank(startDateStr)) {
            vplOrderDelivery.setStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr));
        }
        if (StringUtils.isNotBlank(endDateStr)) {
            vplOrderDelivery.setEndDate(new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr));
        }
        Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
        model.addAttribute("page", page);
        return "modules/vpl/vplOrderDeliveryList_2";
    }

    @RequiresPermissions("vpl:vplOrderDelivery:view")
    @RequestMapping(value = "form")
    public String form(VplOrderDelivery vplOrderDelivery, Model model) {
        model.addAttribute("vplOrderDelivery", vplOrderDelivery);
        return "modules/vpl/vplOrderDeliveryForm";
    }

    @RequiresPermissions("vpl:vplOrderDelivery:view")
    @RequestMapping(value = "summary")
    public String summary(VplOrderImport vplOrderImport, HttpServletRequest request, HttpServletResponse response, Model model) {
        //查询在线产品面积
        vplOrderImport.setRemarks("online");
        Page<VplOrderImport> p = vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), vplOrderImport);
        Double onlineCount = 0.000;
        if (null!=p&&null!=p.getList()&&p.getList().size()>0){
            List<VplOrderImport> t=p.getList();
            for (int i = 0; i <t.size() ; i++) {
                Double leng= Double.parseDouble(t.get(i).getLeng());
                Double wide= Double.parseDouble(t.get(i).getWide());
                Double counts= Double.parseDouble(t.get(i).getCounts());
                Double hCounts= Double.parseDouble(t.get(i).getHasCounts());
                Double c=counts-hCounts;
                Double d=leng*wide*c/1000000;
                onlineCount+=d;
            }
        }
        model.addAttribute("onlineCount",onlineCount); //在线产品面积

        //当日出货
        VplOrderDelivery vplOrderDelivery = new VplOrderDelivery();
        vplOrderDelivery.setStartDateStr(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        vplOrderDelivery.setEndDateStr(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
        Double dayDeliCount = 0.000;
        if (null!=page&&page.getList().size()>0){
            for (int i = 0; i <page.getList().size() ; i++) {
                Double leng= Double.parseDouble(page.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page.getList().get(i).getWide());
                Double counts= Double.parseDouble(page.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                dayDeliCount+=d;
            }
        }
        model.addAttribute("dayDeliCount",dayDeliCount); //当日出货产品面积

        //当日下单
        VplOrderImport tsyOrderImport1 = new VplOrderImport();
        tsyOrderImport1.setOrderDateStr(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        Page<VplOrderImport> page1= vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), tsyOrderImport1);
        Double dayImpCount = 0.000;
        if (null!=page1&&page1.getList().size()>0){
            for (int i = 0; i <page1.getList().size() ; i++) {
                Double leng= Double.parseDouble(page1.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page1.getList().get(i).getWide());
                Double counts= Double.parseDouble(page1.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                dayImpCount+=d;
            }
        }
        model.addAttribute("dayImpCount",dayImpCount); //当日下单产品面积

        //昨天出货
        VplOrderDelivery vplOrderDelivery2 = new VplOrderDelivery();
        Calendar   cal   =   Calendar.getInstance();
        cal.add(Calendar.DATE,   -1);
        String yesterday = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        vplOrderDelivery2.setStartDateStr(yesterday);
        vplOrderDelivery2.setEndDateStr(yesterday);
        Page<VplOrderDelivery> page2 = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery2);
        Double yesDeliCount = 0.000;
        if (null!=page2&&page2.getList().size()>0){
            for (int i = 0; i <page2.getList().size() ; i++) {
                Double leng= Double.parseDouble(page2.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page2.getList().get(i).getWide());
                Double counts= Double.parseDouble(page2.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                yesDeliCount+=d;
            }
        }
        model.addAttribute("yesDeliCount",yesDeliCount); //昨天出货产品面积

        //昨天下单
        VplOrderImport tsyOrderImport3 = new VplOrderImport();
        Calendar   cal1   =   Calendar.getInstance();
        cal1.add(Calendar.DATE,   -1);
        String yesterday1 = new SimpleDateFormat( "yyyy-MM-dd ").format(cal.getTime());
        tsyOrderImport3.setOrderDateStr(yesterday1);
        tsyOrderImport3.setOrderDateEtr(yesterday1);
        Page<VplOrderImport> page3= vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), tsyOrderImport3);
        Double dayDeLiCount = 0.00;
        if (null!=page3&&page3.getList().size()>0){
            for (int i = 0; i <page3.getList().size() ; i++) {
                Double leng= Double.parseDouble(page3.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page3.getList().get(i).getWide());
                Double counts= Double.parseDouble(page3.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                dayDeLiCount+=d;
            }
        }
        model.addAttribute("dayDeLiCount",dayDeLiCount); //昨天下单产品面积


        //当月出货
        VplOrderDelivery vplOrderDelivery4 = new VplOrderDelivery();

        //获取前月的第一天
        String firstDay;
        String lastDay;
        Calendar   cal_1=Calendar.getInstance();//获取当前日期
        cal_1.add(Calendar.MONTH, 0);
        cal_1.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天
        firstDay = new SimpleDateFormat("yyyy-MM-dd").format(cal_1.getTime());
        //获取前月的最后一天
        Calendar cale = Calendar.getInstance();
        cale.set(Calendar.DAY_OF_MONTH,cale.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为1号,当前日期既为本月第一天
        lastDay =new SimpleDateFormat("yyyy-MM-dd").format(cale.getTime());


        vplOrderDelivery4.setStartDateStr(firstDay);
        vplOrderDelivery4.setEndDateStr(lastDay);
        Page<VplOrderDelivery> page4 = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery4);
        Double monthDeliCount = 0.000;
        if (null!=page4&&page4.getList().size()>0){
            for (int i = 0; i <page4.getList().size() ; i++) {
                Double leng= Double.parseDouble(page4.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page4.getList().get(i).getWide());
                Double counts= Double.parseDouble(page4.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                monthDeliCount+=d;
            }
        }
        model.addAttribute("monthDeliCount",new BigDecimal(monthDeliCount).setScale(2, RoundingMode.HALF_UP)); //当月出货产品面积


        //当月下单
        VplOrderImport tsyOrderImport4 = new VplOrderImport();
        //获取前月的第一天
        String firstDay1;
        String lastDay1;
        Calendar   cal_11=Calendar.getInstance();//获取当前日期
        cal_11.add(Calendar.MONTH, 0);
        cal_11.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天
        firstDay1 = new SimpleDateFormat("yyyy-MM-dd").format(cal_1.getTime());
        //获取前月的最后一天
        Calendar cale1 = Calendar.getInstance();
        cale1.set(Calendar.DAY_OF_MONTH,cale1.getActualMaximum(Calendar.DAY_OF_MONTH));//设置为1号,当前日期既为本月第一天
        lastDay1 =new SimpleDateFormat("yyyy-MM-dd").format(cale1.getTime());
        tsyOrderImport4.setOrderDateStr(firstDay1);
        tsyOrderImport4.setOrderDateEtr(lastDay1);
        Page<VplOrderImport> page5= vplOrderImportService.findPage(new Page<VplOrderImport>(request, response),
                tsyOrderImport4);
        Double monDeLiCount = 0.00;
        if (null!=page5&&page5.getList().size()>0){
            for (int i = 0; i <page5.getList().size() ; i++) {
                Double leng= Double.parseDouble(page5.getList().get(i).getLeng());
                Double wide= Double.parseDouble(page5.getList().get(i).getWide());
                Double counts= Double.parseDouble(page5.getList().get(i).getCounts());
                Double d=leng*wide*counts/1000000;
                monDeLiCount+=d;
            }
        }
        model.addAttribute("monDeLiCount",monDeLiCount); //当月下单产品面积

        return "modules/vpl/vplSummary";
    }

    @RequiresPermissions("vpl:vplOrderDelivery:edit")
    @RequestMapping(value = "save")
    public String save(VplOrderDelivery vplOrderDelivery, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, vplOrderDelivery)) {
            return form(vplOrderDelivery, model);
        }
        vplOrderDeliveryService.save(vplOrderDelivery);
        addMessage(redirectAttributes, "保存订单出货成功");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplOrderDelivery/?repage";
    }

    @RequiresPermissions("vpl:vplOrderDelivery:edit")
    @RequestMapping(value = "delete")
    public String delete(VplOrderDelivery vplOrderDelivery, RedirectAttributes redirectAttributes) {
        String counts = vplOrderDeliveryService.get(vplOrderDelivery.getId()).getCounts();
        String proModel = vplOrderDeliveryService.get(vplOrderDelivery.getId()).getProModel();
        String orderId = vplOrderDeliveryService.get(vplOrderDelivery.getId()).getOrderId();
        VplOrderImport vplOrderImport = vplOrderImportService.findListByProModel(proModel, orderId);
        vplOrderImport.setHasCounts(String.valueOf((Integer.parseInt(vplOrderImport.getHasCounts())) - (Integer.parseInt(counts))));
        vplOrderImportService.save(vplOrderImport);
        vplOrderDeliveryService.delete(vplOrderDelivery);
        addMessage(redirectAttributes, "送货单成功成功作废！");
        return "redirect:" + Global.getAdminPath() + "/vpl/vplOrderDelivery/?repage";
    }

    /**
     * 批量出货，根据出货单号录入出货信息，同时修改订单的出货数量
     *
     * @param ids                批量出货的 id
     * @param redirectAttributes 全局页面提示语
     * @param model
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "orderDelivery")
    public String orderDelivery(String ids, RedirectAttributes redirectAttributes, Model model, HttpServletRequest request, HttpServletResponse response) {
        List<VplOrderImport> list = new ArrayList<VplOrderImport>();
        if (null != ids && ids.length() != 0) {
            String[] arr = ids.split(",");
            for (int i = 0; i < arr.length; i++) {
                VplOrderImport vplOrderImport = new VplOrderImport();
                vplOrderImport = vplOrderImportService.get(arr[i]);
                list.add(vplOrderImport);
            }

            VplCustomer vplCustomer = new VplCustomer();
            vplCustomer.setCusNo(vplOrderImportService.get(arr[0]).getCusName());
            Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
            model.addAttribute("_cusName",page.getList().get(0).getCusName());
            //每次查询出
            VplOrderDelivery vplOrderDelivery = new VplOrderDelivery();

            System.out.println(vplOrderImportService.get(arr[0]).getCusName() + "-----------------------------------");

            vplOrderDelivery.setCusName(page.getList().get(0).getCusName());
            Page<VplOrderDelivery> page2 = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
            if (page2.getList().size() > 0) {
                int id = Integer.parseInt(page2.getList().get(0).getDeliveryId());
                model.addAttribute("_cusId", id + 1);
            } else {
                System.out.println(list.get(0).getCusName());
                model.addAttribute("_cusId", Integer.valueOf(list.get(0).getCusName()) * 100000 + 1);
            }

        }
        model.addAttribute("orderDeList", list);
        return "modules/vpl/vplOrderDeliveryList";
    }

    /**
     * 打印功能，跳转页面打印预览
     *
     * @param orderDeList
     * @param vplOrderDelivery
     * @param request
     * @param response
     * @param model
     * @return
     * @throws SQLException
     */
    @RequestMapping(value = "printView")
    public String printView(VplOrderDeliveryList orderDeList, VplOrderDelivery vplOrderDelivery, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, Model model) throws SQLException {
        for (int i = 0; i < orderDeList.getOrderDeList().size(); i++) {
            if (StringUtils.isNotBlank(orderDeList.getOrderDeList().get(i).getProModel())) {
                //在线产品录入送货单列表
                VplOrderDelivery vpl = new VplOrderDelivery();
                vpl.setDeliveryId(vplOrderDelivery.getDeliveryId());
                vpl.setProModel(orderDeList.getOrderDeList().get(i).getProModel());
                vpl.setLeng(orderDeList.getOrderDeList().get(i).getLeng());
                vpl.setWide(orderDeList.getOrderDeList().get(i).getWide());
                vpl.setCounts(orderDeList.getOrderDeList().get(i).getCounts());
                vpl.setPrice(orderDeList.getOrderDeList().get(i).getPrice());

                //这里需要根据 类型ID 和客户名称查询出对应的报价
                VplCustomer vplCustomer = new VplCustomer();
                vplCustomer.setCusName(vplOrderDelivery.getCusName());
                vplCustomer.setTypeId(orderDeList.getOrderDeList().get(i).getSideType());
                Page<VplCustomer> page = vplCustomerService.findPage(new Page<VplCustomer>(request, response), vplCustomer);
                vpl.setPrice(page.getList().get(0).getPrice());

                //这里根据 sidetypeid查询加工类型
                Dict dict = new Dict();
                dict.setType("vpl_side_type");
                dict.setValue(orderDeList.getOrderDeList().get(i).getSideType());
                Page<Dict> dictp =dictService.findPage(new Page<Dict>(request, response), dict);
                vpl.setSideType(dictp.getList().get(0).getLabel());

                //这里新增颜色参数，进入出货单
                vpl.setWorkType(orderDeList.getOrderDeList().get(i).getWorkType());
                vpl.setCusName(vplOrderDelivery.getCusName());
                vpl.setDeliveryDate(vplOrderDelivery.getDeliveryDate());
                vpl.setOrderId(orderDeList.getOrderDeList().get(i).getOrderId());
                vpl.setRemarks(orderDeList.getOrderDeList().get(i).getRemarks());
                vpl.setDeliveryDate(new Date());
                vplOrderDeliveryService.save(vpl);
                addMessage(redirectAttributes, "送货单录入成功");

                //出货单提交之后，修改订单中 出货数量
                //通过每条数据的订单号和客户型号，查找到对应的订单号，从而修改数量
				/*VplOrderImport tsyim=new VplOrderImport();
				tsyim.setProModel(orderDeList.getOrderDeList().get(i).getProModel());
				tsyim.setOrderId(orderDeList.getOrderDeList().get(i).getOrderId());
				Page<VplOrderImport> page = vplOrderImportService.findPage(new Page<VplOrderImport>(request, response), tsyim);*/

                //通过订单号和产品型号查询出该订单已出货数量
                //传入已经出货数量，累计修改已出货数量
                VplOrderImport tsyim1 = vplOrderImportService.findListByProModel(orderDeList.getOrderDeList().get(i).getProModel(), orderDeList.getOrderDeList().get(i).getOrderId());
                model.addAttribute("date", new Date());
                tsyim1.setHasCounts(String.valueOf(Integer.parseInt(tsyim1.getHasCounts()) + Integer.parseInt(orderDeList.getOrderDeList().get(i).getCounts())));
                vplOrderImportService.save(tsyim1);
            }
        }
        model.addAttribute("orderDelList", orderDeList.getOrderDeList());
        System.out.println(orderDeList.getClass() + "-----------------------");
        model.addAttribute("tsyOrderDelivery", vplOrderDelivery);
        Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
        model.addAttribute("page", page);
		/*if (tsyOrderDelivery.getCusName().equals("凯强")){
			return "modules/tsy/tsyPrintView_tsy";
		}*/
        return "modules/vpl/vplPrintView";
    }

    /**
     * 这里是导出订单出货列表，根据条件筛选
     *
     * @param vplOrderDelivery
     * @param redirectAttributes
     * @param request
     * @param response
     * @param model
     * @param fileName
     * @param
     * @return
     * @throws SQLException
     */
    @RequestMapping(value = "deliveryPrint")
    public String deliveryPrint(VplOrderDelivery vplOrderDelivery, String startDateStr, String endDateStr, RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response, Model model, String fileName) throws SQLException, ParseException {
        System.out.println("这里是导出数据--------------------------");
        response.setContentType("application/vnd.ms-excel"); // 告知类型为excel文件
        response.setCharacterEncoding("utf-8");
        try {
            response.setHeader("Content-disposition", "attachment;filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1") + ".xlsx");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if (StringUtils.isNotBlank(startDateStr)) {
            vplOrderDelivery.setStartDate(new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr));
        }
        if (StringUtils.isNotBlank(endDateStr)) {
            vplOrderDelivery.setEndDate(new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr));
        }

        Page<VplOrderDelivery> page = vplOrderDeliveryService.findPage(new Page<VplOrderDelivery>(request, response), vplOrderDelivery);
        List<VplOrderDelivery> list = page.getList();
        if (null != list && list.size() > 0) {
            String[] titles = {"序号", "送货日期", "送货单号", "客户型号", "客户名称", "宽", "长", "订单号", "单价", "送货数量", "单位", "出货平米", "金额", "类型", "备注"}; // 标题
            List<Map<String, Object>> datas = new ArrayList<>();
            for (int i = 0; i <list.size(); i++) {
                if (StringUtils.isNotBlank(list.get(i).getProModel())) {
                    Map<String, Object> data = new LinkedHashMap<>();
                    data.put("a", String.valueOf(i + 1));
                    data.put("b", new SimpleDateFormat("yyyy-MM-dd").format(list.get(i).getDeliveryDate()));
                    data.put("b1", list.get(i).getDeliveryId());
                    data.put("c", list.get(i).getProModel());
                    data.put("c1", list.get(i).getCusName());
                    data.put("d",Double.valueOf(list.get(i).getWide()));
                    data.put("e", Double.valueOf(list.get(i).getLeng()));
                    data.put("f", list.get(i).getOrderId());
                    data.put("g", Double.valueOf(list.get(i).getPrice()));
                    data.put("h", Double.valueOf(list.get(i).getCounts()));
                    data.put("i", "PNL");

                    //计算面积 长*宽*数量
                    double q = Double.parseDouble(list.get(i).getLeng());
                    double w = Double.parseDouble(list.get(i).getCounts());
                    double qq = w * q * 250 / 1000000;
                    data.put("j", new BigDecimal(qq).setScale(3, RoundingMode.HALF_UP));

                    //计算金额 面积*单价
                    double price = Double.parseDouble(list.get(i).getPrice());
                    data.put("k", new BigDecimal(qq*price).setScale(2, RoundingMode.HALF_UP));

                   // data.put("k", "面积");
                    data.put("l", list.get(i).getSideType());
                    data.put("m", list.get(i).getRemarks());
                    datas.add(data);
                }
            }
            Object[] keys = {"a", "b", "b1", "c", "c1", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"};
            XSSFExcel excel = (XSSFExcel) ExcelFactory.createExcel(3, titles, datas, keys);
            try {
                excel.export(response.getOutputStream());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return "modules/vpl/vplOrderDeliveryList_2";
    }
}