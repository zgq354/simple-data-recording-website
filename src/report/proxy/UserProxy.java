package report.proxy;

import report.database.DBHelperUtil;
import report.models.User;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserProxy extends BaseProxy {
    private DBHelperUtil DB = null;

    public UserProxy() throws Exception {
        DB = getDBInstance();
    }

    /**
     * 通过uid获取用户信息
     * @param id 要查询的UID
     */
    public User getUserById(String id) throws Exception {
        String sql = "SELECT * FROM `user` WHERE id=?";
        ResultSet rs = DB.executeQuery(sql, new Object[]{id});
        if (rs.next()) {
            User result = new User();
            result.setId(Integer.parseInt(id));
            result.setUsername(rs.getString("username"));
            result.setPassword(rs.getString("password"));
            result.setEmail(rs.getString("email"));
            result.setRole(rs.getString("role"));
            result.setArea(rs.getString("area"));
            return result;
        }

        return null;
    }

    /**
     * 通过Email获取用户信息
     * @param email 要查询的UID
     */
    public User getUserByEmail(String email) throws Exception {
        String sql = "SELECT * FROM `user` WHERE id=?";
        ResultSet rs = DB.executeQuery(sql, new Object[]{email});
        if (rs.next()) {
            User result = new User();
            result.setId(rs.getInt("id"));
            result.setUsername(rs.getString("username"));
            result.setPassword(rs.getString("password"));
            result.setEmail(rs.getString("email"));
            result.setRole(rs.getString("role"));
            result.setArea(rs.getString("area"));
            return result;
        }

        return null;
    }

    /**
     * 创建新用户
     * @param user 用户信息
     * @return boolean
     * @throws SQLException sql错误
     */
    public boolean createUser(User user) throws SQLException {
        String sql = "INSERT INTO `user`" +
                "(`id`, `username`, `password`, `email`, `role`, `area`, `created`)" +
                "VALUES (NULL, ?, ?, ?, ?, ?, ?)";
        return DB.executeUpdate(sql, new Object[]{
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getRole(),
                user.getArea(),
                String.valueOf(System.currentTimeMillis() / 1000) // 时间戳
        });
    }

    /**
     * 更新用户数据
     * @param user 用户信息
     * @return 返回执行情况
     * @throws SQLException 抛出错误
     */
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE `user` " +
                "SET" +
                "`username` = ? ," +
                "`password` = ? ," +
                "`email` = ? ," +
                "`role` = ? ," +
                "`area` = ? " +
                "WHERE `id` = ?";
        return DB.executeUpdate(sql, new Object[]{
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getRole(),
                user.getArea(),
                user.getId()
        });
    }

    /**
     * 删除用户
     * @param id 要删除的用户id
     * @return 返回执行状态
     * @throws SQLException SQL错误
     */
    public boolean deleteUserById(String id) throws SQLException {
        String sql = "DELETE FROM `user` WHERE `id` = ?";
        return DB.executeUpdate(sql, new Object[]{
                id
        });
    }
}
