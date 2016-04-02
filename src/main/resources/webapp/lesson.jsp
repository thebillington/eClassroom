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
                //Print the title
                out.print("<div id='title'><h3>" + lsn + "</h3></div>");
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