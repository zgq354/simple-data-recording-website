package report.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 错误提示信息
        List<String> info = new ArrayList<String>();

        // 首先先判断有没有登录，没有登录的话就直接跳转
        if (request.getSession().getAttribute("uid") != null) {
            request.getSession().removeAttribute("uid");
            request.getSession().removeAttribute("role");
            request.getSession().removeAttribute("username");
            request.getSession().removeAttribute("area");

            info.add("账户登出成功！");
        }

        request.getSession().setAttribute("info", info);
        response.sendRedirect("/login.jsp");
    }
}
