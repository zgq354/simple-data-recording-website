package report.proxy;

import report.database.DBHelperUtil;
import report.models.Template;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TemplateProxy extends BaseProxy {
    private DBHelperUtil DB = null;

    public TemplateProxy() throws Exception {
        DB = DBHelperUtil.createInstance();
    }

    /**
     * 获取模板ID
     * @param id 模板id
     * @return 返回 Template的实例
     * @throws Exception 数据库异常
     */
    public Template getTemplateById(String id) throws Exception {
        String sql = "SELECT * FROM `template` WHERE id = ?";
        ResultSet rs = DB.executeQuery(sql, new Object[]{id});
        if (rs.next()) {
            Template template = new Template();
            template.setId(Integer.parseInt(id));
            template.setParent(rs.getInt("parent"));
            template.setFormat(rs.getInt("format"));
            template.setSort(rs.getInt("sort"));
            template.setFieldName(rs.getString("field_name"));
            template.setUnit(rs.getString("unit"));
            return template;
        }

        return null;
    }

    /**
     * 获取所有的条目模板
     * @return 返回条目列表
     * @throws SQLException SQL异常
     */
    public List<Template> getTemplatesList() throws SQLException {
        // 结果按照模板排序，data表有冗余
        String sql = "SELECT * FROM `template` " +
                "ORDER BY `sort` ASC";
        ResultSet rs = DB.executeQuery(sql, new Object[]{});
        List<Template> result = new ArrayList<Template>();
        while (rs.next()) {
            Template template = new Template();
            template.setId(rs.getInt("id"));
            template.setFieldName(rs.getString("field_name"));
            template.setUnit(rs.getString("unit"));
            template.setParent(rs.getInt("parent"));
            template.setFormat(rs.getInt("format"));
            result.add(template);
        }

        return result;
    }
    
    /**
     * 创建模板
     * @param template 数据对象
     * @return 返回执行状态
     * @throws SQLException SQL异常
     */
    public boolean createTemplate(Template template) throws SQLException {
        String sql = "INSERT INTO `template`" +
                "(`id`, `field_name`, `unit`, `parent`, `format`, `sort`)" +
                "VALUES (NULL, ?, ?, ?, ?, ?)";
        return DB.executeUpdate(sql, new Object[]{
                template.getFieldName(),
                template.getUnit(),
                template.getParent(),
                template.getFormat(),
                template.getSort()
        });
    }

    /**
     * 更新模板
     * @param template 模板对象
     * @return 返回执行状态
     * @throws SQLException SQL异常
     */
    public boolean updateTemplate(Template template) throws SQLException {
        String sql = "UPDATE `template` " +
                "SET" +
                "`field_name` = ? ," +
                "`unit` = ? ," +
                "`parent` = ? ," +
                "`format` = ? " +
                "`sort` = ? " +
                "WHERE `id` = ?";
        return DB.executeUpdate(sql, new Object[]{
                template.getFieldName(),
                template.getUnit(),
                template.getParent(),
                template.getFormat(),
                template.getSort(),
                template.getId()
        });
    }

    /**
     * 删除模板
     * @param id 要删除的模板id
     * @return 返回执行状态
     * @throws SQLException SQL错误
     */
    public boolean deleteTemplateById(String id) throws SQLException {
        String sql = "DELETE FROM `template` WHERE `id` = ?";
        return DB.executeUpdate(sql, new Object[]{
                id
        });
    }


}
