<%@ page import="report.util.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="report.models.Data" %>
<%@ page import="java.util.List" %>
<%@ page import="report.proxy.DataProxy" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="report.util.TableRow" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (request.getSession().getAttribute("uid") == null) {
        // 错误提示信息
        List<String> info = new ArrayList<String>();
        info.add("您还没有登录或会话已过期，请登录后再试。");
        session.setAttribute("info", info);
        response.sendRedirect("/login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>数据报表 - 数据统计系统</title>
    <%--<link rel="stylesheet" href="/vendor/bootstrap-3.3.7/css/bootstrap.min.css">--%>
    <style>
        body {
            font-family: Lato, "PingFang SC", "Microsoft YaHei", sans-serif;
        }

        .main {
            /*max-width: 500px;*/
        }

        table {
            border-collapse: collapse;
            margin-left: auto;
            margin-right: auto;
        }

        table, th, td {
            border: 1px solid black;
            padding: 3px;
            text-align: center;
        }

        @media print{

            /*隐藏不打印的元素*/
            .no-print{
                display:none;
            }
            /*其他打印样式*/
        }

        @page{
            size: A4 landscape;
            margin: 30px;

            table {
                page-break-after: avoid;
            }

            page-break-inside: avoid;
        }


    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="main">
            <p class="no-print" align="center">点击右键 -> 打印 即可</p>
            <%
                DataProxy dataProxy = new DataProxy();
                List<Data> dataList = dataProxy.getDataListByDate(request.getParameter("date") == null ? "2017-12" : request.getParameter("date"));

                // 通过一个三层 HashMap 实现列表的存储
                // 另外两层 HashMap 封装在了 TableRow 类中
                HashMap<Integer, TableRow> dataTable = new HashMap<>();
                for (Data data : dataList) {
                    // 先判断行是否存在，存在则插入某行的内容
                    // 每行代表每个指标的所有数据
                    TableRow row = dataTable.get(data.getTemplate());
                    if (row == null) {
                        row = new TableRow(data.getFieldName(), data.getUnit(), data.getFormat());
                    }
                    // 给行增加片区数据
                    row.setArea(data.getArea(), data.getCurrent(), data.getLastYear(), data.getYearonyear());
                    // 插入行
                    dataTable.put(data.getTemplate(), row);
                }

                List<String> areaList = Util.getAreaList();
            %>
            <table class="table">
                <thead>
                    <tr>
                        <td style="height: 3em; font-size: 18px;" colspan="<%= 5 + 3 * (areaList.size())%>">沿海某省经济运行数据统计表（<%
                            String date = request.getParameter("date") == null ? "2017-12" : request.getParameter("date");
                            String[] str = date.split("-");
                            out.print(str[0] + "年" + str[1] + "月");
                        %>）</td>
                    </tr>
                    <tr>
                        <td rowspan="2">指标名称</td>
                        <td rowspan="2">计量单位</td>
                        <td colspan="3">合计</td>
                        <%
                            for (String area : areaList) {
                        %>
                        <td colspan="3"><%= area %> 片区</td>
                        <%
                            }
                        %>
                    </tr>
                    <tr>
                        <td>本期实际</td>
                        <td>去年同期</td>
                        <td>同比（%）</td>
                        <%-- 每个片区三个数据 --%>
                        <%
                            for (int i = 0; i < areaList.size(); i++) {
                        %>
                            <td>本期实际</td>
                            <td>去年同期</td>
                            <td>同比（%）</td>
                        <%
                            }
                        %>
                    </tr>
                </thead>
                <tbody>
                <% for (Integer key : dataTable.keySet()) {
                    TableRow row = dataTable.get(key);
                %>
                    <tr>
                        <td><%= row.getFormat() == 1 ? "<b>" + row.getFieldName() + "</b>" : row.getFieldName() %></td>
                        <td><%= row.getUnit() %></td>
                        <td><%= row.getCurrentSum() != null ? row.getCurrentSum() : "-" %></td>
                        <td><%= row.getLastSum() != null ? row.getLastSum() : "-" %></td>
                        <td><%= row.getYearOnYearSum() != null ? row.getYearOnYearSum() : "-" %></td>
                        <%-- 每组数据三个单元格 --%>
                        <% for (String area : areaList) { %>
                        <td><%= row.getCurrent(area) != null ? row.getCurrent(area) : "-" %></td>
                        <td><%= row.getLast(area) != null ? row.getLast(area) : "-" %></td>
                        <td><%= row.getYearOnYear(area) != null ? row.getYearOnYear(area) : "-" %></td>
                        <% } %>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
<% session.removeAttribute("info"); %>