package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Timer;
import java.util.TimerTask;

@WebServlet("/UpdateRemainingDays")
public class UpdateRemainingDaysServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Timer timer;

    @Override
    public void init() {
        timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                updateRemainingDays();
            }
        }, 0, 24 * 60 * 60 * 1000); // 24시간마다 실행
    }

    @Override
    public void destroy() {
        if (timer != null) {
            timer.cancel();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        updateRemainingDays();
        response.getWriter().write("Remaining days updated.");
    }

    private void updateRemainingDays() {
        String dbURL = "jdbc:mysql://localhost:3306/User";
        String dbUser = "root";
        String dbPass = "wjdtjgus04";

        try {
            // 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 PreparedStatement selectStmt = conn.prepareStatement("SELECT id, startDate, endDate FROM board");
                 ResultSet rs = selectStmt.executeQuery()) {

                while (rs.next()) {
                    int id = rs.getInt("id");
                    Date startDate = rs.getDate("startDate");
                    Date endDate = rs.getDate("endDate");
                    long currentTime = System.currentTimeMillis();
                    long startTime = startDate.getTime();
                    long endTime = endDate.getTime();
                    int remainingDays;

                    // 오늘 날짜 구하기
                    long today = currentTime / (1000 * 60 * 60 * 24);

                    // 시작 날짜가 오늘인지 확인
                    if (today < startTime / (1000 * 60 * 60 * 24)) {
                        remainingDays = 0;
                    } else {
                        remainingDays = (int) ((endTime - currentTime) / (1000 * 60 * 60 * 24));
                        if (remainingDays < 0) {
                            remainingDays = 0;
                        }
                    }

                    // 로그 출력
                    System.out.println("Updating remainingDays for id: " + id + ", remainingDays: " + remainingDays);

                    try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE board SET remainingDays = ? WHERE id = ?")) {
                        updateStmt.setInt(1, remainingDays);
                        updateStmt.setInt(2, id);
                        updateStmt.executeUpdate();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

