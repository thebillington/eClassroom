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
			response.sendRedirect("/profile?m=" + error + "&p=edit");
		}
		
		//If request is to add a new class
		if ("newclass".equals(request.getParameter("request"))) {
			
			//Get the current user as a teacher object, and store as a variable
			Teacher t =  (Teacher) HomeController.getUser(request.getParameter("email"));
			
			String classname = request.getParameter("classname");
			
			//Create a new class with the class name and store the error message in a string
			String error = t.createClass(classname);
			
			//If the attempt to add the class was successful then forward to the classes details page
			if(error.equals("success")) {
				response.sendRedirect("/classes?c=" + classname + "&u=" + t.getUsername());
			}
			else {
				//Forward back to the profile page with our error message
				response.sendRedirect("/profile?m=" + error + "&p=classes");
			}
		}
		
		//If request is to delete a class
		if ("deleteclass".equals(request.getParameter("request"))) {
			
			//Get the current user as a teacher object, and store as a variable
			Teacher t =  (Teacher) HomeController.getUser(request.getParameter("email"));
			
			String classname = request.getParameter("classname");
			
			//Create a new class with the class name and store the error message in a string
			String error = t.deleteClass(classname);

			//Forward back to the profile page with our error message
			response.sendRedirect("/profile?m=" + error + "&p=classes");
		}
		
		//If request is to search for a class
		if ("searchclass".equals(request.getParameter("request"))) {
			
			//Send a redirect with the search term as a URL parameter
			response.sendRedirect("/profile?s=" + "&p=classes");
		}
		
		
	}

}
