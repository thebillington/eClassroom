package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;
import users.SchoolClass;
import users.Student;
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

		// If request is to add a new class
		if ("newclass".equals(request.getParameter("request"))) {

			// Get the current user as a teacher object, and store as a variable
			Teacher t = (Teacher) HomeController.getUser(request.getParameter("email"));

			String classname = request.getParameter("classname");

			// Create a new class with the class name and store the error
			// message in a string
			String error = t.createClass(classname);

			// If the attempt to add the class was successful then forward to
			// the classes details pane
			if (error.equals("success")) {
				response.sendRedirect("/classes?c=" + classname + "&u=" + t.getUsername());
			} else {
				// Forward back to the profile page with our error message
				response.sendRedirect("/profile?m=" + error + "&p=classes");
			}
		}

		// If request is to delete a class
		if ("deleteclass".equals(request.getParameter("request"))) {

			//Get the user as a user object
			User u = HomeController.getUser(request.getParameter("email"));

			//Set the classname String
			String className = request.getParameter("classname");
			
			//Create an error string to store our success/fail value
			String error;

			//If the user is a teacher, delete the class
			if (u.isTeacher()) {
				// Get the current user as a teacher object, and store as a
				// variable
				Teacher t = (Teacher) u;
				
				// Delete the class and store the error message
				error = t.deleteClass(className);
			} else {
				// Get the current user as a student object, and store as a
				// variable
				Student s = (Student) u;
				
				//Get the class and store as an object
				SchoolClass sc = s.getClass(className);

				// Create a new class with the class name and store the error
				// message in a string
				String studentError = s.unsubClass(sc);
				String classError = sc.deleteStudent(s);
				
				// If this check fails, something major went wrong
				if (!classError.equals(studentError)) {
					error = "subfail";
				} else {
					// Otherwise set our main error message to the
					// returned message value
					error = classError;
				}
				
			}

			// Forward back to the profile page with our error message
			response.sendRedirect("/profile?m=" + error + "&p=classes");
		}

		// If request is to search for a class
		if ("searchclass".equals(request.getParameter("request"))) {

			// Store the class name and teacher username/email as Strings
			String className = request.getParameter("classname");
			String teacher = request.getParameter("teacher");

			// Get the input username as a user object (returns null if no user
			// exists)
			User u = HomeController.getUser(teacher);

			// Get this students object
			Student s = (Student) HomeController.getUser(request.getParameter("email"));

			// If the user exists, and is a teacher
			if (u != null) {
				if (u.isTeacher()) {
					// Get the current user as a teacher object, and store as a
					// variable
					Teacher t = (Teacher) u;

					// If the teacher has a class matching the given name
					if (t.hasClass(className)) {
						// Get our class object
						SchoolClass sc = t.getClass(className);

						// Subscribe our student to the class, and add the class
						// to the students subscribed classes
						String classError = sc.addStudent(s);
						String studentError = s.subClass(sc);

						// Create a new string to hold our returned error
						String error;

						// If this check fails, something major went wrong
						if (!classError.equals(studentError)) {
							error = "subfail";
						} else {
							// Otherwise set our main error message to the
							// returned message value
							error = classError;
						}
						// If the user is subscribed forward back with error
						// message
						if (error.equals("subscribed")) {
							response.sendRedirect("/profile?m=" + error);
						} else {
							// Otherwise forward to the class page
							response.sendRedirect("/classes?c=" + sc.getName() + "&u=" + t.getUsername());

						}
					} else {
						// Send a redirect with a user not a teacher error
						response.sendRedirect("/profile?m=noclass&p=classes");
					}
				} else {
					// Send a redirect with a user not a teacher error
					response.sendRedirect("/profile?m=noteacher&p=classes");
				}
			} else {
				// Send a redirect with a user doesn't exist error
				response.sendRedirect("/profile?m=nouser&p=classes");
			}
		}

	}

}
