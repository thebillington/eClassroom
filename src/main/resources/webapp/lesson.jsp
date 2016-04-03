<%@include file="/includes/cookie.jsp" %>
<%@include file="/includes/users.jsp" %>
<%@include file="/includes/lessons.jsp" %>

<html>
    
    <%@ page session="true"%>
        
    <head>
        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/lesson.css" type="text/css" />
    
        <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <%
        //Firstly return the parameters from the URL (if any)
        String lsn = request.getParameter("l");
        String usr = request.getParameter("u");
        String cls = request.getParameter("c");
        
        //Create a new boolean to store whether the given lesson exists
        boolean lessonExists = false;
           
        //If there were URL parameters
        if((lsn != null && usr != null) && cls != null) {
            //Try get the given username as a new object
            User u = HomeController.getUser(usr);
           
            //Create an object to store the class in if it exists, and initialise to null
            SchoolClass sc = null;
           
            //Create a new lesson object to store the lesson if it exists, and initialise to null
            Lesson l = null;
           
            //Check that the user exists
            if(u != null) {
                //If the user is a teacher
                if(u.isTeacher()) {
                    //Cast the user to a teacher object
                    Teacher t = (Teacher) u;
           
                    //Check if the class exists
                    if(t.hasClass(cls)) {
                        //Get the class stored in our sc variable
                        sc = t.getClass(cls);
                        //Check if the lesson exists
                        if(sc.hasLesson(lsn)) {
                            //Set lesson exists to true
                            lessonExists = true;
           
                            //Get the lesson and store it in our l object
                            l = sc.getLesson(lsn);
                        }
                        else {
                            out.print("Sorry that lesson does not exist.");
                        }
                    }
                    else {
                        //Otherwise class doesn't exist
                        out.print("Sorry that class does not exist.");
                    }
                } else {
                    //If the user is not a teacher, print error message
                    out.print("Sorry that user is not a teaching account.");
                }
            }
            else {
                //If the user doesn't exist print error message
                out.print("Sorry that user does not exist");
            }
           
            //If the lesson exists
            if(lessonExists) {
                //Print the error message
                out.print("<p class='error'>");
                String msg = request.getParameter("m");
                if(msg == null) {
                    //Do nothing
                }
                else if(msg.equals("qusuccess")) {
                    out.print("Question updated successfully!");
                }
                else if(msg.equals("fail")) {
                    out.print("Something went wrong!");
                }
                out.print("</p>");
           
                //Print the title
                out.print("<div id='title'><h3>" + lsn + "</h3></div>");
           
                //If the logged in user is a teacher
                if(thisUser.isTeacher()) {
           
                    //Cast the logged in user to a teacher object
                    Teacher t = (Teacher) thisUser;
           
                    //If the username of this teacher equals the username of the teacher that owns the class
                    if(t.getUsername().equals(usr)) {
           
                        out.print("<div id='questions'>");
           
                        Question[] pq = l.getPlacementQuestions();
            
                        out.print("<h4>Placement Questions</h4>");
           
                        //Print the form to update each placement question
           
                        out.print("<ul>");
           
                        //Easy placement question
                        out.print("<li id='placement0' class='easy'>");
                        out.print("<form action='lesson' method='POST' >");
                        out.print("<input type='hidden' name='request' value='updateq'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                        out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                        out.print("<input type='hidden' name='questiontype' value='placement'>");
                        out.print("<input type='hidden' name='location' value='0'>");
                        out.print("Question 1: <input type='text' name='question' value='" + pq[0].getQuestion() + "'><br /><br />");
                        out.print("Correct Answer: <input type='text' name='corans' value='" + pq[0].correctAnswer() + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansone' value='" + pq[0].getAnswer(1) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + pq[0].getAnswer(2) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + pq[0].getAnswer(3) + "'><br /><br />");
                        out.print("<input type='submit' value='Update Question'/>");
                        out.print("</form>");
                        out.print("</li>");
                        
                        //Medium placement question
                        out.print("<li id='placement1' class='medium'>");
                        out.print("<form action='lesson' method='POST' >");
                        out.print("<input type='hidden' name='request' value='updateq'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                        out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                        out.print("<input type='hidden' name='questiontype' value='placement'>");
                        out.print("<input type='hidden' name='location' value='1'>");
                        out.print("Question 2: <input type='text' name='question' value='" + pq[1].getQuestion() + "'><br /><br />");
                        out.print("Correct Answer: <input type='text' name='corans' value='" + pq[1].correctAnswer() + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansone' value='" + pq[1].getAnswer(1) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + pq[1].getAnswer(2) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + pq[1].getAnswer(3) + "'><br /><br />");
                        out.print("<input type='submit' value='Update Question'/>");
                        out.print("</form>");
                        out.print("</li>");
                        
           
                        //Hard placement question
                        out.print("<li id='placement2' class='hard'>");
                        out.print("<form action='lesson' method='POST' >");
                        out.print("<input type='hidden' name='request' value='updateq'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                        out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                        out.print("<input type='hidden' name='questiontype' value='placement'>");
                        out.print("<input type='hidden' name='location' value='2'>");
                        out.print("Question 3: <input type='text' name='question' value='" + pq[2].getQuestion() + "'><br /><br />");
                        out.print("Correct Answer: <input type='text' name='corans' value='" + pq[2].correctAnswer() + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansone' value='" + pq[2].getAnswer(1) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + pq[2].getAnswer(2) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + pq[2].getAnswer(3) + "'><br /><br />");
                        out.print("<input type='submit' value='Update Question'/>");
                        out.print("</form>");
                        out.print("</li>");
                        out.print("</ul>");
           
                        Question[] eq = l.getEasyQuestions();
            
                        out.print("<h4>Easy Questions</h4>");
           
                        //Print the form to update each easy question
                        out.print("<ul>");
           
                        //Print each question in turn
                        for(int i = 0; i < eq.length; i++) {
           
                            out.print("<li id='easy" + i + "' class='easy'>");
                            out.print("<form action='lesson' method='POST' >");
                            out.print("<input type='hidden' name='request' value='updateq'>");
                            out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                            out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                            out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                            out.print("<input type='hidden' name='questiontype' value='easy'>");
                            out.print("<input type='hidden' name='location' value='" + i + "'>");
                            out.print("Question " + (i + 1) + ": <input type='text' name='question' value='" + eq[i].getQuestion() + "'><br /><br />");
                            out.print("Correct Answer: <input type='text' name='corans' value='" + eq[i].correctAnswer() + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansone' value='" + eq[i].getAnswer(1) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + eq[i].getAnswer(2) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + eq[i].getAnswer(3) + "'><br /><br />");
                            out.print("<input type='submit' value='Update Question'/>");
                            out.print("</form>");
                            out.print("</li>");
           
                        }
                        out.print("</ul>");
        
                        Question[] mq = l.getMediumQuestions();
            
                        out.print("<h4>Medium Questions</h4>");
           
                        //Print the form to update each medium question
                        out.print("<ul>");
           
                        //Print each question in turn
                        for(int i = 0; i < mq.length; i++) {
           
                            out.print("<li id='medium" + i + "' class='medium'>");
                            out.print("<form action='lesson' method='POST' >");
                            out.print("<input type='hidden' name='request' value='updateq'>");
                            out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                            out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                            out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                            out.print("<input type='hidden' name='questiontype' value='medium'>");
                            out.print("<input type='hidden' name='location' value='" + i + "'>");
                            out.print("Question " + (i + 1) + ": <input type='text' name='question' value='" + mq[i].getQuestion() + "'><br /><br />");
                            out.print("Correct Answer: <input type='text' name='corans' value='" + mq[i].correctAnswer() + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansone' value='" + mq[i].getAnswer(1) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + mq[i].getAnswer(2) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + mq[i].getAnswer(3) + "'><br /><br />");
                            out.print("<input type='submit' value='Update Question'/>");
                            out.print("</form>");
                            out.print("</li>");
           
                        }
                        out.print("</ul>");
                                                     
                        Question[] hq = l.getHardQuestions();
            
                        out.print("<h4>Hard Questions</h4>");
           
                        //Print the form to update each medium question
                        out.print("<ul>");
           
                        //Print each question in turn
                        for(int i = 0; i < hq.length; i++) {
           
                            out.print("<li id='hard" + i + "' class='hard'>");
                            out.print("<form action='lesson' method='POST' >");
                            out.print("<input type='hidden' name='request' value='updateq'>");
                            out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                            out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                            out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                            out.print("<input type='hidden' name='questiontype' value='hard'>");
                            out.print("<input type='hidden' name='location' value='" + i + "'>");
                            out.print("Question " + (i + 1) + ": <input type='text' name='question' value='" + hq[i].getQuestion() + "'><br /><br />");
                            out.print("Correct Answer: <input type='text' name='corans' value='" + hq[i].correctAnswer() + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansone' value='" + hq[i].getAnswer(1) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + hq[i].getAnswer(2) + "'><br /><br />");
                            out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + hq[i].getAnswer(3) + "'><br /><br />");
                            out.print("<input type='submit' value='Update Question'/>");
                            out.print("</form>");
                            out.print("</li>");
           
                        }
                        out.print("</ul>");
                        
                        out.print("</div>");
        
                        out.print("<div id='attempts'><h4>Attempts</h4>");
        
                        List<Attempt> attempts = l.getAttempts();
        
                        if(attempts.size() == 0) {
                            out.print("There haven't been any attempts at this lesson yet.");
                        }
                        else {
                            out.print("<ul>");
        
                            for(Attempt a: attempts) {
                                out.print("<li>"); 
                                out.print("Attempt by: " + a.getUsername());
                                out.print("</li>");
                            }
                            
                            out.print("</ul>");
                        }
        
                        out.print("</div>");
                    }
                    //Logged in user doesn't own the lesson
                    else {
                        out.print("Sorry, you don't have permission to view this page.");
                    }
                }
                //Logged in user is a student
                else {
                    //Get the user object as a teacher, so that we can return the class
                    Teacher t = (Teacher) u;
                                    
                    //Cast the logged in user to a student object
                    Student stud = (Student) thisUser;
        
                    out.print("<div id='studentAttempts'>");
        
                    if(stud.hasClass(cls)) {
        
                        //Get the attempts by this student at the lesson
                        List<Attempt> attempts = l.getAttempts(stud.getUsername());
        
                        boolean attemptsComplete = false;
        
                        if(attempts.size() == 0) {
                            out.print("<p>You haven't attempted this lesson yet!</p>");
                            attemptsComplete = true;
                        }
                        else {
                            out.print("<ul>");
        
                            for(Attempt a: attempts) {
                                out.print("<li>"); 
                                out.print("Attempt number: " + a.getAttemptNumber());
                                out.print("</li>");
                                if(a.isComplete()) {
                                    attemptsComplete = true;
                                }
                            }
                            
                            out.print("</ul>");
                        }
        
                        if(attemptsComplete) {
                            out.print("Start a new attempt.");
                        }
                        else {
                            out.print("Complete previous attempt.");
                        }
                    }
                    else {
                        out.print("<p>Sorry, you aren't subscribed to this class!</p>");
                    }
                }
            }
            else {
                out.print("Lesson doesn't exist.");
            }
        }
        else {
            //Print a list of available lessons for this user
            out.print("Lessons");    
        }
           
        %>
    </div>
        
</body>

</html>