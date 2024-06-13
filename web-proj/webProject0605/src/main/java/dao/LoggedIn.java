package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LoggedIn {
	
	public void updateLoginStatus(String userId, boolean loggedIn) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DbConnectionAndClose.getConnection();
            String sql = "UPDATE User SET loggedIn = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setBoolean(1, loggedIn);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Connection, PreparedStatement 등의 자원을 해제
        	DbConnectionAndClose.close(pstmt);
        	DbConnectionAndClose.close(conn);
        }
    }
	
}


