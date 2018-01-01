package report.servlets;

import org.mindrot.BCrypt;
import report.models.User;
import report.proxy.UserProxy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserAddServlet")
public class UserAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 首先先判断有没有登录
        if (request.getSession().getAttribute("uid") == null) {
            response.sendRedirect("/login.jsp");
            return;
        }

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String area = request.getParameter("area");


        // 错误提示信息
        List<String> info = new ArrayList<String>();

        try {
            UserProxy userProxy = new UserProxy();
            User user = new User();

            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt())); // 通过 BCrypt 取得密码哈希
            user.setRole(role);
            user.setArea(area);

            userProxy.createUser(user);
            info.add("用户创建成功");
            request.getSession().setAttribute("info", info);
            response.sendRedirect("/user.jsp");
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            info.add("数据库错误");
        } catch (Exception e) {
            e.printStackTrace();
            info.add("未知错误");
        }

        request.getSession().setAttribute("info", info);
        response.sendRedirect("/user_add.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/index.jsp");
    }
}
