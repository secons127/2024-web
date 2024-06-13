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

import dao.Service;

/**
 * Servlet implementation class UserRegister
 */

@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserRegister() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String checkPassword = request.getParameter("checkPassword");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("postcode") + " " + request.getParameter("address") + " " + request.getParameter("detailed-address");
        String paymentMethod = request.getParameter("paymentMethod");
        String accessPermission = request.getParameter("userTypeHidden");
        String businessName = request.getParameter("business-name");
        String businessNumber = request.getParameter("business-number");
		

		Service mService = new Service();

		if (mService.selectIdCheck(id) == false) {

			User u = new User(id, password, checkPassword, name, phoneNumber,address,paymentMethod,accessPermission,businessName,businessNumber);
			int result = mService.insertUser(u);
			if (result != 0) {
				HttpSession session = request.getSession(true);
				session.setAttribute("user", u);
				response.sendRedirect("main.jsp");

			}

		} else {

			RequestDispatcher view = request.getRequestDispatcher("Log/UserRegisterFail.jsp");
			view.forward(request, response);

		}

	}

}
