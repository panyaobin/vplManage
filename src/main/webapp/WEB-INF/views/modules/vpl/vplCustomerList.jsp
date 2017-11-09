<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>客户管理管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/vpl/vplCustomer/">客户管理列表</a></li>
    <shiro:hasPermission name="vpl:vplCustomer:edit">
        <li><a href="${ctx}/vpl/vplCustomer/form">客户管理添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="vplCustomer" action="${ctx}/vpl/vplCustomer/" method="post"
           class="breadcrumb form-search">
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
        <th>序号</th>
        <th>客户编号</th>
        <th>客户名称</th>
        <th>加工类型</th>
        <th>价格</th>
        <th>备注</th>
        <shiro:hasPermission name="vpl:vplCustomer:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="vplCustomer" varStatus="vc">
        <tr>
            <td>
                    ${vc.count}
            </td>
            <td>
                    ${vplCustomer.cusNo}
            </td>
            <td>
                    ${vplCustomer.cusName}
            </td>
            <td>
                    ${fns:getDictLabel(vplCustomer.typeId,"vpl_side_type" ,"")}
            </td>
            <td>
                    ${vplCustomer.price}
            </td>
            <td>
                    ${vplCustomer.remarks}
            </td>
            <shiro:hasPermission name="vpl:vplCustomer:edit">
                <td>
                    <a href="${ctx}/vpl/vplCustomer/form?id=${vplCustomer.id}">修改</a>
                    <a href="${ctx}/vpl/vplCustomer/delete?id=${vplCustomer.id}"
                       onclick="return confirmx('确认要删除该客户管理吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>