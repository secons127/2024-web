package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnectionAndClose {
	
	public static Connection getConnection() {

		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User", "root", "wjdtjgus04");


		} catch (Exception e) {

			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return conn;
	}
	
	
	public static void close(Statement stmt) {
		try {
			 if(stmt != null) {
				 stmt.close();}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// close(ResultSet)
	public static void close(ResultSet rset) {
		try {
			
			if(rset != null) {
				rset.close();}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();}
		}

	// close(Connection)
	public static void close(Connection conn) {
		try {
			
			if(conn != null) {
			conn.close();}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}



}
