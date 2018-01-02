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
    <link rel="stylesheet" href="/vendor/bootstrap-3.3.7/css/bootstrap.min.css">
    <style>
        body {
            font-family: Lato, "PingFang SC", "Microsoft YaHei", sans-serif;
        }

        .main {
            /*max-width: 500px;*/
        }

        .footer-bottom {
            margin-top: 100px;
            padding: 18px;
        }
    </style>
</head>
<body>
<%-- 导航条 --%>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">数据统计系统</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="${pageContext.request.contextPath}/data.jsp">数据 <span class="sr-only">(current)</span></a></li>
                <li><a href="${pageContext.request.contextPath}/template.jsp">指标</a></li>
                <li><a href="${pageContext.request.contextPath}/user.jsp">用户</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <% if (session.getAttribute("uid") != null) {%>
                <li><a href="#">用户组：<%= Util.convertRoleName(String.valueOf(session.getAttribute("role"))) %></a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                        <%= session.getAttribute("username") %> <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${pageContext.request.contextPath}/servlet/LogoutServlet">退出登录</a></li>
                    </ul>
                </li>
                <% } else { %>
                <li><a href="${pageContext.request.contextPath}/servlet/LoginServlet">登录</a></li>
                <% } %>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<%--结束导航条--%>
<div class="container">
    <div class="row">
        <div class="main">
            <%-- 全局消息提示 --%>
            <%
                List<String> stringList = (List<String>) session.getAttribute("info");
                if (stringList != null) {
                    for (String str : stringList) {
            %>
            <div class="alert alert-warning alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <%= str %>
            </div>
            <%
                    }
                }
            %>
            <h3>沿海某省经济运行数据统计表（<%
            String date = request.getParameter("date") == null ? "2017-12" : request.getParameter("date");
            String[] str = date.split("-");
            out.print(str[0] + "年" + str[1] + "月");
            %>）</h3>
                <p><a class="btn btn-success" href="data_print.jsp?date=<%= request.getParameter("date") == null ? "2017-12" : request.getParameter("date") %>" target="_blank">生成可打印版本</a></p>
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
                        row = new TableRow(data.getFieldName(), data.getUnit());
                    }
                    // 给行增加片区数据
                    row.setArea(data.getArea(), data.getCurrent(), data.getLastYear(), data.getYearonyear());
                    // 插入行
                    dataTable.put(data.getTemplate(), row);
                }
            %>
            <table class="table">
                <thead>
                    <tr>
                        <td rowspan="2">指标名称</td>
                        <td rowspan="2">计量单位</td>
                        <%
                            List<String> areaList = Util.getAreaList();
                            for (String area : areaList) {
                        %>
                        <td colspan="3"><%= area %> 片区</td>
                        <%
                            }
                        %>
                    </tr>
                    <tr>
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
                        <td><%= row.getFieldName() %></td>
                        <td><%= row.getUnit() %></td>
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
<div class="footer-bottom">
    <div class="container">
        <p class="text-mute text-center">Made with <span><i class="glyphicon glyphicon-heart"></i></span> by Group</p>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/vendor/jquery-3.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</html>
<% session.removeAttribute("info"); %>