package report.models;

public class Data {

    /**
     * id : 记录id
     * template : 记录使用的模板
     * field_name : 指标名称
     * unit : 计量单位
     * format : 记录格式
     * area : 记录归属地区
     * current : 本期实际
     * last_year : 去年同期
     * yearonyear : 同比
     * date : 月份
     * created : 创建时间
     */

    private int id;
    private int template;
    private String field_name;
    private String unit;
    private int parent;
    private int format;
    private String area;
    private double current;
    private double last_year;
    private double yearonyear;
    private String date;
    private int created;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTemplate() {
        return template;
    }

    public void setTemplate(int template) {
        this.template = template;
    }


    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public String getFieldName() {
        return field_name;
    }

    public void setFieldName(String field_name) {
        this.field_name = field_name;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public int getFormat() {
        return format;
    }

    public void setFormat(int format) {
        this.format = format;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public double getCurrent() {
        return current;
    }

    public void setCurrent(double current) {
        this.current = current;
    }

    public double getLastYear() {
        return last_year;
    }

    public void setLastYear(double last_year) {
        this.last_year = last_year;
    }

    public double getYearonyear() {
        return yearonyear;
    }

    public void setYearonyear(double yearonyear) {
        this.yearonyear = yearonyear;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getCreated() {
        return created;
    }

    public void setCreated(int created) {
        this.created = created;
    }
}
