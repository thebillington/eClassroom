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
           
                        out.print("<ul>");
                        //Print the form to update each question
                        out.print("<li class='easy'>");
                        out.print("<form action='lesson' method='POST' >");
                        out.print("<input type='hidden' name='request' value='updateq'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                        out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                        out.print("<input type='hidden' name='questiontype' value='placement'>");
                        out.print("<input type='hidden' name='location' value='0'>");
                        out.print("Question: <input type='text' name='question' value='" + pq[0].getQuestion() + "'><br /><br />");
                        out.print("Correct Answer: <input type='text' name='corans' value='" + pq[0].correctAnswer() + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansone' value='" + pq[0].getAnswer(1) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='ianstwo' value='" + pq[0].getAnswer(2) + "'><br /><br />");
                        out.print("Incorrect Answer: <input type='text' name='iansthree' value='" + pq[0].getAnswer(3) + "'><br /><br />");
                        out.print("<input type='submit' value='Update Question'/>");
                        out.print("</form>");
                        out.print("</li>");
                        out.print("<li class='medium'>" + pq[1].getQuestion() + "</li>");
                        out.print("<li class='hard'>" + pq[2].getQuestion() + "</li>");
                        out.print("</ul>");
                        
                        out.print("</div>");
                    }
                }
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