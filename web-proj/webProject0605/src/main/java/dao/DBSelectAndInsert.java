package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Content;
import model.FundingBoard;
import model.Product;
import model.Sponsorship;
import model.User;

public class DBSelectAndInsert {

	public User select(String userId, String userPwd, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		User user = null;

		String sql = "SELECT * FROM User WHERE id=? AND password=?";

		try {
			if (conn != null) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userId);
				pstmt.setString(2, userPwd);

				rset = pstmt.executeQuery();

				if (rset.next()) {
					user = new User();
					user.setId(rset.getString("id"));
					user.setPassword(rset.getString("password"));
					user.setCheckPassword(rset.getString("checkPassword"));
					user.setName(rset.getString("name"));
					user.setPhoneNumber(rset.getString("phoneNumber"));
					user.setAddress(rset.getString("address"));
					user.setPaymentMethod(rset.getString("paymentMethod"));
					user.setAccessPermission(rset.getString("accessPermission"));
				} else {
					System.out.println("conn이 없다");
				}

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rset != null) {
				DbConnectionAndClose.close(rset);
			}
			if (pstmt != null) {
				DbConnectionAndClose.close(pstmt);
			}
		}
		return user;
	}

	public int insert(User m, Connection conn) {
		PreparedStatement pstmt = null;
		int result = 0;

		 String sql = "INSERT INTO User (id, password,checkPassword, name, phoneNumber, address, paymentMethod, accessPermission, businessName, businessNumber) VALUES (?, ?, ?,?, ?, ?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m.getId());
			pstmt.setString(2, m.getPassword());
			pstmt.setString(3, m.getPassword());
			pstmt.setString(4, m.getName());
			pstmt.setString(5, m.getPhoneNumber());
			pstmt.setString(6, m.getAddress());
			pstmt.setString(7, m.getPaymentMethod());
			pstmt.setString(8, m.getAccessPermission());
			pstmt.setString(9, m.getBusinessName());
			pstmt.setString(10, m.getBusinessNumber());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				DbConnectionAndClose.close(pstmt);
			}
		}
		return result;
	}

	public boolean selectIdCheck(String userId, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		boolean result = false;

		String sql = "SELECT id FROM User WHERE id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();

			if (rset != null && rset.next()) { // rset이 null인지 확인 후에 next() 호출
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rset != null) {
				DbConnectionAndClose.close(rset);
			}
			if (pstmt != null) {
				DbConnectionAndClose.close(pstmt);
			}
		}
		return result;
	}

	public boolean PasswardCheck(String userId, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		boolean result = false;

		String sql = "SELECT id FROM User WHERE id=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();

			if (rset != null && rset.next()) { // rset이 null인지 확인 후에 next() 호출
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rset != null) {
				DbConnectionAndClose.close(rset);
			}
			if (pstmt != null) {
				DbConnectionAndClose.close(pstmt);
			}
		}
		return result;
	}

	public int updateUser(User user, Connection conn) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "UPDATE User SET password = ?, name = ?, checkPassword = ?, phoneNumber = ?, address = ?, paymentMethod = ? WHERE id = ?";

		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getPassword());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getPhoneNumber());
			pstmt.setString(5, user.getAddress());
			pstmt.setString(6, user.getPaymentMethod());
			pstmt.setString(7, user.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				DbConnectionAndClose.close(pstmt);
			}
		}

		return result;
	}

	public List<User> selectAllUsers(Connection conn) {
		PreparedStatement pstmt = null;
		List<User> users = new ArrayList<>();
		String sql = "SELECT id, name, phoneNumber, accessPermission, loggedIn FROM User"; // 필요한 열만 선택

		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
			while (rset.next()) {
				User user = new User();
				user.setId(rset.getString("id"));
				user.setName(rset.getString("name"));
				user.setPhoneNumber(rset.getString("phoneNumber"));
				user.setAccessPermission(rset.getString("accessPermission"));
				user.setloggedIn(rset.getBoolean("loggedIn"));
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	public void deleteUser(String userId, Connection conn) {
		String sql = "DELETE FROM User WHERE id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, userId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateUserGrade(String userId, String newGrade, Connection conn) {
		String sql = "UPDATE User SET accessPermission = ? WHERE id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, newGrade);
			pstmt.setString(2, userId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public FundingBoard selectFundingBoardById(int id) {
        FundingBoard board = null;
        String query = "SELECT * FROM board WHERE id = ?";
        
        try (Connection conn = DbConnectionAndClose.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    board = new FundingBoard();
                    board.setId(rs.getInt("id"));
                    board.setUserId(rs.getString("userId"));
                    board.setProductName(rs.getString("productName"));
                   
                    board.setStartDate(rs.getString("startDate"));
                    board.setEndDate(rs.getString("endDate"));
                    board.setPaymentEndDate(rs.getString("paymentEndDate"));

                    board.setCreationTime(rs.getString("creationTime"));
                    board.setTargetAmount(rs.getDouble("targetAmount"));
                    board.setSponsorCount(rs.getInt("sponsorCount"));
                    board.setAchievementRate(rs.getLong("achievementRate"));
                    board.setCategory(rs.getString("category"));
                    board.setAmountRaised(rs.getDouble("amountRaised"));
                    board.setSelfIntroduction(rs.getString("selfIntroduction"));
                    board.setHtmlContent(rs.getString("htmlContent"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return board;
    }

	public int insertSponsorship(Sponsorship sponsorship, Connection conn) {
		PreparedStatement ps = null;
		int result = 0;
		String query = "INSERT INTO sponsorship (boardId, sponsorId, amount) VALUES (?, ?, ?)";

		try {
			if (conn != null) {
				ps = conn.prepareStatement(query);
				ps.setInt(1, sponsorship.getBoardId());
				ps.setString(2, sponsorship.getSponsorId());
				ps.setDouble(3, sponsorship.getAmount());
				result = ps.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnectionAndClose.close(ps);
		}
		return result;
	}

	public List<FundingBoard> getAllFundingBoards(Connection conn) {

		String query = "SELECT id, userId, productName, productDescription, reasonForPromotion, startDate, endDate, paymentEndDate, imageFileName, remainingDays, targetAmount FROM board";
        List<FundingBoard> boards = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
            	FundingBoard board = new FundingBoard();
            	board.setId(rs.getInt("id"));
            	board.setUserId(rs.getString("userId"));
            	board.setProductName(rs.getString("productName"));
            	board.setStartDate(rs.getString("startDate"));
            	board.setEndDate(rs.getString("endDate"));
            	board.setPaymentEndDate(rs.getString("paymentEndDate"));
            	board.setRemainingDays(rs.getInt("remainingDays"));
            	board.setTargetAmount(rs.getDouble("targetAmount"));
            	board.setCreationTime(rs.getString("creationTime"));
            	board.setSponsorCount(rs.getInt("sponsorCount"));
            	board.setAchievementRate(rs.getLong("achievementRate"));
            	board.setCategory(rs.getString("category"));
            	board.setAmountRaised(rs.getDouble("amountRaised"));
            	board.setSelfIntroduction(rs.getString("selfIntroduction"));
            	board.setHtmlContent(rs.getString("htmlContent"));
            	boards.add(board);

            }
            System.out.println("Number of boards fetched: " + boards.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boards;
    }
}