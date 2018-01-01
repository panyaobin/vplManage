<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>客户管理管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#reset").click(function () {
                $("input[name='cusNo']").val("");
                $("input[name='cusName']").val("");
                //window.href="www.baidu.com";
            });
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
    <li><a href="${ctx}/vpl/vplOrderImport/form?id=${vplOrderImport.id}">订单<shiro:hasPermission
            name="vpl:vplOrderImport:edit">${not empty vplOrderImport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplOrderImport:edit">查看</shiro:lacksPermission></a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
    <li class="active"><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="vplCustomer" action="${ctx}/vpl/vplCustomer/" method="post"
           class="breadcrumb form-search"  style="width: 58.3%">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li>客户代码：<input type="text" name="cusNo" value="${vplCustomer.cusNo}" style="width: 50%"></li>
        <li>客户名称：<input type="text" name="cusName" value="${vplCustomer.cusName}" style="width: 50%"></li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="btns"><input id="reset" class="btn btn-primary" type="reset"  value="刷新"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed"  style="width: 60%">
    <thead>
    <tr>
        <th style="text-align: center;width: 5%">序号</th>
        <th style="text-align: center;width: 10%">客户代码</th>
        <th style="text-align: center;width: 10%">客户名称</th>
        <%--<c:forEach items="${dictList}" var="type">
            <th>${type.label}</th>
        </c:forEach>--%>
        <th style="text-align: center;width: 10%">备注</th>
        <shiro:hasPermission name="vpl:vplCustomer:edit">
            <th style="text-align: center;width: 10%">操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>

    <c:if test="${page.list==null || page.list.size()<=0}">
        <tr>
            <td colspan="5" style="text-align: center">对不起，没有数据……</td>
        </tr>
    </c:if>

    <c:forEach items="${page.list}" var="vplCustomer" varStatus="vc">
        <tr>
            <td style="text-align: center">
                    ${vc.count}
            </td>
            <td style="text-align: center">
                    ${vplCustomer.cusNo}
            </td>
            <td style="text-align: center">
                    ${vplCustomer.cusName}
            </td>
                <%-- <td>
                         ${vplCustomer.typeId}
                         &lt;%&ndash;${fns:getDictLabel(vplCustomer.typeId,"vpl_side_type" ,"")}&ndash;%&gt;
                 </td>--%>


            <%--<c:forEach items="${page.list}" var="list">
                <td>
                        ${list.price}
                </td>
            </c:forEach>--%>
            <td style="text-align: center">
                    ${vplCustomer.remarks}
            </td>
            <shiro:hasPermission name="vpl:vplCustomer:edit">
                <td style="text-align: center">
                    <a href="${ctx}/vpl/vplCustomer/form?cusNo=${vplCustomer.cusNo}">修改</a>
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