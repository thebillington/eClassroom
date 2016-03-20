package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	//On get return the login page
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/login.jsp").forward(request, response);

	}

	//On post check the request parameter
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//If the request is for a login, try and login
		if ("login".equals(request.getParameter("request"))) {

			//Set the error string equal to the return from the attempted login request
			String error = HomeController.login(request.getParameter("email"), request.getParameter("password"));
			
			//If the login was successful
			if (error.equals("success")) {
				//Create a new cookie and give it the value user, setting it's parameter to the email address of the user
				Cookie usr = new Cookie("user", request.getParameter("email"));
				
				//Set cookie to expire after an hour
				usr.setMaxAge(60 * 60);
				
				//Add the cookie to the repsonse and then send redirect to the user profile page
				response.addCookie(usr);
				response.sendRedirect("/profile");
			} else {
				//If login wasn't successful, return the error message as a url parameter to the login page
				response.sendRedirect("/login?m=" + error);
			}
		}

		//If the request is for a signup, attempt to create a new user
		if ("signup".equals(request.getParameter("request"))) {

			//Create a new String to hold our returned message
			String error;

			//If the new user is a student, create a student using the details entered in our signup form
			if ("student".equals(request.getParameter("type"))) {
				error = HomeController.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						false);
			} else { //Otherwise create a new teacher using the details entered in our signup form
				error = HomeController.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						true);
			}

			//Redirect back to the login page, with our success/failure message as a url parameter
			response.sendRedirect("/login?m=" + error);

		}
	}

}
