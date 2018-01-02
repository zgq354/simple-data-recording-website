package report.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// 单例模式获取SQL连接，方便各大程序处理SQL查询
public class DBHelperUtil {
    // 静态变量
    private static DBHelperUtil manager = null;

    private static Connection connetion = null;

    private PreparedStatement pstm = null;

    // 创建实例
    public static DBHelperUtil createInstance() throws Exception {
        if (manager == null) { // 脑残了哇啊啊啊啊啊啊
            manager = new DBHelperUtil();
            manager.initDB();
        }
        return manager;
    }

    // 初始化数据库
    public void initDB() throws Exception {
        DatabaseConnection conn = new DatabaseConnection();
        connetion = conn.getConnection();
    }

    // 关闭数据库连接
    public void close() throws SQLException {
        if (pstm != null) {
            pstm.close();
        }
        connetion.close();
    }

    @SuppressWarnings("unused")
    private void setPrepareStatementParams(String sql, Object[] params) throws SQLException {
        pstm = connetion.prepareStatement(sql); // 获取对象
        if (params != null)
        {
            for (int i = 0; i < params.length; i++) // 遍历参数列表填充参数
            {
                pstm.setObject(i + 1, params[i]);
            }
        }
    }

    // SQL查询数据
    public ResultSet executeQuery(String sql, Object[] params) throws SQLException {
        ResultSet rs = null;
        manager.setPrepareStatementParams(sql, params);
        rs = pstm.executeQuery();
        // debug
        if (pstm instanceof com.mysql.jdbc.PreparedStatement) {
            com.mysql.jdbc.PreparedStatement msqlPstmt = (com.mysql.jdbc.PreparedStatement)pstm;
            String sqla = msqlPstmt.toString();
            System.out.println(sqla);
        }
        return rs;
    }

    // SQL更新数据
    public boolean executeUpdate(String sql, Object[] params) throws SQLException {
        // 执行无返回数据的数据查询，返回值是被改变的书库的数据库项数
        manager.setPrepareStatementParams(sql, params); // 填充参数
        pstm.executeUpdate(); // 执行更新
        // debug
        if (pstm instanceof com.mysql.jdbc.PreparedStatement) {
            com.mysql.jdbc.PreparedStatement msqlPstmt = (com.mysql.jdbc.PreparedStatement)pstm;
            String sqla = msqlPstmt.toString();
            System.out.println(sqla);
        }
//        manager.commitChange();
        return true;
    }

    private void commitChange() throws SQLException {
        connetion.commit();
    }
}
