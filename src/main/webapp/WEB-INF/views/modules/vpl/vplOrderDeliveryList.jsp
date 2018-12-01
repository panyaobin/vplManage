<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/vpl/vplOrderImport/form?id=${vplOrderImport.id}">订单<shiro:hasPermission
            name="vpl:vplOrderImport:edit">${not empty vplOrderImport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplOrderImport:edit">查看</shiro:lacksPermission></a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
    <li class="active"><a href="#">出货单</a></li>
    <li><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderDelivery/summary">小结</a></li>
</ul>
<form:form id="inputForm" modelAttribute="vplOrderDelivery"  action="${ctx}/vpl/vplOrderDelivery/printView" method="post"   class="form-horizontal">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <%--<div style="width: 37.5em;font: 3em bolder"><p style="margin-left: 6em">深圳市伟品利科技有限公司</p></div>
    <div style="text-align: center;width: 40em;margin-left: 16em"><p>地址:沙井街道蚝一岗头工业区大浦二路51号三楼</p>
        <p>手机15920080517&nbsp;&nbsp;&nbsp;传真：0755-23061295&nbsp;&nbsp;&nbsp;邮箱：VPLfpc@163.com</p>
    </div>--%>
    <br>
    <div style="text-align: center;margin-bottom:20px;width: 26em;font-size: 2.5em;font-weight:bolder "><span style="">送&nbsp;&nbsp;货&nbsp;&nbsp;单</span><br>
        </div>
    <div style="width: 50.5em; font: 18px bolder;margin-bottom: 0.5em">客户名称：<input type="text" style="width: 5em;border: none;margin-right: 41em" value="${_cusName}" name="cusName">NO:<input type="text" style="width: 7.5em;border: none" value="${_cusId}" name="deliveryId"></div>
    <sys:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 70em">
        <TR>
            <td style="text-align: center">序号</td>
            <td style="text-align: center">客户型号</td>
            <td style="text-align: center">长</td>
            <td style="text-align: center">宽</td>
            <td style="text-align: center">订单号</td>
            <td style="text-align: center">单位</td>
            <td style="text-align: center">数量</td>
            <td style="text-align: center">面积</td>
            <td style="text-align: center">类型</td>
            <td style="text-align: center">备注</td>
            <td style="text-align: center">库存</td>
        </TR>

        <tr>
            <c:if test="${orderDeList[0].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="1"></td>
            </c:if>
            <c:if test="${orderDeList[0].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[0].proModel}"  name="orderDeList[0].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[0].leng}"  name="orderDeList[0].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[0].wide}"  name="orderDeList[0].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[0].orderId}"  name="orderDeList[0].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[0].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[0].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts" required  type="number" name="orderDeList[0].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[0].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[0].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[0].sideType}" name="orderDeList[0].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[0].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">
            </td>


            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[0].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[0].price}" name="orderDeList[0].price">
                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[0].id}" name="orderDeList[0].id">

            <c:if test="${orderDeList[0].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[0].counts-orderDeList[0].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[0].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[1].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="2"></td>
            </c:if>
            <c:if test="${orderDeList[1].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[1].proModel}"  name="orderDeList[1].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[1].leng}"  name="orderDeList[1].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[1].wide}"  name="orderDeList[1].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[1].orderId}"  name="orderDeList[1].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[1].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[1].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[1].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[1].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[1].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[1].sideType}" name="orderDeList[1].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[1].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[1].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[1].price}" name="orderDeList[1].price">
                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[1].id}" name="orderDeList[1].id">

            <c:if test="${orderDeList[1].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[1].counts-orderDeList[1].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[1].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[2].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="3"></td>
            </c:if>
            <c:if test="${orderDeList[2].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[2].proModel}"  name="orderDeList[2].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[2].leng}"  name="orderDeList[2].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[2].wide}"  name="orderDeList[2].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[2].orderId}"  name="orderDeList[2].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[2].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[2].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[2].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[2].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[2].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[2].sideType}" name="orderDeList[2].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[2].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[2].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[2].price}" name="orderDeList[2].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[2].id}" name="orderDeList[2].id">

            <c:if test="${orderDeList[2].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[2].counts-orderDeList[2].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[2].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[3].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="4"></td>
            </c:if>
            <c:if test="${orderDeList[3].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[3].proModel}"  name="orderDeList[3].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[3].leng}"  name="orderDeList[3].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[3].wide}"  name="orderDeList[3].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[3].orderId}"  name="orderDeList[3].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[3].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[3].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[3].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[3].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[3].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[3].sideType}" name="orderDeList[3].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[3].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[3].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[3].price}" name="orderDeList[3].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[3].id}" name="orderDeList[3].id">

            <c:if test="${orderDeList[3].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[3].counts-orderDeList[3].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[3].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[4].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="5"></td>
            </c:if>
            <c:if test="${orderDeList[4].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[4].proModel}"  name="orderDeList[4].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[4].leng}"  name="orderDeList[4].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[4].wide}"  name="orderDeList[4].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[4].orderId}"  name="orderDeList[4].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[4].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[4].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[4].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[4].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[4].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[4].sideType}" name="orderDeList[4].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[4].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">
            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[4].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[4].price}" name="orderDeList[4].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[4].id}" name="orderDeList[4].id">

            <c:if test="${orderDeList[4].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[4].counts-orderDeList[4].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[4].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[5].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="6"></td>
            </c:if>
            <c:if test="${orderDeList[5].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[5].proModel}"  name="orderDeList[5].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[5].leng}"  name="orderDeList[5].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[5].wide}"  name="orderDeList[5].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[5].orderId}"  name="orderDeList[5].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[5].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[5].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[5].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[5].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[5].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[5].sideType}" name="orderDeList[5].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[5].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[5].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[5].price}" name="orderDeList[5].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[5].id}" name="orderDeList[5].id">

            <c:if test="${orderDeList[5].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[5].counts-orderDeList[5].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[5].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[6].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="7"></td>
            </c:if>
            <c:if test="${orderDeList[6].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[6].proModel}"  name="orderDeList[6].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[6].leng}"  name="orderDeList[6].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[6].wide}"  name="orderDeList[6].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[6].orderId}"  name="orderDeList[6].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[6].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[6].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[6].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[6].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[6].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[6].sideType}" name="orderDeList[6].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[6].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[6].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[6].price}" name="orderDeList[6].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[6].id}" name="orderDeList[6].id">

            <c:if test="${orderDeList[6].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[6].counts-orderDeList[6].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[6].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

        <tr>
            <c:if test="${orderDeList[7].proModel!=null}">
                <td style="text-align: center;width: 3em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value="8"></td>
            </c:if>
            <c:if test="${orderDeList[7].proModel==null}">
                <td style="text-align: center;width: 2em"><input type="text" style="width: 1.5em;text-align: center" readonly tabindex="-100" value=""></td>
            </c:if>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 9em"><input type="text" style="width: 7em;text-align: center" value="${orderDeList[7].proModel}"  name="orderDeList[7].proModel" readonly tabindex="-1"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[7].leng}"  name="orderDeList[7].leng" readonly tabindex="-2"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em;"><input type="text" style="width: 2.5em;text-align: center" value="${orderDeList[7].wide}"  name="orderDeList[7].wide" readonly tabindex="-3"></td>
            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 8em;"><input type="text" style="width: 6em;text-align: center" value="${orderDeList[7].orderId}"  name="orderDeList[7].orderId" readonly tabindex="-4"></td>

            <c:if test="${orderDeList[7].proModel!=null}">
                <td style="text-align: center;"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-100" value="PNL"></td>
            </c:if>
            <c:if test="${orderDeList[7].proModel==null}">
                <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 4em"><input type="text" style="width: 2em;text-align: center" readonly tabindex="-120" value=""></td>
            </c:if>

            <td style="text-align: center;width: 7em;padding: 0px 0px">
                <input class="_counts"   type="number" name="orderDeList[7].counts" style="width: 5em;text-align: center">
            </td>
            <c:if test="${orderDeList[7].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly  tabindex="-5"></td>
            </c:if>
            <c:if test="${orderDeList[7].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 7em"><input type="text" style="width: 5em;text-align: center" value="" readonly></td>
            </c:if>

            <td style="text-align: center;padding: 0px 0px;width: 7.5em">
                <input type="hidden" style="width: 5.5em;text-align: center" value="${orderDeList[7].sideType}" name="orderDeList[7].sideType" readonly  tabindex="-6">
                <input type="text" style="width: 5.5em;text-align: center" value="${fns:getDictLabel(orderDeList[7].sideType, 'vpl_side_type', '')}" name="" readonly  tabindex="-6">

            </td>

            <td style="text-align: center;margin: 0px 0px;padding: 0px 0px;width: 10em">
                <input type="text" style="width: 8em;text-align: center" name="orderDeList[7].remarks">
            </td>

                <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[7].price}" name="orderDeList[7].price">
            <input type="hidden" style="width: 8em;text-align: center" value="${orderDeList[7].id}" name="orderDeList[7].id">

            <c:if test="${orderDeList[7].proModel!=null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="${orderDeList[7].counts-orderDeList[7].hasCounts}" readonly tabindex="-101"></td>
            </c:if>
            <c:if test="${orderDeList[7].proModel==null}">
                <td style="text-align: center;padding: 0px 0px;margin: 0px 0px;width: 5em"  tabindex="-7"><input type="text" style="width: 3em;text-align: center" value="" readonly></td>
            </c:if>
        </tr>

    </table>
    <div style="width: 70em;height: 3.5em">
        <p style="float: left">送货单位<br>及经手人:${fns:getUser().name}</p>
        <p style="float: right;margin-right: 5em">收货单位<br>及经手人:</p>
    </div>
    <div style="width: 70em">
            <%--<input type="submit" class="btn btn-primary"  value="录入" style="border-radius: 20%;float: right;margin-right: 0.8em">--%>
            <%--<input  class="btn btn-primary" type="button" style="margin-left:54em" value="暂无"/>--%>
        <input  class="btn btn-primary" type="submit" id="_dePrint" style="margin-left: 59.2em"  value="打印出货"/>
    </div>
</form:form>
<%--<div class="pagination">${page}</div>--%>
</body>
<head>
    <title>送货单管理管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("._counts").eq(0).focus();

            //计算面积
            $("._counts").blur(function () {
                var co=parseInt($(this).val()); //出货数量
                var lco=parseInt($(this).parents().prev().prev().prev().prev().children("input").val());   //获取 长度
                var hco=parseInt($(this).parents().next().next().next().next().next().next().children("input").val()); //获取剩余库存数量
                if(co>hco){
                    showTip("超出库存,请核对出货数量！");
                    $("#_dePrint").attr("disabled",true);
                    $(this).focus();
                }else {
                    if(!isNaN(co)) {
                        if (!isNaN(lco)) {
                            $(this).parents().next().children("input").val((co * 250 * lco / 1000000).toFixed(3));   //获取 面积
                            $("#_dePrint").attr("disabled", false);
                        }else {
                            showTip("无产品信息！");
                            $("#_dePrint").attr("disabled", false);
                        }
                    }
                }
            });

            //送货日期显示系统当前时间
            var d = new Date();
            var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
            $("#_deDate").val(str);

            //打印功能
            /* $("#testD").click(function () {
                 window.print();
             });*/
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
</html>