package report.proxy;

import report.database.DBHelperUtil;

class BaseProxy {
    private static DBHelperUtil DB = null;

    // 获取数据库连接对象实例
    DBHelperUtil getDBInstance() throws Exception {
        if (DB == null) {
            DB = DBHelperUtil.createInstance();
        }
        return DB;
    }
}
