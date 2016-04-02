<%@include file="/includes/users.jsp" %>
<%@include file="/includes/lessons.jsp" %>
<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%
    if(thisUser == null) {
       response.sendRedirect("/");
    }   
    %>
        
    <%@ page session="true"%>
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/classes.css" type="text/css" />
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
           
                    //Print the title
                    out.print("<div id='title'><h3>" + cls + "</h3></div>");
           
                    //Cast the logged in user to a teacher object
                    Teacher t = (Teacher) thisUser;
           
                    //If the username of this teacher equals the username of the teacher that owns the class
                    if(t.getUsername().equals(usr)) {
                        
                        //Create the lessons section
                        out.print("<div id='lessons'><h3>Lessons</h3>");
        
                        //Print the form to create a new lesson
                        out.print("<form action='classes' method='POST' >");
                        out.print("<input type='hidden' name='request' value='addlesson'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                        out.print("Lesson name: <input type='text' name='lessonname' value='Lesson name'> ");
                        out.print("<input type='submit' value='Create lesson'/>");
                        out.print("</form>");
           
                        //Get this classes lessons as a list
                        List<Lesson> lessons = sc.getLessons();
        
                        out.print("<p class='error'>");
                        //Print the error message returned as a url parameter, if any
                        String msg = request.getParameter("m");
                        if(msg==null) {
                            //Do nothing
                        }
                        else if(msg.equals("lasuccess")) {
                            out.print("Lesson added successfully.");
                        }
                        else if(msg.equals("lexists")) {
                            out.print("A lesson with that name already exists.");
                        }
                        else if(msg.equals("ldsuccess")) {
                            out.print("Lesson deleted successfully.");
                        }
                        else if(msg.equals("ldfail")) {
                            out.print("Couldn't delete lesson.");
                        }
                        out.print("</p>");
                        
                        //If there are no lessons, print a message
                        if(lessons.size() == 0) {
                            out.print("You haven't created any lessons yet.");
                        }
                        //Otherwise give them a list of lessons to select from
                        else {
                            out.print("<ul>");
                            for(Lesson l: lessons) {
                                out.print("<form action='classes' method='POST'>");
                                out.print("<li><a href='/lesson?l=" + l.getName() + "&u=" + l.getUsername() + "&c=" + l.getClassName() + "'>" + l.getName() + "</a> ");
                                out.print("<input type='hidden' name='request' value='deletelesson'>");
                                out.print("<input type='hidden' name='email' value='" + l.getUsername() + "'>");
                                out.print("<input type='hidden' name='classname' value='" + l.getClassName() + "'>");
                                out.print("<input type='hidden' name='lessonname' value='" + l.getName() + "'>");
                                out.print("<input type='submit' value='Delete'/>");
                                out.print("</form>");
                                out.print("</li>");
                            }      
                            out.print("</ul>");
                        }
                        
                        out.print("</div>");
                        
                        //Create the student section
                        out.print("<div id='students'><h3>Students</h3>");
                        
                        //Get the students subsribed to the class
                        List<Student> students = sc.getStudents();
                        
                        //If there are no students, print a message
                        if(students.size() == 0) {
                            out.print("No students are subscribed to this class.");
                        }
                        //Otherwise print a list of students, with the option to unsubscribe them from the class
                        else {
                            out.print("<ul>");
                            for(Student s: students) {
                                out.print("<form action='profile' method='POST'>");
                                out.print("<li>" + s.getUsername());
                                out.print("<input type='hidden' name='request' value='deleteclass'>");
                                out.print("<input type='hidden' name='email' value='" + s.getEmail() + "'>");
                                out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'>");
                                out.print(" <input type='submit' value='Unsubscribe'/>");
                                out.print("</form>");
                                out.print("</li>");
                            }
                            out.print("</ul>");
                        }
                        out.print("</div>");
                    }
                    //Otherwise show a teacher view for another teachers lesson
                    else {
                        out.print("Teacher view");
                    }
                }
                //Otherwise the user is a student
                else {
        
                    //Get the user object as a teacher, so that we can return the class
                    Teacher t = (Teacher) u;
                                    
                    //Cast the logged in user to a student object
                    Student stud = (Student) thisUser;
        
                    //Print the title
                    out.print("<form action='profile' method='POST' >");
                    out.print("<div id='title'><h3>" + cls + " ");
        
                    if(stud.hasClass(cls)) {
                        out.print("<input type='hidden' name='request' value='deleteclass'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'> ");
                        out.print("<input type='hidden' name='teacher' value='" + sc.getTeacher() + "'> ");
                        out.print("<input type='submit' value='Unsubscribe'/>");
                        out.print("</form>");
                    }
                    else {
                        out.print("<input type='hidden' name='request' value='searchclass'>");
                        out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                        out.print("<input type='hidden' name='classname' value='" + sc.getName() + "'> ");
                        out.print("<input type='hidden' name='teacher' value='" + sc.getTeacher() + "'> ");
                        out.print("<input type='submit' value='Subscribe'/>");
                        out.print("</form>");   
                    }
                    out.print("</h3></div>");
                                    
                    //Create the lessons section
                    out.print("<div id='lessons'><h3>Lessons</h3>");
           
                    //Get this classes lessons as a list
                    List<Lesson> lessons = sc.getLessons();
                    
                    //If there are no lessons, print a message
                    if(lessons.size() == 0) {
                        out.print("This class doesn't have any lessons yet.");
                    }
                    //Otherwise give them a list of lessons to select from
                    else {
                        out.print("<ul>");
                        if(stud.hasClass(cls)) {
                            for(Lesson l: lessons) {
                                out.print("<li><a href='/lesson?l=" + l.getName() + "&u=" + l.getUsername() + "&c=" + l.getClassName() + "'>" + l.getName() + "</a></li>");
                            }
                        }
                        else {
                            for(Lesson l: lessons) {
                                out.print("<li>" + l.getName() + "</li>");
                            }
                        }
                        out.print("</ul>");
                    }
                        
                    out.print("</div>");
                        
                    //Create the student section
                    out.print("<div id='students'><h3>Students</h3>");
                        
                    //Get the students subsribed to the class
                    List<Student> students = sc.getStudents();
                        
                    //If there are no students, print a message
                    if(students.size() == 0) {
                        out.print("No students are subscribed to this class.");
                    }
                    //Otherwise print a list of students
                    else {
                        out.print("<ul>");
                        for(Student s: students) {
                            out.print("<li>" + s.getUsername() + "</li>");
                        }
                        out.print("</ul>");
                    }
                    out.print("</div>");
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
                    out.print("<li><a href='/classes?c=" + c.getName() + "&u=" + c.getTeacher() + "'>" + c.getName() + "</a> ");
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