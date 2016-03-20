package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.UserNotFoundException;
import index.HomeController;
import users.User;

public class ProfileServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	User thisUser = null;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/profile.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String error = HomeController.updateUser(request.getParameter("email"), request.getParameter("fname"),
				request.getParameter("lname"), request.getParameter("school"));
		
		response.sendRedirect("/profile?m=" + error);
	}

}
