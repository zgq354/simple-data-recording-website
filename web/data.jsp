<%@ page import="report.proxy.DataProxy" %>
<%@ page import="java.util.List" %>
<%@ page import="report.models.Data" %>
<%@ page import="report.util.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>数据列表 - 数据统计系统</title>
    <link rel="stylesheet" href="/vendor/bootstrap-3.3.7/css/bootstrap.min.css">
    <style>
        body {
            font-family: Lato, "PingFang SC", "Microsoft YaHei", sans-serif;
        }

        .main {
            /*max-width: 500px;*/
        }

        .table > tbody > tr > td {
            vertical-align: middle;
        }

        .table > thead > tr > td {
            vertical-align: middle;
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
                <li><a href="${pageContext.request.contextPath}/login.jsp">登录</a></li>
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
            <%-- End 全局消息提示 --%>
            <h3>数据列表</h3>
            <div class="dropdown menu" style="margin-bottom: 10px;">
                <button id="btnDate" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <%= request.getParameter("date") == null ? "2017-12" : request.getParameter("date") %> <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" aria-labelledby="btnDate">
                    <%
                        DataProxy dataProxy = new DataProxy();
                        List<String> dateList = dataProxy.getDateList();
                        for (String string : dateList) {
                    %>
                    <li><a href="data.jsp?date=<%= string %>"><%= string %></a></li>
                    <% } %>
                </ul>
                <a class="btn btn-default" href="/data_new.jsp?date=<%= request.getParameter("date") == null ? "2017-12" : request.getParameter("date") %>">录入数据</a>
                <a class="btn btn-success" href="/data_report.jsp?date=<%= request.getParameter("date") == null ? "2017-12" : request.getParameter("date") %>" target="_blank">生成报表</a>
            </div>
            <%
                List<Data> dataList = dataProxy.getDataListByDate(request.getParameter("date") == null ? "2017-12" : request.getParameter("date"));
            %>
            <table class="table text-center">
                <thead>
                <tr>
                    <td>id</td>
                    <td>片区</td>
                    <td>指标名称</td>
                    <td>单位</td>
                    <td>本期实际</td>
                    <td>去年同期</td>
                    <td>同比%</td>
                    <td>操作</td>
                </tr>
                </thead>
                <tbody>
                <% for (Data data : dataList) {%>
                    <tr>
                        <td><%= data.getId() %></td>
                        <td><%= data.getArea() %></td>
                        <td><%= data.getFormat() == 1 ? "<b>" + data.getFieldName() + "</b>" : data.getFieldName() %></td>
                        <td><%= data.getUnit() %></td>
                        <td><%= data.getCurrent() %></td>
                        <td><%= data.getLastYear() %></td>
                        <td><%= data.getYearonyear() %></td>
                        <td><a href="/data_edit.jsp?id=<%= data.getId() %>" class="btn btn-primary">编辑</a></td>
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