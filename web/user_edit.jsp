<%@ page import="report.util.Util" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 判断用户是否有权限添加删除用户
    if (!"accendant".equals(request.getSession().getAttribute("role")) && !"admin".equals(request.getSession().getAttribute("role"))) {
        // 错误提示信息
        List<String> info = new ArrayList<String>();
        info.add("您无权操作用户");
        session.setAttribute("info", info);
        response.sendRedirect("/error.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>用户管理 - 数据统计系统</title>
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
                <li><a href="${pageContext.request.contextPath}/data.jsp">数据 <span class="sr-only">(current)</span></a></li>
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
            <%-- End 全局消息提示 --%>
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