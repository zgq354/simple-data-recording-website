package report.servlets;

import org.mindrot.BCrypt;
import report.exception.TipException;
import report.models.User;
import report.proxy.UserProxy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 首先先判断有没有登录，登录了的话就直接跳转
        if (request.getSession().getAttribute("uid") != null) {
            response.sendRedirect("/index.jsp");
            return;
        }

        // 获取POST Body传来的邮箱和密码
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 错误提示信息
        List<String> info = new ArrayList<String>();

        try {
            // 正则表达式验证邮箱是否符合格式
            if (!Pattern.matches("^[a-z0-9]+([._\\\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$", email) || password.length() < 6 || password.length() > 16) {
                // 返回邮箱或密码格式不正确
                throw new TipException("邮箱或密码格式不正确");
            }

            // 查找用户
            UserProxy user = new UserProxy();
            User result = user.getUserByEmail(email);

            // 开始验证密码
            if (result == null || !BCrypt.checkpw(password, result.getPassword())) {
                throw new TipException("账号和密码不匹配");
            }

            // 验证成功，写入Session
            // TODO: 设置Session过期时间
            request.getSession().setAttribute("uid", result.getId());
            request.getSession().setAttribute("username", result.getUsername());
            request.getSession().setAttribute("role", result.getRole());

            // 登陆成功后的提示与跳转
            info.add("欢迎回来，" + result.getUsername());
            request.getSession().setAttribute("info", info);
            response.sendRedirect("/data.jsp");
            return;
        } catch (TipException e) {
            // 登录时的错误提示，通过 TipException 错误捕捉
            System.out.println(e.getMessage());
            info.add(e.getMessage());
        } catch (Exception e) {
            // 其他错误，在控制台打印
            e.printStackTrace();
            info.add("未知错误");
        }
        request.getSession().setAttribute("info", info);
        // 跳转回登录页面
        response.sendRedirect("/login.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/login.jsp");
    }
}
