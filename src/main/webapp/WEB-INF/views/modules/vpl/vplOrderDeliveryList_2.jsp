<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>订单录入管理</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        $(document).ready(function() {
            /*
             * 全选和反选
             */
            $("input[type='checkbox'][id='ids_']").bind("click",function(){
                if ($(this).attr("checked")=='checked') {
                    $("input[id^='id_']").attr("checked", true);
                } else {
                    $("input[id^='id_']").attr("checked", false);
                }
            });

            /**
             * 批量删除
             */
            $("#batchDel").bind("click",function(){
                var ids = getAllCheckId();
                if(ids !="" && ids != null){
                    $.ajax({
                        type: 'post',
                        url: "${ctx}/tsy/tsyOrderDelivery/deleteBth",
                        data: {ids:ids} ,
                        success: function(data){
                            location.href="${ctx}/tsy/tsyOrderDelivery";
                        }
                    });
                }else{
                    alert('请选择需要批量处理的数据！');
                }
            });
            //重置按钮刷新页面
            $("#reset").click(function(){
                $("#c").val("");
                $("#start").val("");
                $("#end").val("");
                location.href="${ctx}/vpl/vplOrderDelivery";
            });

            $("#print").click(function () {
                var a=$("#start").val();
                var b=$("#end").val();
                var c=$("#c").val();
                location.href="${ctx}/vpl/vplOrderDelivery/deliveryPrint?fileName='出货单'&cusName="+c+"&deliveryStartDate="+a+"&deliveryEndDate="+b+"";
            });
        });


        /**
         * 该方法用于获取所有已经选中的ID
         */
        function getAllCheckId() {
            var ids = "";
            $("input[id^='id_']:checked").each(function () {
                ids += $(this).val() + ",";
            });
            return ids;
        }
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/vpl/vplOrderImport/form?id=${vplOrderImport.id}">订单<shiro:hasPermission
            name="vpl:vplOrderImport:edit">${not empty vplOrderImport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplOrderImport:edit">查看</shiro:lacksPermission></a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
    <li class="active"><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="vplOrderDelivery" action="${ctx}/vpl/vplOrderDelivery" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
            <%--<li>订单编号：<input id="a" class="" name="orderId" value="${tsyOrderDelivery.orderId}" style="width: 7em;" type="text" placeholder="订单编号"/>&nbsp;&nbsp;&nbsp;</li>
            <li>客户型号：<input id="b" class="" name="proModel" value="${tsyOrderDelivery.proModel}" style="width: 7em;" type="text" placeholder="客户型号"/>&nbsp;&nbsp;&nbsp;</li>--%>
        <li>客户名称：<input id="c" class="" name="cusName" value="${vplOrderDelivery.cusName}" style="width: 7em;" type="text" placeholder="客户名称"/>&nbsp;&nbsp;&nbsp;</li>
        <li>下单日期：
            <input name="startDate"  placeholder="送货日期" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                   value="<fmt:formatDate value="${vplOrderDelivery.startDate}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
            -
            <input name="endDate"  placeholder="送货日期" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                   value="<fmt:formatDate value="${vplOrderDelivery.endDate}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="btns"><input id="reset" class="btn btn-primary" type="button" value="重置"/></li>
        <li class="btns"><input id="print" class="btn btn-primary" type="button" value="导出数据"/></li>
            <%--<li class="btns"><a href="${ctx}/tsy/tsyOrderDelivery/deliveryPrint?fileName='出货单'" class="btn btn-primary">导出数据</a></li>--%>

            <%--<li class="btns"><input id="batchDel" class="btn btn-primary" type="button" value="批量删除"/></li>--%>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th style="width:3em;text-align: center"><input type="checkbox" id="ids_"></th>
        <th style="width: 4em;text-align: center">序号</th>
        <th style="text-align: center">客户名称</th>
        <th style="text-align: center">送货单号</th>
        <th style="text-align: center">客户型号</th>
        <th style="text-align: center">宽度</th>
        <th style="text-align: center">长度</th>
        <th style="text-align: center">订单数量</th>
        <th style="text-align: center">面&nbsp;积</th>
        <th style="text-align: center">订单号</th>
        <th style="text-align: center">出货日期</th>
        <th style="text-align: center">类型</th>
        <th style="text-align: center">备&nbsp;注</th>
        <shiro:hasPermission name="vpl:vplOrderDelivery:edit"><th style="text-align: center">操作</th></shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:if test="${page.list==null || page.list.size()<=0}">
        <tr>
            <td colspan="13" style="text-align: center">对不起，没有数据……</td>
        </tr>
    </c:if>
    <c:forEach items="${page.list}" var="tsyOrderDelivery" varStatus="cc">
        <tr style="">
            <td style="text-align: center">
                <input type="checkbox" id="id_${customsIntro.id}" value="${tsyOrderDelivery.id}"/>
            </td>
            <td style="text-align: center">
                    ${cc.count}
            </td>
            <td style="text-align: center">
                    ${tsyOrderDelivery.cusName}
            </td>
            <td style="text-align: center">
                <a href="${ctx}/tsy/tsyOrderDelivery/form?id=${tsyOrderDelivery.id}">${tsyOrderDelivery.deliveryId}</a>
            </td>

            <td style="text-align: center">
                    ${tsyOrderDelivery.proModel}
            </td>
            <td style="text-align: center">
                    ${tsyOrderDelivery.wide}
            </td>
            <td style="text-align: center">
                    ${tsyOrderDelivery.leng}
            </td>
            <td style="text-align: center">
                    ${tsyOrderDelivery.counts}
            </td>
            <td style="text-align: center">
                <fmt:formatNumber type="number" value="${tsyOrderDelivery.wide*tsyOrderDelivery.leng*tsyOrderDelivery.counts/1000000}" pattern="0.000" maxFractionDigits="3"/>
            </td>

            <td style="text-align: center">
                    ${tsyOrderDelivery.orderId}
            </td>
            <td style="width: 8em;text-align: center">
                <fmt:formatDate value="${tsyOrderDelivery.deliveryDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td style="text-align: center">
                ${tsyOrderDelivery.sideType}
            </td>
            <td style="text-align: center">
                    ${tsyOrderDelivery.remarks}
            </td>
            <shiro:hasPermission name="vpl:vplOrderDelivery:edit"><td style="text-align: center">
                    <%--<a href="#">作废</a>--%>
                            ${tsyOrderDelivery.id}
                <a href="${ctx}/vpl/vplOrderDelivery/delete?id=${tsyOrderDelivery.id}" onclick="return confirmx('确认要作废该出货单吗？', this.href)">作废</a>
            </td></shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>

</html>