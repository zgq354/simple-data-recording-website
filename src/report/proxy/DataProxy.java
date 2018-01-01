package report.proxy;

import report.database.DBHelperUtil;
import report.models.Data;
import report.models.Template;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DataProxy extends BaseProxy {
    private DBHelperUtil DB = null;

    public DataProxy() throws Exception {
        DB = DBHelperUtil.createInstance();
    }

    /**
     * 获取单条数据记录
     * @param id 记录id
     * @return 数据记录对象
     * @throws SQLException SQL错误
     */
    public Data getDataById(String id) throws SQLException {
        String sql = "SELECT * FROM `data` WHERE id = ?";
        ResultSet rs = DB.executeQuery(sql, new Object[]{id});
        if (rs.next()) {
            Data data = new Data();
            data.setId(Integer.parseInt(id));
            data.setTemplate(rs.getInt("template"));
            data.setFieldName(rs.getString("field_name"));
            data.setUnit(rs.getString("unit"));
            data.setParent(rs.getInt("parent"));
            data.setFormat(rs.getInt("format"));
            data.setArea(rs.getString("area"));
            data.setCurrent(rs.getDouble("current"));
            data.setLastYear(rs.getDouble("last_year"));
            data.setYearonyear(rs.getDouble("year-on-year"));
            data.setDate(rs.getString("date"));
            return data;
        }

        return null;
    }

    /**
     * 临时获取一个日期列表
     * @return 日期列表
     */
    public List<String> getDateList() {
        List<String> result = new ArrayList<String>();
        for (int i = 12; i > 1; i--) {
            result.add("2017-" + Integer.toString(i));
        }
        return result;
    }

    /**
     * 获取片区列表
     * @return 片区列表
     */
    public List<String> getAreaList() {
        List<String> result = new ArrayList<String>();
        result.add("A");
        result.add("B");
        result.add("C");
        return result;
    }

    /**
     * 获取报表的列表
     * @param date 年月，如“2017-10”
     * @return 所有的记录
     * @throws SQLException SQL异常
     */
    public List<Data> getDataListByDate(String date) throws SQLException {
        // 结果按照模板排序，data表有冗余
        String sql = "SELECT * FROM `data` " +
                "WHERE `date` = ? " +
                "ORDER BY `area` ASC, `sort` DESC";
        ResultSet rs = DB.executeQuery(sql, new Object[]{date});
        List<Data> result = new ArrayList<Data>();
        while (rs.next()) {
            Data data = new Data();
            data.setId(rs.getInt("id"));
            data.setTemplate(rs.getInt("template"));
            data.setFieldName(rs.getString("field_name"));
            data.setUnit(rs.getString("unit"));
            data.setParent(rs.getInt("parent"));
            data.setFormat(rs.getInt("format"));
            data.setArea(rs.getString("area"));
            data.setCurrent(rs.getDouble("current"));
            data.setLastYear(rs.getDouble("last_year"));
            data.setYearonyear(rs.getDouble("year-on-year"));
            data.setDate(rs.getString("date"));
            result.add(data);
        }

        return result;
    }


    /**
     * 获取片区报表的列表
     * @param date 年月，如“2017-10”
     * @param area 片区，如“A”
     * @return 所有的记录
     * @throws SQLException SQL异常
     */
    public List<Data> getDataListByDateAndArea(String date, String area) throws SQLException {
        // 结果按照模板排序，data表有冗余
        String sql = "SELECT * FROM `data` " +
                "WHERE date = ? " +
                "AND area = ? " +
                "ORDER BY `sort` ASC";
        ResultSet rs = DB.executeQuery(sql, new Object[]{date, area});
        List<Data> result = new ArrayList<Data>();
        while (rs.next()) {
            Data data = new Data();
            data.setId(rs.getInt(date));
            data.setTemplate(rs.getInt("template"));
            data.setFieldName(rs.getString("field_name"));
            data.setUnit(rs.getString("unit"));
            data.setParent(rs.getInt("parent"));
            data.setFormat(rs.getInt("format"));
            data.setArea(rs.getString("area"));
            data.setCurrent(rs.getDouble("current"));
            data.setLastYear(rs.getDouble("last_year"));
            data.setYearonyear(rs.getDouble("year-on-year"));
            data.setDate(rs.getString("date"));
            result.add(data);
        }

        return result;
    }

    /**
     * 插入记录
     * @param data 记录对象
     * @return 返回执行状态
     * @throws SQLException SQL错误
     */
    public boolean insertData(Data data) throws Exception {
        // 先去 Template 找到 Sort 的值
        TemplateProxy templateProxy = new TemplateProxy();
        Template template = templateProxy.getTemplateById(Integer.toString(data.getTemplate()));
        // 开始插入
        String sql = "INSERT INTO `data` " +
                "(`id`, `template`, `field_name`, `unit`, `parent`, `format`, `sort`, `area`, `current`, `last_year`, `year-on-year`, `date`, `created`)" +
                "VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return DB.executeUpdate(sql, new Object[]{
                data.getTemplate(),
                data.getFieldName(),
                data.getUnit(),
                data.getParent(),
                data.getFormat(),
                template.getSort(),
                data.getArea(),
                data.getCurrent(),
                data.getLastYear(),
                data.getYearonyear(),
                data.getDate(),
                String.valueOf(System.currentTimeMillis() / 1000) // 时间戳
        });
    }
}
