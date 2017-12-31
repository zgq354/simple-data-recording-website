package report.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // 数据库驱动程序
    private static final String DBDRIVER = "com.mysql.jdbc.Driver";
    // 数据库连接地址
    private static final String DBURL = "jdbc:mysql://localhost:3306/report";
    private static final String DBUSER = "root";
    private static final String DBPASS = "root";
    // 连接实例
    private Connection connection = null;

    // 构造函数
    public DatabaseConnection() throws Exception {
        try {
            // 处理出现的异常情况
            Class.forName(DBDRIVER);
            connection = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
        } catch (Exception e) {
            throw e;
        }
    }

    // 获取连接实例
    public Connection getConnection() {
        return connection;
    }

    // 关闭连接
    public void close() throws SQLException {
        if (connection != null) {
//            try {
                connection.close();
//            } catch (Exception e) {
//                throw e;
//            }
        }
    }
}
