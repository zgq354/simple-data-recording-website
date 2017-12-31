<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: qing
  Date: 17-12-30
  Time: 下午3:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>登录后台</title>
    <link rel="stylesheet" href="vendor/bootstrap-3.3.7/css/bootstrap.min.css">
    <style>
        body {
            font-family: Lato, "PingFang SC", "Microsoft YaHei", sans-serif;
        }

        .account {
            width: 400px;
            margin-left: auto;
            margin-right: auto;
            margin-top: 200px;
        }

        .footer-bottom {
            margin-top: 100px;
            padding: 18px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="account">
            <h3>登录统计数据后台</h3>
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
            <form id="form" method="post" action="${pageContext.request.contextPath}/servlet/LoginServlet">
                <div class="form-group">
                    <input type="text" class="form-control" name="email" placeholder="邮箱">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="password" placeholder="登录密码">
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success" value="登录">
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