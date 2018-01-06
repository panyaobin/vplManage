<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>小结</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {

        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/vpl/vplOrderImport/form?id=${vplOrderImport.id}">订单<shiro:hasPermission
            name="vpl:vplOrderImport:edit">${not empty vplOrderImport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplOrderImport:edit">查看</shiro:lacksPermission></a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
    <li><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
    <li class="active"><a href="${ctx}/vpl/vplOrderDelivery/summary">小结</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="vplOrderImport" action="${ctx}/vpl/vplOrderImport/save" method="post"
           class="form-horizontal">
    <sys:message content="${message}"/>

    <table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80em">
        <p style="text-align: center;font: 2em bolder;width: 40em">小    结</p>
        <thead>
        <tr>
            <td style="font-weight: bolder">日订单汇总（单位：平米）</td>
        </tr>
        <tr>
            <td  style="text-align: center;width: 20em">在线结存</td>
            <td colspan="3"  style="text-align: center">
                <c:if test="${onlineCount==0}">0</c:if>
                <c:if test="${onlineCount!=0}">
                    <fmt:formatNumber value="${onlineCount}" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
                </c:if>
            </td>
        </tr>
        <tr>
            <td style="text-align: center">当日出货</td>
            <td style="text-align: center">
                <c:if test="${dayDeliCount==0}">0</c:if>
                <c:if test="${dayDeliCount!=0}">
                    <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
                </c:if>
            </td>
            <td style="text-align: center">当日下单</td>
            <td style="text-align: center">
                <c:if test="${dayImpCount==0}">0</c:if>
                <c:if test="${dayImpCount!=0}">
                    <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
                </c:if>

            </td>
        </tr>
        <tr>
            <td style="text-align: center">上日出货</td>
            <td style="text-align: center">
                <c:if test="${yesDeliCount==0}">0</c:if>
                <c:if test="${yesDeliCount!=0}">
                    <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
                </c:if>
            </td>
            <td style="text-align: center">上日下单</td>
            <td style="text-align: center">
                <c:if test="${dayDeLiCount==0}">0</c:if>
                <c:if test="${dayDeLiCount!=0}">
                    <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
                </c:if>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="font-weight: bolder">当月订单汇总（单位：平米）</td>
        </tr>
        <tr>
            <td style="text-align: center">项目</td>
            <td style="text-align: center">客户</td>
            <td style="text-align: center">出货</td>
            <td style="text-align: center">下单</td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">合计</td>
            <td style="text-align: center">
                <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
            </td>
            <td style="text-align: center">
                <fmt:formatNumber value="0" pattern="##.##" minFractionDigits="3" ></fmt:formatNumber>
            </td>
        </tr>
            <%--<c:forEach items="" var="">--%>
        <tr>
            <td style="text-align: center">暂无</td>
            <td style="text-align: center">暂无</td>
            <td style="text-align: center">暂无</td>
            <td style="text-align: center">暂无</td>
        </tr>

            <%--</c:forEach>--%>
        </thead>
    </table>

</form:form>
</body>
</html>