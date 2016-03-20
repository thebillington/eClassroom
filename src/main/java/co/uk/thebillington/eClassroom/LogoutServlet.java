package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	//On get to the logout servlet
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//Create a new empty cookie called user to replace the existing cookie
		Cookie usr = new Cookie("user", "NONE");
		//Set the cookie to expire instantly
		usr.setMaxAge(0);
		//Ad the cookie to the response and redirect to the home page
		response.addCookie(usr);
		response.sendRedirect("/");

	}

}
