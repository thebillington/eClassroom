package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.UserNotFoundException;
import index.HomeController;
import lessons.Lesson;

public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/login.jsp").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("login".equals(request.getParameter("request"))) {

			try {
				HomeController.login(request.getParameter("email"), request.getParameter("password"));
				Cookie usr = new Cookie("user", request.getParameter("email"));
				usr.setMaxAge(60 * 60);
				response.addCookie(usr);
				response.sendRedirect("/");
			} catch (UserNotFoundException e) {
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}

		if ("signup".equals(request.getParameter("request"))) {

			if ("student".equals(request.getParameter("type"))) {
				HomeController.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						false);
			} else {
				HomeController.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						true);
			}
			
			request.getRequestDispatcher("/login.jsp").forward(request, response);
			
		}
	}

}
