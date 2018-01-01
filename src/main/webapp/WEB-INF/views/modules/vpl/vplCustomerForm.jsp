<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>客户管理管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".cusNo").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/vpl/vplCustomer/">客户管理列表</a></li>
    <li class="active"><a href="${ctx}/vpl/vplCustomer/form?id=${vplCustomer.id}">客户管理<shiro:hasPermission
            name="vpl:vplCustomer:edit">${not empty vplCustomer.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplCustomer:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="vplCustomer" action="${ctx}/vpl/vplCustomer/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">客户代码：</label>
        <div class="controls">
            <form:input path="cusNo" placeholder="请输入客户代码" htmlEscape="false" maxlength="16" class="input-xlarge  cusNo"
                        required="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">客户名称：</label>
        <div class="controls">
            <form:input path="cusName" placeholder="请输入客户名称" htmlEscape="false" maxlength="255" class="input-xlarge "
                        required="required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">加工类型：</label>
        <c:forEach items="${dictList}" var="dict" varStatus="cou">
            <div class="controls" style="margin-bottom: 1em">
                <input type="text"  value="${dict.label}" class="input-xlarge" readonly
                       tabindex="-1"><input type="hidden" name="typeId" value="${dict.value}">&nbsp;
                价格：<input type="text" name="price1[${cou.count-1}]" id="" value="${price1[cou.count-1]}"
                          placeholder="请输入价格"
                          class="input-small" required="required">
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </c:forEach>

            <%-- <c:set value="${fn:split(vplCustomer.price,',')}" var="s"></c:set>

             <c:forEach items="${s}" var="ss">
                 ${ss}
             </c:forEach>--%>

    </div>

    <div class="control-group">
        <label class="control-label">备注：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="vpl:vplCustomer:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                                value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>