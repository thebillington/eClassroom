<%@include file="/includes/users.jsp" %>
<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%
    if(thisUser == null) {
       response.sendRedirect("/");
    }   
    %>
        
    <%@ page session="true"%>
        
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/profile.js"></script>
    <script><%
        //If the request features a p parameter, switch to the given pane
        String pane = request.getParameter("p");
        if(pane == null) {
            //Do nothing
        }
        else if(pane.equals("edit")) {
            out.print("window.onload=edit;");
        }  
        else if(pane.equals("classes")) {
            out.print("window.onload=classes;");
        }  
    %></script>
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/profile.css" type="text/css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/profile-classes.css" type="text/css" />
    
    <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <div id="profileOptions">
            <ul>
                <li id="viewOp" onclick="view()">Overview</li>
                <li id="editOp" onclick="edit()">Edit Profile</li>
                <li id="classesOp" onclick=classes()>My Classes</li>
            </ul>
        </div>
        
        <div id="profileView">
            <p>Unique learner ID: <% out.print(thisUser.getID()); %></p>
            <p>Username: <% out.print(thisUser.getUsername()); %></p>
            <p>Email: <% out.print(thisUser.getEmail()); %></p>
            <p>DOB: <% out.print(thisUser.getDay() + "/" + thisUser.getMonth() + "/" + thisUser.getYear()); %></p>
            <p>First name: <% out.print(thisUser.getFname()); %></p>
            <p>Last name: <% out.print(thisUser.getLname()); %></p>
            <p>School: <% out.print(thisUser.getSchool()); %></p>
            <p>Age: <% out.print(thisUser.getAge()); %></p>
        </div>
        
        <div id="profileEdit">
             
            <p class="error">
            <%
            //Print the error message returned as a url parameter, if any
            String msg = request.getParameter("m");
            if(msg==null) {
               //Do nothing
            }
            else if(msg.equals("success")) {
               out.print("Details updated successfully.");
            }
            else if(msg.equals("badpass")) {
               out.print("Incorrect password, please try again.");
            }
            else if(msg.equals("fail")) {
               out.print("Something went wrong, try again later.");
            }
            %>
            </p>
            
            <form action="profile" method="POST" >
                
                <input type="hidden" name="request" value="updateuser">
                <input type="hidden" name="email" value="<% out.print(thisUser.getEmail()); %>">
                
                <p>Unique learner ID: <% out.print(thisUser.getID()); %></p>
                <p>Username: <% out.print(thisUser.getUsername()); %></p>
                <p>Email: <% out.print(thisUser.getEmail()); %></p>
                <p>DOB: <% out.print(thisUser.getDay() + "/" + thisUser.getMonth() + "/" + thisUser.getYear()); %></p>
                <p>First name: <input type="text" name="fname" value="<% out.print(thisUser.getFname()); %>"></p>
                <p>Last name: <input type="text" name="lname" value="<% out.print(thisUser.getLname()); %>"></p>
                <p>School: <input type="text" name="school" value="<% out.print(thisUser.getSchool()); %>"></p>
                
                <p>Confirm Password: <input type="password" name="password" value="password"></p>
                
                <input type="submit" />
                
            </form>
            
        </div>
        
        <div id="classes">
            
            <%
            //Get the classes for the student or teacher depending on User type
            List<SchoolClass> classes;
            if(thisUser.isTeacher()) {
                Teacher t = (Teacher) thisUser;
                classes = t.getClasses();
                //Print form to create a new class
                out.print("<form action='profile' method='POST' >");
                out.print("<input type='hidden' name='request' value='newclass'>");
                out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                out.print("Class name: <input type='text' name='classname' value='Class name'> ");
                out.print("<input type='submit' value='Create class'/>");
                out.print("</form>");
            }
            else {
                Student s = (Student) thisUser;
                classes = s.getClasses();
                //Print form to subscribe to a class
                out.print("<form action='profile' method='POST' >");
                out.print("<input type='hidden' name='request' value='searchclass'>");
                out.print("<input type='hidden' name='email' value='" + thisUser.getEmail() + "'>");
                out.print("Subscribe: <input type='text' name='classname' value='Class name'> ");
                out.print("<input type='text' name='teacher' value='Teachers username'> ");
                out.print("<input type='submit' value='Subscribe'/>");
                out.print("</form>");
            }
            %>
             
            <p class="error">
                
            <%
            //Print the error message returned as a url parameter, if any
            if(msg == null) {
                //Do nothing
            }
            else if(msg.equals("classexists")) {
                out.print("A class with that name already exists!");
            }
            else if(msg.equals("cdsuccess")) {
               out.print("Class deleted successfully.");
            }
            else if(msg.equals("cdfail")) {
               out.print("Something went wrong, try again later.");
            }
            else if(msg.equals("subscribed")) {
               out.print("You are already subscribed to that class.");
            }
            else if(msg.equals("subfail")) {
               out.print("Something drastic went wrong, please contact an administrator.");
            }
            else if(msg.equals("noclass")) {
               out.print("Sorry, that class does not exist!.");
            }
            else if(msg.equals("noteacher")) {
               out.print("Sorry that user is not a teacher!");
            }
            else if(msg.equals("nouser")) {
               out.print("Sorry that user does not exist!");
            }
            else if(msg.equals("unsubsuccess")) {
               out.print("Unsubscribed successfully!");
            }
            %>
            </p>
            
            <%
            //If the user is not subscribed to any classes, give them a prompt based on user type
            if(classes.size() == 0) {
                if(thisUser.isTeacher()) {
                    out.print("<p>Looks like you haven't created any classes yet, click on 'create class' to get started.</p>");
                }
                else {
                    out.print("<p>Looks like you haven't subscribed to any classes yet. Add a class name and teachers username to get started.</p>");
                }
            }
            //Otherwise print out a list of their classes
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
            %>
            
            
        </div>
        
    </div>
        
</body>
</html>