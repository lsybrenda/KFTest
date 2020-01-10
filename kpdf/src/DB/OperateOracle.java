package DB;

import java.sql.*;

public class OperateOracle {
	
	public static Connection conn = null;
	public static Statement stmt = null;
	public static ResultSet rs = null;
	
	private OperateOracle(){
		
	}
	
    //��ȡ���ݿ�����
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
	//�رս��������
	public static void close(ResultSet rs){
		try{
			if(rs!=null){
				rs.close();
		    }
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	//�ر�Ԥ�������
	public static void close(Statement stmt){
		try{
			if(stmt!=null){
				stmt.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//�رս��������
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
	 * �����ݿ������ӷ�������
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
	 * �����ݿ��в�ѯ����
	 */
	public void SelectData(String name){
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.8.107:1521:orcl","zljg","zljg123456");
			stmt = conn.createStatement();
			String sql = "select * from emp where name='"+name+"'";
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		
	}

}
