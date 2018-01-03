package report.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(filterName = "RequireLoginFilter")
public class RequireLoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        System.out.println(request.getSession().getAttribute("uid"));
        // 未登录
        if (request.getSession().getAttribute("uid") == null) {
            List<String> info = new ArrayList<String>();
            info.add("您还没有登录或会话已过期，请登录后再试。");
            request.getSession().setAttribute("info", info);
            response.sendRedirect("/login.jsp");
        } else {
            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
