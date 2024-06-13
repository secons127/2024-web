package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

import dao.LoggedIn;

/**
 * Servlet implementation class UserLogoutServlet
 */


@WebServlet("/UserLogoutServlet")
public class UserLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		// 세션에서 User 객체 가져오기
		User user = (User) session.getAttribute("user");
		String userId = user.getId();

		LoggedIn log = new LoggedIn();

		log.updateLoginStatus(userId, false);
		request.getSession().invalidate();

		// 클라이언트에게 로그아웃 완료 메시지를 전송하는 JavaScript 코드
		String script = "<script>alert('로그아웃되었습니다.'); window.location.href = 'main.jsp';</script>";
		response.setContentType("text/html;charset=UTF-8");
		response.getWriter().println(script);
	}
}
