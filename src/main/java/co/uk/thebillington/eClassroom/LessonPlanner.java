package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.UserNotFoundException;
import lessons.Lesson;

public class LessonPlanner extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/index.jsp").forward(request, response);

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Lesson.resetError();

		if ("login".equals(request.getParameter("request"))) {

			try {
				Lesson.login(request.getParameter("email"), request.getParameter("password"));
				request.getRequestDispatcher("/homepage.jsp").forward(request, response);
			} catch (UserNotFoundException e) {
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		}

		if ("signup".equals(request.getParameter("request"))) {

			if ("student".equals(request.getParameter("type"))) {
				Lesson.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						false);
			} else {
				Lesson.addUser(request.getParameter("email"), request.getParameter("username"),
						request.getParameter("password"), Integer.parseInt(request.getParameter("day")),
						Integer.parseInt(request.getParameter("month")), Integer.parseInt(request.getParameter("year")),
						true);
			}

			request.getRequestDispatcher("/login.jsp").forward(request, response);
		}

	}

}
