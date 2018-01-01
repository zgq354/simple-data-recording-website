<%--
  Created by IntelliJ IDEA.
  User: qing
  Date: 17-12-31
  Time: 下午9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="report.proxy.TemplateProxy" %>
<%@ page import="report.models.Template" %>
<%@ page import="report.proxy.DataProxy" %>
<%@ page import="report.util.Util" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>录入数据 - 数据统计系统</title>
    <link rel="stylesheet" href="vendor/bootstrap-3.3.7/css/bootstrap.min.css">
    <style>
        body {
            font-family: Lato, "PingFang SC", "Microsoft YaHei", sans-serif;
        }

        .main {
            max-width: 500px;
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
            <h3>录入数据</h3>
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
            <form method="post" action="${pageContext.request.contextPath}/servlet/DataAddServlet">
                <div class="form-group">
                    <%--@declare id="date"--%><label for="date" class="control-label">录入数据的月份</label>
                    <select class="form-control" name="date">
                        <%
                            DataProxy dataProxy = new DataProxy();
                            List<String> dateList = dataProxy.getDateList();
                            for (String string : dateList) {
                        %>
                        <option><%= string %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <%-- 注意，以后要加上权限，限制各个部门只能录入和修改自己片区的信息 --%>
                    <%--@declare id="area"--%><label for="area" class="control-label">数据所属片区</label>
                    <select class="form-control" name="area">
                        <%
                            List<String> areaList = Util.getAreaList();
                            for (String string : areaList) {
                        %>
                        <option><%= string %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <%--@declare id="template"--%><label for="template" class="control-label">指标</label>
                    <select class="form-control" name="template">
                        <%
                            // 获取所有的条目列表
                            TemplateProxy templateProxy = new TemplateProxy();
                            List<Template> templates = templateProxy.getTemplatesList();
                            for (Template template : templates) {
                        %>
                        <option value="<%= template.getId() %>"><%= template.getFieldName() + "（" + template.getUnit() + "）" %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="current" class="control-label">本期实际</label>
                    <input type="text" class="form-control" id="current" name="current" placeholder="本期实际">
                </div>
                <div class="form-group">
                    <label for="last" class="control-label">去年同期</label>
                    <input type="text" class="form-control" id="last" name="last" placeholder="去年同期">
                </div>
                <div class="form-group">
                    <label for="yearonyear" class="control-label">同比(%)</label>
                    <input type="text" class="form-control" id="yearonyear" name="yearonyear" placeholder="同比">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="continue" <% if (session.getAttribute("continued") != null && (boolean)session.getAttribute("continued")) out.print("checked"); %>> 提交本条记录后继续录入
                    </label>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-default">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="footer-bottom">
    <div class="container">
        <p class="text-mute text-center">Made with <span><i class="glyphicon glyphicon-heart"></i></span>
            by Group</p>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/vendor/jquery-3.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script>
    function calculate() {
        $("#yearonyear").val(Math.round(($("#current").val() / $("#last").val()) * 10000 - 10000) / 100);
    }
    $("#current").on('change', calculate);
    $("#last").on('change', calculate);
</script>
</html>
<% session.removeAttribute("info"); %>