package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;
import lessons.Lesson;
import users.SchoolClass;
import users.Teacher;

public class ClassesServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// On get, return the profile page
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/classes.jsp").forward(request, response);
	}

	// On post method
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// If request is to add a new class
		if ("addlesson".equals(request.getParameter("request"))) {

			// Get the current user as a teacher object, and store as a variable
			Teacher t = (Teacher) HomeController.getUser(request.getParameter("email"));
			SchoolClass sc = t.getClass(request.getParameter("classname"));

			String lessonName = request.getParameter("lessonname");

			// Create a new class with the class name and store the error
			// message in a string
			String error = sc.addLesson(new Lesson(lessonName, sc.getName(), t.getUsername()));

			response.sendRedirect("/classes?m=" + error + "&c=" + sc.getName() + "&u=" + t.getUsername());
		}

	}

}
