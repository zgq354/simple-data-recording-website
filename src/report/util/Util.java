package report.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Util {

    /**
     * 返回用户角色列表
     * @return 返回用户角色列表
     */
    public static HashMap<String, String> getRoleList() {
        HashMap<String, String> result = new HashMap<String, String>();
        result.put("admin", "管理员");
        result.put("manager", "片区管委会");
        result.put("department", "机关单位");
        result.put("accendant", "运维人员");
        return result;
    }

    /**
     * 获取片区列表
     * @return 片区列表
     */
    public static List<String> getAreaList() {
        List<String> result = new ArrayList<String>();
        result.add("A");
        result.add("B");
        result.add("C");
        return result;
    }

    /**
     * 转换角色名
     * @param name 角色的key
     * @return 返回转换后的名字
     */
    public static String convertRoleName(String name) {
        return getRoleList().get(name);
    }
}
