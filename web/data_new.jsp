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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>录入本月的数据</title>
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
            <a class="navbar-brand" href="#">数据统计系统</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">数据 <span class="sr-only">(current)</span></a></li>
                <li><a href="#">指标</a></li>
                <li><a href="#">用户</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div class="container">
    <div class="row">
        <div class="main">
            <h3>录入本月的数据</h3>
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
            <%
                // 获取所有的条目列表
                TemplateProxy templateProxy = new TemplateProxy();
                List<Template> templates = templateProxy.getTemplatesList();
            %>
            <form method="post" action="${pageContext.request.contextPath}/servlet/LoginServlet">
                <% for (Template template : templates) {%>
                <div>
                    <h4><%= template.getFieldName() %></h4>
                    <div class="form-group">
                        <label for="current-<%= template.getId() %>" class="control-label">本期实际</label>
                        <input type="text" class="form-control" id="current-<%= template.getId() %>" name="inputEmail1" placeholder="本期实际">
                    </div>
                    <div class="form-group">
                        <label for="last-<%= template.getId() %>" class="control-label">去年同期</label>
                        <input type="text" class="form-control" id="last-<%= template.getId() %>" name="inputEmail2" placeholder="去年同期">
                    </div>
                    <div class="form-group">
                        <label for="yearonyear-<%= template.getId() %>" class="control-label">同比</label>
                        <input type="text" class="form-control" id="yearonyear-<%= template.getId() %>" name="yearonyear-<%= template.getId() %>" placeholder="同比">
                    </div>
                </div>
                <% } %>
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
</html>

<% session.removeAttribute("info"); %>