package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;

public class ProfileServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	//On get, return the profile page
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/profile.jsp").forward(request, response);
	}

	//On post update our user information
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//Set our error String equal to the returned value of our attempt to update the user
		String error = HomeController.updateUser(request.getParameter("email"), request.getParameter("password"), request.getParameter("fname"),
				request.getParameter("lname"), request.getParameter("school"));
		
		//Forward back to the profile page with our success/error message as a url parameter
		response.sendRedirect("/profile?m=" + error);
	}

}
