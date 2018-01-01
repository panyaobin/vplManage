<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订单出货管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
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
		<li class="active"><a href="${ctx}/vpl/vplOrderDelivery/">订单出货列表</a></li>
		<shiro:hasPermission name="vpl:vplOrderDelivery:edit"><li><a href="${ctx}/vpl/vplOrderDelivery/form">订单出货添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="vplOrderDelivery" action="${ctx}/vpl/vplOrderDelivery/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th style="width:3em;text-align: center"><input type="checkbox" id="ids_"></th>
			<th style="width: 4em;text-align: center">序号</th>
			<th style="text-align: center">送货单号</th>
			<th style="text-align: center">客户型号</th>
			<th style="text-align: center">宽度</th>
			<th style="text-align: center">长度</th>
			<th style="text-align: center">订单数量</th>
			<th style="text-align: center">面&nbsp;积</th>
			<th style="text-align: center">客户名称</th>
			<th style="text-align: center">订单号</th>
			<th style="text-align: center">出货日期</th>
			<th style="text-align: center">类型</th>
			<th style="text-align: center">备&nbsp;注</th>
			<shiro:hasPermission name="tsy:tsyOrderDelivery:edit"><th style="text-align: center">操作</th></shiro:hasPermission>
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
						${tsyOrderDelivery.cusName}
				</td>
				<td style="text-align: center">
						${tsyOrderDelivery.orderId}
				</td>
				<td style="width: 8em;text-align: center">
					<fmt:formatDate value="${tsyOrderDelivery.deliveryDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="text-align: center">
					单面大面积
				</td>
				<td style="text-align: center">
						${tsyOrderDelivery.remarks}
				</td>
				<shiro:hasPermission name="tsy:tsyOrderDelivery:edit"><td style="text-align: center">
						<%--<a href="#">作废</a>--%>
					<a href="${ctx}/tsy/tsyOrderDelivery/delete?id=${tsyOrderDelivery.id}" onclick="return confirmx('确认要作废该出货单吗？', this.href)">作废</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>