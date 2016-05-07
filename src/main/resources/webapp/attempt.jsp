<%@include file="/includes/cookie.jsp" %>
<%@include file="/includes/users.jsp" %>
<%@include file="/includes/lessons.jsp" %>

<html>
    
    <%@ page session="true"%>
        
    <head>
        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/attempt.css" type="text/css" />
    
        <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <%
        //Firstly return the parameters from the URL (if any)
        String lsn = request.getParameter("l");
        String usr = request.getParameter("u");
        String cls = request.getParameter("c");
        String atn = request.getParameter("an");
        String atu = request.getParameter("au");
        
        //Create a new boolean to store whether the given attempt exists
        boolean attemptExists = false;
           
        //If there were URL parameters
        if(((lsn != null && usr != null) && (cls != null && atn != null)) && atu != null) {
            //Try get the given username as a new object
            User u = HomeController.getUser(usr);
           
            //Create an object to store the class in if it exists, and initialise to null
            SchoolClass sc = null;
           
            //Create a new lesson object to store the lesson if it exists, and initialise to null
            Lesson l = null;
           
            //Create a new attempt to store out attempt if it exists, and initialise to null
            Attempt a = null;
           
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
                            //Get the lesson and store it in our l object
                            l = sc.getLesson(lsn);
                            
                            //Create an int to store our parsed integer value
                            int i = -1;
                            
                            //Try and parse our atn variable as an integer
                            try {
                                i = Integer.parseInt(atn);
                            } catch(NumberFormatException e) {
                                out.print("'an' parameter must be an integer.");
                            }
                            
                            //If our integer parsing was successful
                            if(i >= 0) {
                                //If the attempt exists
                                if(l.hasAttempt(i, atu)) {
                                    //Set attemptExists to true
                                    attemptExists = true;
                                    
                                    //Get the attempt and store it in our a object
                                    a = l .getAttempt(i, atu);
                                }
                            }
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
           
            //If the attempt exists
            if(attemptExists) {
           
                //Print the title
                out.print("<div id='title'><h3>" + lsn + "</h3></div>");
           
                //If the logged in user is a teacher
                if(thisUser.isTeacher()) {
           
                    //Cast the logged in user to a teacher object
                    Teacher t = (Teacher) thisUser;
           
                    //If the username of this teacher equals the username of the teacher that owns the class
                    if(t.getUsername().equals(usr)) {
                        
                        //Get the lists of questions
                        Question[] pQ = l.getPlacementQuestions();
                        Question[] eQ = l.getEasyQuestions();
                        Question[] mQ = l.getMediumQuestions();
                        Question[] hQ = l.getHardQuestions();
            
                        out.print("<div id='attempt'>");
            
                        if(a.isComplete()) {
            
                            int[] level = a.getQuestionLevels();
                            int[] answers = a.getAnswers();
                            boolean[] correct = a.getCorrect();
            
                            out.print("<h4>Overview</h4>");
                            out.print("<div id='overview'>");
                                
                            for(int i = 0; i < level.length; i++) {
                                    //Print the correct color for each question and whether the student got it right
                                    if(level[i] == 0) {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='easy'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                    else if(level[i] == 1) {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='medium'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                    else {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='hard'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                }
            
                                out.print("</ul></div><div><br><br><br><br><br>");
                                                                
                                for(int i = 0; i < level.length; i++) {
            
                                    out.print("<h4>Question " + (i + 1) + "</h4>");
            
                                    if(i < 3) {
                                        out.print("<p>" + pQ[i].getQuestion() + "</p>");
                                        out.print("<p>Correct answer: " + pQ[i].getAnswer(0) + "</p>");
                                        out.print("<p>Chosen answer: " + pQ[i].getAnswer(answers[i]) + "</p>");
                                    }
                                    else {
                                        if(level[i] == 0) {
                                            out.print("<p>" + eQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + eQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + eQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                        else if(level[i] == 1) {
                                            out.print("<p>" + mQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + mQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + mQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                        else {
                                            out.print("<p>" + hQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + hQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + hQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                    }
                                }
                                out.print("</div>");
                        }
                        else {
                            out.print("This lesson hasn't been completed yet.");
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
            
                    out.print("<div id='attempt'>");
        
                    //If the student is assigned to this class
                    if(stud.hasClass(cls)) {
                        //And if the student owns this attempt
                        if(stud.getUsername().equals(a.getUsername())) {
                            //Get the lists of questions
                            Question[] pQ = l.getPlacementQuestions();
                            Question[] eQ = l.getEasyQuestions();
                            Question[] mQ = l.getMediumQuestions();
                            Question[] hQ = l.getHardQuestions();
            
                            //If attempt is complete show the results
                            if(a.isComplete()) {
                                int[] level = a.getQuestionLevels();
                                int[] answers = a.getAnswers();
                                boolean[] correct = a.getCorrect();
            
                                out.print("<h4>Overview</h4>");
                                out.print("<div id='overview'><ul>");
                                
                                for(int i = 0; i < level.length; i++) {
                                    //Print the correct color for each question and whether the student got it right
                                    if(level[i] == 0) {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='easy'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                    else if(level[i] == 1) {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='medium'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                    else {
                                                                
                                        out.print("<li>");
                                                                
                                        out.print("<div id='level' class='hard'>" + (i + 1) + "</div>");
                                                                
                                        if(correct[i]) {
                                            out.print("<div id='answer' class='correct'></div>");              
                                        }
                                        else {
                                            out.print("<div id='answer' class='incorrect'></div>");       
                                        }
                                                                
                                        out.print("</li>");
                                    }
                                }
            
                                out.print("</ul></div><br><br><br><br><br><div>");
                                                                
                                for(int i = 0; i < level.length; i++) {
            
                                    out.print("<h4>Question " + (i + 1) + "</h4>");
            
                                    if(i < 3) {
                                        out.print("<p>" + pQ[i].getQuestion() + "</p>");
                                        out.print("<p>Correct answer: " + pQ[i].getAnswer(0) + "</p>");
                                        out.print("<p>Chosen answer: " + pQ[i].getAnswer(answers[i]) + "</p>");
                                    }
                                    else {
                                        if(level[i] == 0) {
                                            out.print("<p>" + eQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + eQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + eQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                        else if(level[i] == 1) {
                                            out.print("<p>" + mQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + mQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + mQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                        else {
                                            out.print("<p>" + hQ[i - 3].getQuestion() + "</p>");
                                            out.print("<p>Correct answer: " + hQ[i - 3].getAnswer(0) + "</p>");
                                            out.print("<p>Chosen answer: " + hQ[i - 3].getAnswer(answers[i]) + "</p>");
                                        }
                                    }
                                }
                                out.print("</div>");
                            }
                            //Otherwise show the next question and answers
                            else {
                                //Otherwise get this questions number
                                int qNo = a.getCompleted();
                                
                                //Create an object to store this question
                                Question thisQuestion = null;
            
                                //If this question is not a placement question
                                if(qNo > 2) {
                                    //Get the question level and print the correct colour background
                                    //Then get the question and store
                                    int level = a.getLevel();
                                    if(level == 0) {
                                        out.print("<div id='question' class='easy'>");
                                        thisQuestion = eQ[qNo - 3];
                                    }
                                    if(level == 1) {
                                        out.print("<div id='question' class='medium'>");
                                        thisQuestion = mQ[qNo - 3];
                                    }
                                    if(level == 2) {
                                        out.print("<div id='question' class='hard'>");
                                        thisQuestion = hQ[qNo - 3];
                                    }
                                }
                                //Otherwise it is a placement question
                                else {
                                    //Print the correct colour for the placement question
                                    if(qNo == 0) {
                                        out.print("<div id='question' class='easy'>");
                                    }
                                    if(qNo == 1) {
                                        out.print("<div id='question' class='medium'>");
                                    }
                                    if(qNo == 2) {
                                        out.print("<div id='question' class='hard'>");
                                    }
                                    //Then get the question and store
                                    thisQuestion = pQ[qNo];
                                }
            
                                //If this question exists, print it
                                if(thisQuestion != null) {
                                    //Print the question
                                    out.print(thisQuestion.getQuestion());
            
                                    out.print("</div>");
            
                                    out.print("<div id='answers'><ul>");
                                    
                                    //Get the answers and shuffle
                                    String[] answers = Question.shuffleAnswers(thisQuestion.getAnswers());
            
                                    //For each answer print the submit button
                                    for(String s: answers) {
                                        out.print("<li >");
                                        out.print("<form action='attempt' method='POST' >");
                                        out.print("<input type='hidden' name='request' value='answerquestion'>");
                                        out.print("<input type='hidden' name='email' value='" + t.getEmail() + "'>");
                                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                                        out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                                        out.print("<input type='hidden' name='studuser' value='" + stud.getUsername() + "'>");
                                        out.print("<input type='hidden' name='attemptnumber' value='" + atn + "'>");
                                        out.print("<input type='hidden' name='answer' value='" + s + "'>");
                                        out.print("<input type='submit' value='" + s + "'/>");
                                        out.print("</form>");
                                        out.print("</li>");
                                    }
            
                                    out.print("</ul>");
                                }
                                //Otherwise print the question wasn't found
                                else {
                                    out.print("<p>Question not found!</p>");
                                }
            
                                out.print("</div>");
                            }
                        }  
                        //The logged in user doesn't own view this attempt
                        else {
                            out.print("<p>You don't have permission to view this attempt.</p>");
                        }
                    }
                    //The user isn't subscribed to this class
                    else {
                        out.print("<p>Sorry, you aren't subscribed to this class!</p>");
                    }
            
                    out.print("</div>");
                }
            }
            //Attempt doesn't exist
            else {
                out.print("<p>Sorry, that attempt doesn't exist.</p>");
            }
        }
        else {
        
        }
           
        %>
    </div>
        
</body>

</html>