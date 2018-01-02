package report.models;

public class Template {

    /**
     * id : 条目id
     * field_name : 条目名字
     * unit : 单位
     * parent : 父级条目
     * format : 显示格式
     * sort: 排序的位置
     */

    private int id;
    private String field_name;
    private String unit;
    private int parent;
    private int format;
    private int sort;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public int getFormat() {
        return format;
    }

    public void setFormat(int format) {
        this.format = format;
    }

    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }
}
