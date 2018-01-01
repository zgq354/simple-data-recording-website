package report.servlets;

import report.exception.TipException;
import report.models.Data;
import report.models.Template;
import report.proxy.DataProxy;
import report.proxy.TemplateProxy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DataAddServlet")
public class DataAddServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 首先先判断有没有登录
        if (request.getSession().getAttribute("uid") == null) {
            response.sendRedirect("/login.jsp");
            return;
        }

        // 提取请求参数
        String date = request.getParameter("date");
        String area = request.getParameter("area");
        String template = request.getParameter("template");

        // current
        double current = 0;
        try {
            if(request.getParameter("current") != null)
                current = Double.parseDouble(request.getParameter("current"));
        } catch (NumberFormatException e) {
            current = 0;
        }
        // lastYear
        double lastYear = 0;
        try {
            if(request.getParameter("last") != null)
                lastYear = Double.parseDouble(request.getParameter("last"));
        } catch (NumberFormatException e) {
            lastYear = 0;
        }
        // 同比
        double yearOnYear = 0;
        try {
            if(request.getParameter("yearonyear") != null)
                yearOnYear = Double.parseDouble(request.getParameter("yearonyear"));
        } catch (NumberFormatException e) {
            yearOnYear = 0;
        }
        // 是否继续输入
        String continued = request.getParameter("continue");


        // 错误提示信息
        List<String> info = new ArrayList<String>();

        // 开始业务逻辑
        //
        try {
            // 首先获取模板中的内容
            TemplateProxy templateProxy = new TemplateProxy();
            Template templateById = templateProxy.getTemplateById(template);
            if (templateById == null) throw new TipException("找不到指标");

            // 开始准备数据(排序已经参考模板了)
            Data data = new Data();
            data.setTemplate(Integer.parseInt(template));
            data.setFieldName(templateById.getFieldName());
            data.setUnit(templateById.getUnit());
            data.setParent(templateById.getParent());
            data.setFormat(templateById.getFormat());

            // 主要信息
            data.setArea(area);
            data.setDate(date);
            data.setCurrent(current);
            data.setLastYear(lastYear);
            data.setYearonyear(yearOnYear);

            // 插入数据
            DataProxy dataProxy = new DataProxy();
            dataProxy.insertData(data);

            // 后续事情
            info.add("数据插入成功");
            request.getSession().setAttribute("info", info);
            request.getSession().setAttribute("continued", continued != null);
            response.sendRedirect(continued == null ? "/data.jsp" : "/data_new.jsp");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            info.add("未知错误");
        }

        request.getSession().setAttribute("info", info);
        // 跳转回登录页面
        response.sendRedirect("/data_new.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("/index.jsp");
    }
}
