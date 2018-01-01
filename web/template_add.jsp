<%@ page import="report.proxy.TemplateProxy" %>
<%@ page import="report.models.Template" %>
<%@ page import="java.util.List" %>
<%@ page import="report.util.Util" %><%--
  Created by IntelliJ IDEA.
  User: qing
  Date: 17-12-30
  Time: 下午5:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (request.getSession().getAttribute("uid") == null) {
        response.sendRedirect("/login.jsp");
        return;
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>新建指标 - 数据统计系统</title>
    <link rel="stylesheet" href="/vendor/bootstrap-3.3.7/css/bootstrap.min.css">
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
                <li><a href="${pageContext.request.contextPath}/data.jsp">数据 <span class="sr-only">(current)</span></a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/template.jsp">指标</a></li>
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
            <h3>新建指标</h3>
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
            <form method="post" action="${pageContext.request.contextPath}/servlet/LoginServlet">
                <div class="form-group">
                    <label for="field_name" class="control-label">指标名称</label>
                    <input type="text" class="form-control" id="field_name" name="field_name" placeholder="指标名称">
                </div>
                <div class="form-group">
                    <label for="unit" class="control-label">计量单位</label>
                    <input type="text" class="form-control" id="unit" name="unit" placeholder="如“个”、“万元”等">
                </div>
                <div class="form-group">
                    <label for="sort" class="control-label">排序值（数字越大越靠后）</label>
                    <input type="text" class="form-control" id="sort" name="sort" placeholder="0" value="0">
                </div>
                <div class="form-group">
                    <%--@declare id="parent"--%><label for="parent" class="control-label">上级指标</label>
                    <select class="form-control" name="parent">
                        <option value="0">无上级指标</option>
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
                    <%--@declare id="format"--%><label for="format" class="control-label">指标格式</label>
                    <select class="form-control" name="format">
                        <option value="0">无</option>
                        <option value="1">加粗</option>
                    </select>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="continue"> 提交本条记录后继续录入
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
        <p class="text-mute text-center">Made with <span><i class="glyphicon glyphicon-heart"></i></span> by Group</p>
    </div>
</div>
</body>
<script src="${pageContext.request.contextPath}/vendor/jquery-3.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/vendor/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</html>
<% session.removeAttribute("info"); %>