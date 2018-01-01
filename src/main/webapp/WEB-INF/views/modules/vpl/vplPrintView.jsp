<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/11/3 0003
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="../../../static/jquery/jquery-1.9.1.js"></script>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:x="urn:schemas-microsoft-com:office:excel"
      xmlns="http://www.w3.org/TR/REC-html40">

<head>
    <meta http-equiv=Content-Type content="text/html; charset=gb2312">
    <meta name=ProgId content=Excel.Sheet>
    <meta name=Generator content="Microsoft Excel 14">
    <link rel=File-List href="vpl.files/filelist.xml">
    <style id="vpl_12718_Styles">
        <!--table
        {mso-displayed-decimal-separator:"\.";
            mso-displayed-thousand-separator:"\,";}
        .font512718
        {color:windowtext;
            font-size:9.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;}
        .xl6312718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:bottom;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6412718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:28.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:bottom;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6512718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:10.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6612718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6712718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6812718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:26.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:top;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl6912718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:left;
            vertical-align:bottom;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7012718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            border:.5pt solid windowtext;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7112718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:#555555;
            font-size:16.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:general;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7212718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:16.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:left;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7312718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:16.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7412718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:12.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7512718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:12.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:middle;
            border:.5pt solid windowtext;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7612718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:11.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:left;
            vertical-align:middle;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        .xl7712718
        {padding-top:1px;
            padding-right:1px;
            padding-left:1px;
            mso-ignore:padding;
            color:black;
            font-size:26.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-number-format:General;
            text-align:center;
            vertical-align:top;
            border-top:none;
            border-right:none;
            border-bottom:.5pt solid windowtext;
            border-left:none;
            mso-background-source:auto;
            mso-pattern:auto;
            white-space:nowrap;}
        ruby
        {ruby-align:left;}
        rt
        {color:windowtext;
            font-size:9.0pt;
            font-weight:400;
            font-style:normal;
            text-decoration:none;
            font-family:宋体;
            mso-generic-font-family:auto;
            mso-font-charset:134;
            mso-char-type:none;}
        -->
    </style>
</head>

<body>
<!--[if !excel]>　　<![endif]-->
<!--下列信息由 Microsoft Excel 的发布为网页向导生成。-->
<!--如果同一条目从 Excel 中重新发布，则所有位于 DIV 标记之间的信息均将被替换。-->
<!----------------------------->
<!--“从 EXCEL 发布网页”向导开始-->
<!----------------------------->

