package com.dxy.dafen.jsp.action;

import java.sql.Connection;
import java.sql.DriverManager;

public class MyConnect {
	
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		String url = "jdbc:oracle:thin:@192.168.8.117:1521:orcl";
		String user = "zljg";
		String password = "zljg123456";
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
		
	}
	public static Connection getConnection119() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		String url = "jdbc:oracle:thin:@192.168.8.119:1521:orcl";
		String user = "zljg";
		String password = "zljg123456";
		Connection conn = DriverManager.getConnection(url, user, password);
		return conn;
		
	}
}
