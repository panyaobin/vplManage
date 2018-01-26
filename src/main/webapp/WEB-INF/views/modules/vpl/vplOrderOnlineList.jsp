<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单入库表管理</title>
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
             * 生成出货单
             */
            $("#orderDelivery").bind("click",function(){
                debugger;
                var ids = getAllCheckId();
                if(ids.length/2<=8){
                    if(ids !="" && ids != null){
                        location.href= "${ctx}/vpl/vplOrderDelivery/orderDelivery?ids="+ids+"";
                    }else{
                        layer.msg("请选择需要生成出货单的数据！");
                    }
                }else {
                    layer.msg("出货条数不得大于8条!");
                }
            });

		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
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
	</script>

</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="vpl:vplOrderImport:edit"><li><a href="${ctx}/vpl/vplOrderImport/form">订单添加</a></li></shiro:hasPermission>
		<li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
		<li class="active"><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
		<li><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
		<li><a href="${ctx}/vpl/vplOrderDelivery/summary">小结</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="vplOrderImport" action="${ctx}/vpl/vplOrderImport/list?remarks=online" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>客户代码：<input type="text" name="cusName" value="${vplOrderImport.cusName}" style="width: 50%"></li>
			<li>订单编号：<input type="text" name="orderId" value="${vplOrderImport.orderId}" style="width: 50%"></li>
			<li>产品型号：<input type="text" name="proModel" value="${vplOrderImport.proModel}" style="width: 50%"></li>
			<li>下单日期：
				<input name="orderDateS" id="d" placeholder="下单日期" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${tsyOrderImport.orderDate}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="orderDelivery" class="btn btn-primary" type="button" value="生成出货单"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width:3em;text-align: center"><input type="checkbox" id="ids_"></th>
				<th style="width: 4em;text-align: center">序号</th>
				<th style="text-align: center">客户代码</th>
				<th style="text-align: center">客户名称</th>
				<th style="text-align: center">订单编号</th>
				<th style="text-align: center">客户型号</th>
				<th style="text-align: center">宽度</th>
				<th style="text-align: center">长度</th>
				<th style="text-align: center">在线数量</th>
				<th style="text-align: center">面&nbsp;积</th>
				<th style="text-align: center">类&nbsp;型</th>
				<th style="text-align: center">颜&nbsp;色</th>
				<th style="text-align: center">下单日期</th>
				<th style="text-align: center">备&nbsp;注</th>
			</tr>
		</thead>
		<tbody>
		<c:if test="${page.list==null || page.list.size()<=0}">
			<tr>
				<td colspan="14" style="text-align: center">对不起，没有数据……</td>
			</tr>
		</c:if>
		<c:forEach items="${page.list}" var="vplOrderImport" varStatus="index">
			<tr>
				<td style="text-align: center">
					<input type="checkbox" id="id_${vplOrderImport.id}" value="${vplOrderImport.id}"/>
				</td>
				<td style="text-align: center">${index.count}</td>

				<c:forEach items="${page_cus.list}" var="pc">
					<c:if test="${pc.cusNo == vplOrderImport.cusName}">
						<td style="text-align: center">${pc.cusNo}</td>
						<td style="text-align: center">${pc.cusName}</td>
					</c:if>
				</c:forEach>

				<td style="text-align: center">${vplOrderImport.orderId}</td>
				<td style="text-align: center">${vplOrderImport.proModel}</td>
				<td style="text-align: center">${vplOrderImport.wide}</td>
				<td style="text-align: center">${vplOrderImport.leng}</td>
				<td style="text-align: center">${vplOrderImport.counts-vplOrderImport.hasCounts}</td>
				<td style="text-align: center">
					<fmt:formatNumber type="number" value="${vplOrderImport.wide*vplOrderImport.leng*vplOrderImport.counts/1000000}" pattern="0.000" maxFractionDigits="3"/>
				</td>
				<td style="text-align: center">${fns:getDictLabel(vplOrderImport.sideType, 'vpl_side_type', '')}</td>
				<td style="text-align: center">${fns:getDictLabel(vplOrderImport.workType, 'vpl_work_type', '')}</td>
				<td style="text-align: center">
					<fmt:formatDate value="${vplOrderImport.orderDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="text-align: center">
					${vplOrderImport.remarks}
				</td>

			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>