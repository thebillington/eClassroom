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
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/profile.css" type="text/css" />
    
    <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <div id="profileOptions">
            <ul>
                <li id="viewOp" onclick="view()">Overview</li>
                <li id="editOp" onclick="edit()">Edit Profile</li>
                <li id="classesOp" onclick=classes()>My Classes</li>
                <li id="workOp" onclick="work()">Work Due</li>
                <li id="deleteOp" onclick="deleteUser()">Delete Account</li>
            </ul>
        </div>
        
        <div id="profileView">
            
            <p class="error">
            <%
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
            
            <form action="profile" method="POST" >
                
                <input type="hidden" name="request" value="update">
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
            List<SchoolClass> classes;
            if(thisUser.isTeacher()) {
                Teacher t = (Teacher) thisUser;
                classes = t.getClasses();
            }
            else {
                Student s = (Student) thisUser;
                classes = s.getClasses();
            }
            if(classes.size() == 0) {
                if(thisUser.isTeacher()) {
                    out.print("<p>Looks like you haven't created any classes yet, click on 'new class' to get started.</p>");
                }
                else {
                    out.print("<p>Looks like you haven't subscribed to any classes yet, search for a class to get started.</p>");
                }
            }
            for(SchoolClass c: classes) {
                out.print(c.getName());
            }
            %>
            
            
        </div>
        
        <div id="work">
            Work
        </div>
        
        <div id="delete">
            Delete
        </div>
        
    </div>
        
</body>
</html>