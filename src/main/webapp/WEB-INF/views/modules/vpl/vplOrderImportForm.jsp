<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>订单入库表管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            $("#cusId").focus();
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
            //新增默认显示系统当前时间
            var d = new Date();
            var str = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
            $("#orderDate").val(str);

            //默认宽度250  在客户型号(产品型号不为空的情况下才显示默认值)
            $(".wide").val("");
            if ($(".proModel").val() != "") {
                $("input[name='orderImportList[0].proModel']").parents().next().children(".wide").val("250");
            }
            $(".proModel").blur(function () {
                if ($(this).val() != "") {
                    $(this).parents().next().children(".wide").val("250");
                }
            });
        });

        $(function () {
            var num = 5;
            $("#addTr").click(function () {
                num++;
               // $("#table").append("<tr style='height: 3em;'><td style='width: 1px;'><input type='text'  name='copyTr' style='text-align: center;width: 3em;margin-right: 1em' readonly  value='" + num + "'  tabindex='-1'></td><td><input type='text' name='orderImportList['+(num-1)+'].proModel' value='${tsyOrderImport.proModel}' style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td><td><input type='number' name='orderImportList['+(num-1)+'].wide' value='' tabindex='-2' style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td><td><input type='number' name='orderImportList['+(num-1)+'].leng' value='${tsyOrderImport.leng}' style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td><td><input type='number' name='orderImportList['+(num-1)+'].counts' value='${tsyOrderImport.counts}' style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td><td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small sideType'  name='orderImportList['+(num-1)+'].sideType'><option>${fns:getDictLabel(num2, 'tsy_side_type', '')}</option><c:forEach items='${sideTypeList}' var='side'><option value='${side.value}'>${side.label}</option></c:forEach></select></td><td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small' name='orderImportList['+(num-1)+'].workType'><option>${fns:getDictLabel(num, 'tsy_work_type', '')}</option><c:forEach items='${workTypeList}' var='dict'><option value='${dict.value}'>${dict.label}</option></c:forEach></select></td><td><input type='text' name='orderImportList['+(num-1)+'].remarks' value='${tsyOrderImport.remarks}' style='text-align: center;width:8.5em' class='input-small '></td></tr>");
                $("#table").append("<tr style='height: 3em;'><td style='width: 1px;'><input type='text'  name='copyTr' style='text-align: center;width: 3em;margin-right: 1em' readonly  value='"+num+"'  tabindex='-1'></td><td><input type='text' name='orderImportList["+(num-1)+"].proModel' value='${tsyOrderImport.proModel}' style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td><td><input type='number' name='orderImportList["+(num-1)+"].wide' value='' tabindex='-2' style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td><td><input type='number' name='orderImportList["+(num-1)+"].leng' value='${tsyOrderImport.leng}' style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td><td><input type='number' name='orderImportList["+(num-1)+"].counts' value='${tsyOrderImport.counts}' style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td><td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small sideType'  name='orderImportList["+(num-1)+"].sideType' onchange='change(this)'><option></option><c:forEach items='${sideTypeList}' var='side'><option value='${side.value}'>${side.label}</option></c:forEach></select></td><td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small' name='orderImportList["+(num-1)+"].workType'><option></option><c:forEach items='${workTypeList}' var='dict'><option value='${dict.value}'>${dict.label}</option></c:forEach></select></td><td><input type='text' name='orderImportList["+(num-1)+"].remarks' value='${tsyOrderImport.remarks}' style='text-align: center;width:8.5em' class='input-small '></td><td><input type='hidden' name='orderImportList["+(num-1)+"].price' value='' style='text-align: center;width:8.5em' class='input-small price'></td></tr>");});
            $("#delTr").click(function () {
                if (num > 5) {
                    $("table tr:last").remove();
                    num--;
                }
            });
/*
            $("._cusId").change(function () {
                $("#cusId_").val($(this).val());
            });*/
            //根据选择的面数显示对应的客户价格


            /* $(".sideType").change(function () {
                 var sideTyepe = $(this).val();
                 alert(sideTyepe);

             });*/
        });

        //每条数据切换面板类型时候获取面板类型ID
        function change(obj) {
            debugger;
            var typeId = $(obj).val();
            var cusNo = $("#_cusId").val();
            $.ajax({
                type: "POST",
                url: "${ctx}/vpl/vplCustomer/selPrice",
                data: {"typeId": typeId, "cusNo": cusNo},
                success: function (data) {
                    // alert(data)
                    $(obj).parents().next().next().next().children(".price").val(data);
                }
            });
        };
        //切换客户代码
        /*function changeCusName(obj) {
            alert($(obj).val())
            $("#_cusId").val($(obj).val());
            alert($("#_cusId").val())
        }*/
    </script>
    <script type="text/css">
        *{
            text-align: right;
            margin: 100px;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/vpl/vplOrderImport/form?id=${vplOrderImport.id}">订单<shiro:hasPermission
            name="vpl:vplOrderImport:edit">${not empty vplOrderImport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="vpl:vplOrderImport:edit">查看</shiro:lacksPermission></a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/">订单列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderImport/list?remarks=online">在线产品</a></li>
    <li><a href="${ctx}/vpl/vplOrderDelivery/">出货列表</a></li>
    <li><a href="${ctx}/vpl/vplOrderDelivery/summary">小结</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="vplOrderImport" action="${ctx}/vpl/vplOrderImport/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <div class="control-group">
        <div class="controls" style="margin-left: 30em">
            <label class="" style="font-size: 20px; font-weight: bolder;font-family: STKaiti;">订单录入表</label>
        </div>
    </div>
    <div class="control-group" style="width: 69.5em;padding-left: 0em">
        <div class="" style="">
			<span style="float: left;">
				<label class="">订单编号：</label>
				<form:input path="orderId" id="cusId" htmlEscape="false" maxlength="16" class="input-small required"/>
			</span>

            <span style="margin-left:9em">
					<label class="">客户名称：</label>
                        <select name="cusName" id="_cusId" class="input-small _cusId">
                            <c:forEach items="${page.list}" var="cn">
                                <option value="${cn.cusNo}" title="${cn.cusNo}">${cn.cusName}</option>
                            </c:forEach>
                        </select>
                         <%--<form:select path="cusName" class="input-small _cusId"  onchange="changeCusName(this)">
                             <c:forEach items="${page.list}" var="cn">
                                 <form:option name="cusName" id="_cusId"  value="${cn.cusNo}">${cn.cusNo}</form:option>
                             </c:forEach>
                         </form:select>--%>
			</span>

            <span style="float: right">
					<label class="" style="">下单日期：</label>
						<c:choose>
                            <c:when test="${not empty tsyOrderImport.id}">
								<input name="orderDate" type="text" readonly="readonly" maxlength="20"
                                       class="input-medium Wdate "
                                       value="<fmt:formatDate value="${tsyOrderImport.orderDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                            </c:when>
                            <c:otherwise>
								<input name="orderDate" id="orderDate" type="text" readonly="readonly" maxlength="20"
                                       class="input-medium Wdate "
                                       value="<fmt:formatDate value="${tsyOrderImport.orderDate}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                            </c:otherwise>
                        </c:choose>
				</span>
        </div>
    </div>

    <div class="control-group" style="">
        <table style="" id="table">
            <tr style="height: 3em;text-align:center">
                <td><label class="" style="width: 2em">序号</label></td>
                <td><label class="" style="width: 5em">客户型号</label></td>
                <td><label class="" style="width: 5em">宽度(mm)</label></td>
                <td><label class="" style="width: 5em">长度(mm)</label></td>
                <td><label class="" style="width: 5em">订单数量</label></td>
                <td><label class="" style="width: 5em">面数</label></td>
                <td><label class="" style="width: 7em">颜色</label></td>
                <td><label class="" style="width: 5em">备注</label></td>
            </tr>
            <tr style="height: 3em;">
                <td style="width: 1px;"><input type="text" name="copyTr" style="text-align: center;width: 3em;margin-right: 1em" readonly value="1" tabindex="-1"></td>
                <td><input type='text' name="orderImportList[0].proModel" value="${tsyOrderImport.proModel}"  style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td>
                <td><input type='number' name="orderImportList[0].wide" value="" tabindex="-2" style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td>
                <td><input type='number' name="orderImportList[0].leng" value="${tsyOrderImport.leng}" style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td>
                <td><input type='number' name="orderImportList[0].counts" value="${tsyOrderImport.counts}" style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td>
                <td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small sideType' name="orderImportList[0].sideType" onchange="change(this)">
                    <option></option>
                    <c:forEach items="${sideTypeList}" var="side">
                        <option value="${side.value}">${side.label}</option>
                    </c:forEach></select>
                </td>

                <td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small' name="orderImportList[0].workType"></option>
                    <option></option>
                        <c:forEach items="${workTypeList}" var="dict">
                    <option value="${dict.value}">${dict.label}</option>
                    </c:forEach></select>
                </td>

                <td><input type='text' name="orderImportList[0].remarks" value="${tsyOrderImport.remarks}" style='text-align: center;width:8.5em' class='input-small '></td>
                <td><input type='hidden' name="orderImportList[0].price" value="" style='text-align: center;width:8.5em' class='input-small price'></td>
            </tr>

            <tr style="height: 3em;">
                <td style="width: 1px;"><input type="text" name="copyTr"
                                               style="text-align: center;width: 3em;margin-right: 1em" readonly
                                               value="2" tabindex="-1"></td>
                <td><input type='text' name="orderImportList[1].proModel" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td>
                <td><input type='number' name="orderImportList[1].wide" value="" tabindex="-2"
                           style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td>
                <td><input type='number' name="orderImportList[1].leng" value=""
                           style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td>
                <td><input type='number' name="orderImportList[1].counts" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td>
                <td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small'
                            name="orderImportList[1].sideType" onchange="change(this)">
                    <option></option>
                    <c:forEach items="${sideTypeList}" var="side">
                        <option value="${side.value}">${side.label}</option>
                    </c:forEach></select></td>
                <td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small'
                            name="orderImportList[1].workType">
                    <option></option>
                    <c:forEach items="${workTypeList}" var="dict">
                        <option value="${dict.value}">${dict.label}</option>
                    </c:forEach></select></td>
                <td><input type='text' name="orderImportList[1].remarks" value="" style='text-align: center;width:8.5em'
                           class='input-small '></td>
                <td><input type='hidden' name="orderImportList[1].price" value="" style='text-align: center;width:8.5em' class='input-small price'></td>
            </tr>

            <tr style="height: 3em;">
                <td style="width: 1px;"><input type="text" name="copyTr"
                                               style="text-align: center;width: 3em;margin-right: 1em" readonly
                                               value="3" tabindex="-1"></td>
                <td><input type='text' name="orderImportList[2].proModel" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td>
                <td><input type='number' name="orderImportList[2].wide" value="" tabindex="-2"
                           style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td>
                <td><input type='number' name="orderImportList[2].leng" value=""
                           style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td>
                <td><input type='number' name="orderImportList[2].counts" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td>
                <td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small'
                            name="orderImportList[2].sideType" onchange="change(this)">
                    <option></option>
                    <c:forEach items="${sideTypeList}" var="side">
                        <option value="${side.value}">${side.label}</option>
                    </c:forEach></select></td>
                <td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small'
                            name="orderImportList[2].workType">
                    <option></option>
                    <c:forEach items="${workTypeList}" var="dict">
                        <option value="${dict.value}">${dict.label}</option>
                    </c:forEach></select></td>
                <td><input type='text' name="orderImportList[2].remarks" value="" style='text-align: center;width:8.5em'
                           class='input-small '></td>
                <td><input type='hidden' name="orderImportList[2].price" value="" style='text-align: center;width:8.5em' class='input-small price'></td>
            </tr>
            <tr style="height: 3em;">
                <td style="width: 1px;"><input type="text" name="copyTr"
                                               style="text-align: center;width: 3em;margin-right: 1em" readonly
                                               value="4" tabindex="-1"></td>
                <td><input type='text' name="orderImportList[3].proModel" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td>
                <td><input type='number' name="orderImportList[3].wide" value="" tabindex="-2"
                           style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td>
                <td><input type='number' name="orderImportList[3].leng" value=""
                           style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td>
                <td><input type='number' name="orderImportList[3].counts" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td>
                <td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small'
                            name="orderImportList[3].sideType" onchange="change(this)">
                    <option></option>
                    <c:forEach items="${sideTypeList}" var="side">
                        <option value="${side.value}">${side.label}</option>
                    </c:forEach></select></td>
                <td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small'
                            name="orderImportList[3].workType">
                    <option></option>
                    <c:forEach items="${workTypeList}" var="dict">
                        <option value="${dict.value}">${dict.label}</option>
                    </c:forEach></select></td>
                <td><input type='text' name="orderImportList[3].remarks" value="" style='text-align: center;width:8.5em'
                           class='input-small '></td>
                <td><input type='hidden' name="orderImportList[3].price" value="" style='text-align: center;width:8.5em' class='input-small price'></td>
            </tr>
            <tr style="height: 3em;">
                <td style="width: 1px;"><input type="text" name="copyTr"
                                               style="text-align: center;width: 3em;margin-right: 1em" readonly
                                               value="5" tabindex="-1"></td>
                <td><input type='text' name="orderImportList[4].proModel" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em' class='input-small proModel'></td>
                <td><input type='number' name="orderImportList[4].wide" value="" tabindex="-2"
                           style='text-align: center;width:5em;margin-right: 1em;' class='wide' readonly></td>
                <td><input type='number' name="orderImportList[4].leng" value=""
                           style='text-align: center;width:5em;margin-right: 1em;' class='input-small '></td>
                <td><input type='number' name="orderImportList[4].counts" value=""
                           style='text-align: center;width:8.5em;margin-right: 1em;' class='input-small '></td>
                <td><select style='text-align: center;width:8em;margin-right: 1em;' class='input-small'
                            name="orderImportList[4].sideType" onchange="change(this)">
                    <option></option>
                    <c:forEach items="${sideTypeList}" var="side">
                        <option value="${side.value}">${side.label}</option>
                    </c:forEach></select></td>
                <td><select style='text-align: center;width:7em;margin-right: 1em;' class='input-small'
                            name="orderImportList[4].workType">
                    <option></option>
                    <c:forEach items="${workTypeList}" var="dict">
                        <option value="${dict.value}">${dict.label}</option>
                    </c:forEach></select></td>
                <td><input type='text' name="orderImportList[4].remarks" value="" style='text-align: center;width:8.5em'
                           class='input-small '></td>
                <td><input type='hidden' name="orderImportList[4].price" value="" style='text-align: center;width:8.5em' class='input-small price'></td>
            </tr>


        </table>
        <div style="margin-left: 0.5em;margin-top: 1em;width: 69em">
            <input type="button" class="btn btn-primary" id="addTr" value="十"
                   style="border-radius: 20%;margin-right: 0.5em">
            <input type="button" class="btn btn-primary" id="delTr" value="一" style="border-radius: 20%">
            <input type="reset" class="btn btn-primary" value="清空" style="border-radius: 20%;float: right;">
            <input type="submit" class="btn btn-primary" value="录入"
                   style="border-radius: 20%;float: right;margin-right: 0.8em">
        </div>
    </div>


    <%-- <div class="form-actions">
         <shiro:hasPermission name="vpl:vplOrderImport:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                                    value="保 存"/>&nbsp;</shiro:hasPermission>
         <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
     </div>--%>
</form:form>
</body>
</html>