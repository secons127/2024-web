package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.*;

public class Service {

	private DBSelectAndInsert service = new DBSelectAndInsert();

	public User selectUser(String userId, String userPwd) {

		Connection conn = DbConnectionAndClose.getConnection();
		User user = service.select(userId, userPwd, conn);
		DbConnectionAndClose.close(conn);

		return user;
	}

	public int insertUser(User user) {
		Connection conn = DbConnectionAndClose.getConnection();
		int result = service.insert(user, conn);

		DbConnectionAndClose.close(conn);
		return result;
	}

	public boolean selectIdCheck(String userId) {
		Connection conn = DbConnectionAndClose.getConnection();
		boolean result = service.selectIdCheck(userId, conn);
		DbConnectionAndClose.close(conn);

		return result;
	}


	public int updateUser(User user) {
        Connection conn = DbConnectionAndClose.getConnection();
        int result = service.updateUser(user, conn);
        DbConnectionAndClose.close(conn);
        return result;
    }
	
	public List<User> getAllUsers() {
        Connection conn = DbConnectionAndClose.getConnection();
        List<User> users = service.selectAllUsers(conn);
        DbConnectionAndClose.close(conn);
        return users;
    }

    public void deleteUser(String userId) {
        Connection conn = DbConnectionAndClose.getConnection();
        service.deleteUser(userId, conn);
        DbConnectionAndClose.close(conn);
    }

    public void updateUserGrade(String userId, String newGrade) {
        Connection conn = DbConnectionAndClose.getConnection();
        service.updateUserGrade(userId, newGrade, conn);
        DbConnectionAndClose.close(conn);
    }
    

    
  
    
    public List<FundingBoard> getAllFundingBoards() {
        Connection conn = DbConnectionAndClose.getConnection();
        List<FundingBoard> boards = service.getAllFundingBoards(conn);
        DbConnectionAndClose.close(conn);
        return boards;}
    
    
    public int insertSponsorship(Sponsorship sponsorship) {
        int result = 0;
        Connection conn = DbConnectionAndClose.getConnection();
        
        result = service.insertSponsorship(sponsorship, conn);
        DbConnectionAndClose.close(conn);

        return result;
    }

 // FundingBoard 데이터를 삽입하는 메인 메서드
    public int insertFundingBoard(FundingBoard board) {
        int boardId = 0;
        Connection conn = null;

        try {
            conn = DbConnectionAndClose.getConnection();
            boardId = insertFundingBoard(board, conn);
        } finally {
            DbConnectionAndClose.close(conn);
        }
        return boardId;
    }

    // Connection을 받아 실제 데이터 삽입을 처리하는 메서드
    public int insertFundingBoard(FundingBoard board, Connection conn) {
        int boardId = 0;
        String query = "INSERT INTO board (userId, productName, startDate, endDate, paymentEndDate, targetAmount, creationTime, sponsorCount, achievementRate, category, amountRaised, selfIntroduction, contents, products, htmlContent) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, board.getUserId());
            ps.setString(2, board.getProductName());

            ps.setString(3, board.getStartDate());
            ps.setString(4, board.getEndDate());
            ps.setString(5, board.getPaymentEndDate());

            ps.setDouble(6, board.getTargetAmount());
            ps.setString(7, board.getCreationTime());
            ps.setInt(8, board.getSponsorCount());
            ps.setDouble(9, board.getAchievementRate());
            ps.setString(10, board.getCategory());
            ps.setDouble(11, board.getAmountRaised());
            ps.setString(12, board.getSelfIntroduction());
            ps.setString(13, board.getContents().toString()); // 컨텐츠 리스트를 문자열로 변환해서 저장
            ps.setString(14, board.getProducts().toString()); // 제품 리스트를 문자열로 변환해서 저장
            ps.setString(15, board.getHtmlContent());
            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    boardId = generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardId;
    }

    public void insertProducts(List<Product> products, int boardId) {
        Connection conn = null;

        try {
            conn = DbConnectionAndClose.getConnection();
            insertProducts(products, boardId, conn);
        } finally {
            DbConnectionAndClose.close(conn);
        }
    }

    public void insertProducts(List<Product> products, int boardId, Connection conn) {
        String query = "INSERT INTO Products (boardId, productName, productPrice, productImage) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            for (Product product : products) {
                ps.setInt(1, boardId);
                ps.setString(2, product.getProductName());
                ps.setDouble(3, product.getProductPrice());
                ps.setString(4, product.getProductImage());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertContents(List<Content> contents, int boardId) {
        Connection conn = null;

        try {
            conn = DbConnectionAndClose.getConnection();
            insertContents(contents, boardId, conn);
        } finally {
            DbConnectionAndClose.close(conn);
        }
    }

    public void insertContents(List<Content> contents, int boardId, Connection conn) {
        String query = "INSERT INTO Contents (boardId, title, subtitle, content) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            for (Content content : contents) {
                ps.setInt(1, boardId);
                ps.setString(2, content.getTitle());
                ps.setString(3, content.getSubtitle());
                ps.setString(4, content.getContent());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
