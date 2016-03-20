package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;
import users.Teacher;
import users.User;

public class ProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// On get, return the profile page
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/profile.jsp").forward(request, response);
	}

	// On post method
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// If request is to update user data
		if ("updateuser".equals(request.getParameter("request"))) {

			// Set our error String equal to the returned value of our attempt
			// to update the user
			String error = HomeController.updateUser(request.getParameter("email"), request.getParameter("password"),
					request.getParameter("fname"), request.getParameter("lname"), request.getParameter("school"));

			// Forward back to the profile page with our success/error message
			// as a url parameter
			response.sendRedirect("/profile?m=" + error);
		}
		
		//If request is to add a new user
		if ("newclass".equals(request.getParameter("request"))) {

			//Set the error string equal to the value when we attempt to add a new
			String error = "";
			
			Teacher t =  (Teacher) HomeController.getUser(request.getParameter("email"));
			
			t.createClass(request.getParameter("classname"));

			// Forward back to the profile page with our success/error message
			// as a url parameter
			response.sendRedirect("/profile?m=" + error);
		}
		
		//If request is to add a new user
		if ("searchclass".equals(request.getParameter("request"))) {

			//Set the error string equal to the value when we attempt to add a new
			String error = "";

			// Forward back to the profile page with our success/error message
			// as a url parameter
			response.sendRedirect("/profile?m=" + error);
		}
		
		
	}

}
