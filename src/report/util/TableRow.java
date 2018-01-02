package report.util;

import java.util.HashMap;

/**
 * 表单数据类，将生成报表的行数据封装到一个数据结构
 */
public class TableRow {
    // 指标名字
    private String fieldName;

    // 计量单位
    private String unit;

    // 地区 - 指标对应哈希表
    // 默认有3个指标
    private HashMap<String, HashMap<String, Double>> dataMap;

    // 行格式
    private int format;

    // 构造函数
    public TableRow(String fieldName, String unit, int format) {
        dataMap = new HashMap<>();
        this.fieldName = fieldName;
        this.unit = unit;
        this.format = format;
    }

    /**
     * 获取指标名字
     * @return 指标名字
     */
    public String getFieldName() {
        return fieldName;
    }

    /**
     * 获取单位
     * @return 该行用到的单位
     */
    public String getUnit() {
        return unit;
    }

    /**
     * 获取片区名的哈希表
     * @param area 片区名字
     * @return 含有数据的表
     */
    public HashMap<String, Double> getArea(String area) {
        return dataMap.get(area);
    }

    // 获取行格式
    public int getFormat() {
        return format;
    }

    // 获取本期实际
    public Double getCurrent(String area) {
        HashMap<String, Double> data = dataMap.get(area);
        if (data == null) return null;
        return data.get("current");
    }

    // 获取去年同期
    public Double getLast(String area) {
        HashMap<String, Double> data = dataMap.get(area);
        if (data == null) return null;
        return data.get("last");
    }

    // 获取同比
    public Double getYearOnYear(String area) {
        HashMap<String, Double> data = dataMap.get(area);
        if (data == null) return null;
        return data.get("yearOnYear");
    }

    // 设置地区的数据
    public void setArea(String area, Double current, Double last, Double yearOnYear) {
        HashMap<String, Double> data = new HashMap<>();
        data.put("current", current);
        data.put("last", last);
        data.put("yearOnYear", yearOnYear);

        dataMap.put(area, data);
    }
}
