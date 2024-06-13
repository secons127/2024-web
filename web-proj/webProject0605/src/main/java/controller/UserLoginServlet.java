package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

import dao.*;

/**
 * Servlet implementation class UserLoginServlet
 * 
 */

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		Service mService = new Service();
		User u = mService.selectUser(id, password);

		if (u != null) {
			HttpSession session = request.getSession(true);
			session.setAttribute("user", u);

			if (u.getAccessPermission() == "Manager") {
				response.sendRedirect("ManagerAccount/managerMain.jsp");
			} else {
				response.sendRedirect("main.jsp");
			}
		} else {
			RequestDispatcher view = request.getRequestDispatcher("Log/UserLoginFail.jsp");
			view.forward(request, response);
		}
	}

}