<div id="vpl_12718" align=center x:publishsource="Excel">

    <table border=0 cellpadding=0 cellspacing=0 width=805 class=xl6312718
           style='border-collapse:collapse;table-layout:fixed;width:605pt'>
        <col class=xl6312718 width=48 style='mso-width-source:userset;mso-width-alt:
 1536;width:36pt'>
        <col class=xl6312718 width=124 style='mso-width-source:userset;mso-width-alt:
 3968;width:93pt'>
        <col class=xl6312718 width=72 span=2 style='width:54pt'>
        <col class=xl6312718 width=115 style='mso-width-source:userset;mso-width-alt:
 3680;width:86pt'>
        <col class=xl6312718 width=54 style='mso-width-source:userset;mso-width-alt:
 1728;width:41pt'>
        <col class=xl6312718 width=58 style='mso-width-source:userset;mso-width-alt:
 1856;width:44pt'>
        <col class=xl6312718 width=72 span=2 style='width:54pt'>
        <col class=xl6312718 width=118 style='mso-width-source:userset;mso-width-alt:
 3776;width:89pt'>
        <tr height=46 style='mso-height-source:userset;height:34.5pt'>
            <td colspan=10 height=46 class=xl6412718 width=805 style='height:34.5pt;
  width:605pt'>深圳市伟品利科技有限公司</td>
        </tr>
        <tr height=29 style='mso-height-source:userset;height:21.75pt'>
            <td colspan=10 height=29 class=xl6612718 style='height:21.75pt'>地址：深圳市宝安区沙井街道蚝一岗头工业区大浦二路51号三楼<br>
            </td>
        </tr>
        <tr height=30 style='mso-height-source:userset;height:22.5pt'>
            <td colspan=10 height=30 class=xl6512718 style='height:22.5pt'>手机：18588206782/15920080517
                传真：0755-23061295<br>
                邮箱：VPLfpc@126.com<br>
            </td>
        </tr>
        <tr class=xl6612718 height=24 style='mso-height-source:userset;height:18.0pt'>
            <td height=24 class=xl6612718 style='height:18.0pt'></td>
            <td class=xl6612718></td>
            <td class=xl6612718></td>
            <td colspan=4 rowspan=2 class=xl6812718 style='border-bottom:.5pt solid black'>送货单</td>
            <td class=xl6612718></td>
            <td class=xl6612718 style="font-size: 1.3em">NO:${tsyOrderDelivery.deliveryId}</td>
            <td class=xl6612718></td>
        </tr>
        <tr class=xl6612718 height=24 style='mso-height-source:userset;height:18.0pt'>
            <td colspan=2 height=24 class=xl7612718 style='height:18.0pt;font-size: 1.3em'>客户名称：${tsyOrderDelivery.cusName}</td>
            <td class=xl6612718></td>
            <td class=xl6612718></td>
            <td class=xl6612718 style="font-size: 1.3em">送货日期：<fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/></td>
            <td class=xl6612718></td>
        </tr>
        <tr class=xl7412718 height=33 style='mso-height-source:userset;height:24.95pt'>
            <td height=33 class=xl7512718 style='height:24.95pt'>序号</td>
            <td class=xl7512718 style='border-left:none'>型号</td>
            <td class=xl7512718 style='border-left:none'>宽</td>
            <td class=xl7512718 style='border-top:none;border-left:none'>长</td>
            <td class=xl7512718 style='border-top:none;border-left:none'>订单号</td>
            <td class=xl7512718 style='border-top:none;border-left:none'>单位</td>
            <td class=xl7512718 style='border-top:none;border-left:none'>数量</td>
            <td class=xl7512718 style='border-left:none'>面积</td>
            <td class=xl7512718 style='border-left:none'>类型</td>
            <td class=xl7512718 style='border-left:none'>备注</td>
        </tr>

        <c:forEach items="${orderDelList}" var="print" varStatus="p">
            <tr class=xl6612718 height=33 style='mso-height-source:userset;height:24.95pt'>
                <td height=33 class=xl7012718 style='height:24.95pt;border-top:none;font-size: 1.3em'>${p.count}</td>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.proModel}</td>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.wide}</td>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.leng}</td>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.orderId}</td>
                <c:if test="${print.proModel!=''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>PNL</td>
                </c:if>
                <c:if test="${print.proModel==''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>&nbsp;</td>
                </c:if>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.counts}</td>
                <c:if test="${print.proModel!=''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.wide*print.leng*print.counts/1000000}</td>
                </c:if>
                <c:if test="${print.proModel==''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>&nbsp;</td>
                </c:if>

                <c:if test="${print.proModel!=''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em;width: 7em'>${print.sideType}</td>
                </c:if>
                <c:if test="${print.proModel==''}">
                    <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>&nbsp;</td>
                </c:if>
                <td class=xl7012718 style='border-top:none;border-left:none;font-size: 1.3em'>${print.remarks}</td>
            </tr>
        </c:forEach>

        <tr class=xl7312718 height=39 style='mso-height-source:userset;height:29.25pt'>
            <td height=39 class=xl7112718 colspan=2 style='height:29.25pt;;text-align: left'><span
                    style='font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;
  text-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-style: initial;
  text-decoration-color: initial'>送货人：${fns:getUser().name}</span></td>
            <td class=xl7312718></td>
            <td class=xl7312718></td>
            <td class=xl7312718></td>
            <td class=xl7312718></td>
            <td class=xl7312718></td>
            <td class=xl7312718></td>
            <td class=xl7312718>签收：</td>
            <td class=xl7312718></td>
        </tr>
        <tr height=18 style='mso-height-source:userset;height:13.5pt'>
            <td height=18 class=xl6912718 style='height:13.5pt'></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
            <td class=xl6312718></td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height=0 style='display:none'>
            <td width=48 style='width:36pt'></td>
            <td width=124 style='width:93pt'></td>
            <td width=72 style='width:54pt'></td>
            <td width=72 style='width:54pt'></td>
            <td width=115 style='width:86pt'></td>
            <td width=54 style='width:41pt'></td>
            <td width=58 style='width:44pt'></td>
            <td width=72 style='width:54pt'></td>
            <td width=72 style='width:54pt'></td>
            <td width=118 style='width:89pt'></td>
        </tr>
        <![endif]>
    </table>
    <%--<input type="button" id="print" value="打印">--%>
</div>
<!----------------------------->
<!--“从 EXCEL 发布网页”向导结束-->
<!----------------------------->
    <script type="text/javascript">
        $("#print").click(function(){
            window.print();
        });
    </script>

</body>

</html>

