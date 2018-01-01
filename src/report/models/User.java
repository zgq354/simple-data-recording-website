package report.models;

import report.util.Util;

public class User {

    /**
     * id : 用户UID
     * username : 用户名
     * password : 密码
     * email : 邮箱
     * role : 用户角色
     * area : 用户片区
     */

    private int id;
    private String username;
    private String password;
    private String email;
    private String role;
    private String area;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    // 获取用户组详细描述
    public String getRoleDetial() {
        return Util.convertRoleName(role);
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }


    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", role='" + role + '\'' +
                ", area='" + area + '\'' +
                '}';
    }
}
