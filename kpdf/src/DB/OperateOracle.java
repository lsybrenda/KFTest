package DB;

import java.sql.*;

public class OperateOracle {
	
	public static Connection conn = null;
	public static Statement stmt = null;
	public static ResultSet rs = null;
	
	private OperateOracle(){
		
	}
	
    //获取数据库连接
	public static Connection getConn(){
		if(conn != null){
			return conn;
		}else{
			try{
				Class.forName("oracle.jdbc.OracleDriver");
				conn=DriverManager.getConnection("jdbc:oracle:thin:@192.168.8.107:1521:orcl","zljg","zljg123456");
				return conn;
			}catch(Exception e){
				e.printStackTrace();
				return null;
			}
		}
	}
	//关闭结果集对象
	public static void close(ResultSet rs){
		try{
			if(rs!=null){
				rs.close();
		    }
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	//关闭预编译对象
	public static void close(Statement stmt){
		try{
			if(stmt!=null){
				stmt.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//关闭结果集对象
	public static void close(Connection conn){
		try{
			if(conn!=null){
				conn.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 向数据库中增加分数数据
	 */
	public void AddData(String name,String firsts,String jqs,String seconds,String thirds,String totals){
		try{
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.8.107:1521:orcl","zljg","zljg123456");
			PreparedStatement pre = null;
			String sql = "insert into score"
					+ "(name,firsts,jqscore,seconds,thirds,totals)"
					+ "values("
					+ name + ","
					+ firsts + ","
					+ jqs + ","
					+ seconds + ","
					+ thirds + ","
					+ totals + ","
					+ ")";
			pre = conn.prepareStatement(sql);
			pre.executeUpdate();
			
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	/**
	 * 向数据库中查询数据
	 */
	public void SelectData(String name){
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.8.107:1521:orcl","zljg","zljg123456");
			stmt = conn.createStatement();
			String sql = "select * from emp where name='"+name+"'";
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}

}
