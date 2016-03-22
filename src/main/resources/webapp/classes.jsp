<%@include file="/includes/users.jsp" %>
<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%
    if(thisUser == null) {
       response.sendRedirect("/");
    }   
    %>
        
    <%@ page session="true"%>
        
    <head>
    
    <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <%
        //Get the u and c parameters as new strings
        String usr = request.getParameter("u");
        String cls = request.getParameter("c");
        boolean classExists = false;
        //If the url parameters have a request for a specific class, show class details based on:
        // 1: The user is a teacher and owns the class
        // 2: The user is a teacher and doesn't own the class
        // 3: The user is a student and is subscribed to the class
        // 4: The user is a student and isn't subscribed to the class
        if(usr!=null && cls!=null) {
           //Try get the given username as a new object
           User u = HomeController.getUser(usr);
           //Create an object to store the class in if it exists, and initialise to null
           SchoolClass sc = null;
           //Check that the user exists
           if(u != null) {
                //If the user is a teacher
                if(u.isTeacher()) {
                    //Cast the user to a teacher object
                    Teacher t = (Teacher) u;
                    //Check if the class exists
                    if(t.hasClass(cls)) {
                        //If so set classExists to true
                        classExists = true;
                        //And get the class stored in our sc variable
                        sc = t.getClass(cls);
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
           
           //If the class exists
           if(classExists) {
                //If the logged in user is a teacher
                if(thisUser.isTeacher()) {
                    //Cast the logged in user to a teacher object
                    Teacher t = (Teacher) thisUser;
                    //If the username of this teacher equals the username of the teacher that owns the class
                    if(t.getUsername().equals(usr)) {
                        
                    }
                    //Otherwise show a teacher view for another teachers lesson
                    else {
                        out.print("Teacher view");
                    }
                }
                //Otherwise the user is a student
                else {
                    //Cast the logged in user to a student object
                    Student s = (Student) thisUser;
                    out.print("Student view");
                }
           }
        }
        //There is no request to view a specific class, so display a list of the users owned/subscribed classes
        else {
            //Create a variable to store the classes
            List<SchoolClass> classes;
            //If user is a teacher cast to Teacher and get the classes
            if(thisUser.isTeacher()) {
                Teacher t = (Teacher) thisUser;
                classes = t.getClasses();
            }
            //If user is a student cast to Student and get the classes 
            else {
                Student s = (Student) thisUser;
                classes = s.getClasses();
            }
            //If the user has no classes, send them to the profile classes page
            if(classes.size() == 0) {
                out.print("<p>Looks like you don't have any classes yet, click <a href='/profile?p=classes'>here</a> to get started.</p>");
            }
            //Otherwise give them a list of classes to select from
            else {
                out.print("<ul>");
                for(SchoolClass c: classes) {
                    out.print("<form action='profile' method='POST'>");
                    out.print("<li><a href='/classes?c=" + c.getName() + "&u=" + thisUser.getUsername() + "'>" + c.getName() + "</a> ");
                    out.print("<input type='hidden' name='request' value='deleteclass'>");
                    out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                    out.print("<input type='hidden' name='classname' value='" + c.getName() + "'>");
                    //Print delete message for teacher or unsubscribe message for student
                    if(thisUser.isTeacher()) {
                        out.print("<input type='submit' value='Delete'/>");
                    } else {
                        out.print("<input type='submit' value='Unsubscribe'/>");
                    }
                    out.print("</form>");
                    out.print("</li>");
                }
                out.print("</ul>");
            }
        }
        %>
        
    </div>
        
</body>
</html>