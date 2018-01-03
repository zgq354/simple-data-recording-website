package report.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(filterName = "RequireLoginFilter")
public class RequireAdminFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        // 非管理员
        if (!"accendant".equals(request.getSession().getAttribute("role")) && !"admin".equals(request.getSession().getAttribute("role"))) {
            // 错误提示信息
            List<String> info = new ArrayList<String>();
            info.add("您无权访问此页面");
            request.getSession().setAttribute("info", info);
            response.sendRedirect("/error.jsp");
        } else {
            chain.doFilter(req, resp);
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
