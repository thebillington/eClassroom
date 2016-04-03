package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;
import lessons.Lesson;
import users.SchoolClass;
import users.Student;
import users.Teacher;
import users.User;

public class LessonServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	// On get, return the profile page
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/lesson.jsp").forward(request, response);
	}

	// On post method
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// If request is to add a new lesson
		if ("updateq".equals(request.getParameter("request"))) {

			// Get the current user as a teacher object, and store as a variable
			// Get the current class
			// Get the current lesson
			Teacher t = (Teacher) HomeController.getUser(request.getParameter("email"));
			SchoolClass sc = t.getClass(request.getParameter("classname"));
			Lesson l = sc.getLesson(request.getParameter("lessonname"));
			
			int loc = Integer.parseInt(request.getParameter("location"));
			String type = request.getParameter("questiontype");
			
			String error = l.updateQuestion(request.getParameter("question"), request.getParameter("corans"), request.getParameter("iansone"), request.getParameter("ianstwo"), request.getParameter("iansthree"), type, loc);

			response.sendRedirect("/lesson?m=" + error + "&c=" + sc.getName() + "&u=" + t.getUsername() + "&l=" + l.getName() + "#" + type + loc);
		}
		
		if("newattempt".equals(request.getParameter("request"))) {

			// Get the current user as a teacher object, and store as a variable
			// Get the current class
			// Get the current lesson
			Teacher t = (Teacher) HomeController.getUser(request.getParameter("email"));
			SchoolClass sc = t.getClass(request.getParameter("classname"));
			Lesson l = sc.getLesson(request.getParameter("lessonname"));
			
			String error = l.addAttempt(request.getParameter("studuser"));

			response.sendRedirect("/lesson?m=" + error + "&c=" + sc.getName() + "&u=" + t.getUsername() + "&l=" + l.getName());
		}

	}

}
