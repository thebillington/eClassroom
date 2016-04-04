package co.uk.thebillington.eClassroom;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.HomeController;
import lessons.Attempt;
import lessons.Lesson;
import lessons.Question;
import users.SchoolClass;
import users.Teacher;

public class AttemptServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	//On get return the index
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/attempt.jsp").forward(request, response);
	}
	
	// On post method
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {

			//If request is to answer a question
			if ("answerquestion".equals(request.getParameter("request"))) {
				
				// Get the current user as a teacher object, and store as a variable
				// Get the current class
				// Get the current lesson
				Teacher t = (Teacher) HomeController.getUser(request.getParameter("email"));
				SchoolClass sc = t.getClass(request.getParameter("classname"));
				Lesson l = sc.getLesson(request.getParameter("lessonname"));
				Attempt a = l.getAttempt(Integer.parseInt(request.getParameter("attemptnumber")), request.getParameter("studuser"));
				
				//Create an object to store our question
				Question q = null;
				
				//Get our answer as a String
				String answer = request.getParameter("answer");
				
				//Get the current question number
				int qNo = a.getCompleted();
				
				//If placement questions are completed
				if(qNo > 2) {
					//Get the current level
                    int level = a.getLevel();
                    //Get the correct question for that level and store it in q
                    if(level == 0) {
                    	q = l.getQuestion(1, qNo - 3);
                    }
                    if(level == 1) {
                    	q = l.getQuestion(2, qNo - 3);
                    }
                    if(level == 2) {
                    	q = l.getQuestion(3, qNo - 3);
                    }
                }
				//Otherwise get the placement question
                else {
                    q = l.getQuestion(0, qNo);
                }
				
				//If we retrieved the question successfully
				if(q != null) {
					//Create a new variable to store where the answer is (0 correct, 1 2 3 incorrect)
					int answerLoc = -1;
					
					//Get the answers to the question
					String[] answers = q.getAnswers();
					
					//Iterate through the answers and find the one that matches students selected answer
					for(int i = 0; i < answers.length; i++) {
						System.out.println(answers[i] + "=?" + answer);
						if(answers[i].equals(answer)) {
							//Set the value of answerLoc and break the loop
							answerLoc = i;
							break;
						}
					}
					//If the answer location was retrieved successfully
					if(answerLoc != -1) {
						//Answer the question
						a.answerQuestion(answerLoc);
					}
					//Otherwise something went wrong
					else {
						response.sendRedirect("/attempt?m=aerror&l=" + l.getName() + "&u=" + t.getUsername() + "&c=" + sc.getName() + "&an=" + a.getAttemptNumber() + "&au=" + a.getUsername());
					}
				}
				//Otherwise something went wrong
				else {
					response.sendRedirect("/attempt?m=aerror&l=" + l.getName() + "&u=" + t.getUsername() + "&c=" + sc.getName() + "&an=" + a.getAttemptNumber() + "&au=" + a.getUsername());
				}
				response.sendRedirect("/attempt?l=" + l.getName() + "&u=" + t.getUsername() + "&c=" + sc.getName() + "&an=" + a.getAttemptNumber() + "&au=" + a.getUsername());
				
			}

		}

}