package report.servlets;

import report.exception.TipException;
import report.models.Template;
import report.proxy.TemplateProxy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TemplateAddServlet")
public class TemplateAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 首先先判断有没有登录
        if (request.getSession().getAttribute("uid") == null) {
            response.sendRedirect("/login.jsp");
            return;
        }

        // 避免中文乱码
        request.setCharacterEncoding("UTF-8");

        // 提取请求参数
        String fieldName = request.getParameter("field_name");
        String unit = request.getParameter("unit");

        // sort
        int sort = 0;
        try {
            if(request.getParameter("sort") != null)
                sort = Integer.parseInt(request.getParameter("sort"));
        } catch (NumberFormatException e) {
            sort = 0;
        }

        // parent
        int parent = 0;
        try {
            if(request.getParameter("parent") != null)
                parent = Integer.parseInt(request.getParameter("parent"));
        } catch (NumberFormatException e) {
            parent = 0;
        }

        // format
        int format = 0;
        try {
            if(request.getParameter("format") != null)
                format = Integer.parseInt(request.getParameter("format"));
        } catch (NumberFormatException e) {
            format = 0;
        }

        // 是否继续输入
        String continued = request.getParameter("continue");

        // 错误提示信息
        List<String> info = new ArrayList<String>();

        // 开始业务逻辑
        try {
            // 权限验证
            if (!"accendant".equals(request.getSession().getAttribute("role")) && !"admin".equals(request.getSession().getAttribute("role"))) {
                throw new TipException("您无权添加指标");
            }
            TemplateProxy templateProxy = new TemplateProxy();
            Template template = new Template();
            template.setFieldName(fieldName);
            template.setUnit(unit);
            template.setFormat(format);
            template.setParent(parent);
            template.setSort(sort);

            templateProxy.createTemplate(template);

            // 后续事情
            info.add("指标添加成功");
            request.getSession().setAttribute("info", info);
            request.getSession().setAttribute("continued", continued != null);
            response.sendRedirect(continued == null ? "/template.jsp" : "/template_add.jsp");
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            info.add("数据库错误");
        } catch (Exception e) {
            e.printStackTrace();
            info.add("未知错误");
        }

        request.getSession().setAttribute("info", info);
        response.sendRedirect("/template_add.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/index.jsp");
    }
}
