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
        String usr = request.getParameter("u");
        String cls = request.getParameter("c");
        boolean classExists = false;
        if(usr!=null && cls!=null) {
           User u = HomeController.getUser(usr);
           if(u.isTeacher()) {
                Teacher t = (Teacher) u;
                if(t.hasClass(cls)) {
                    classExists = true;
                }
                else {
                    out.print("Sorry that class does not exist.");
                }
           } else {
                out.print("Sorry that user is not a teaching account.");
           }
           if(classExists) {
                if(thisUser.isTeacher()) {
                    Teacher t = (Teacher) thisUser;
                    if(t.getUsername().equals(usr)) {
                        out.print("Edit class");
                    }
                    else {
                        out.print("Teacher view");
                    }
                }
                else {
                    out.print("Student view");
                }
           }
        } else {
            //Display the classes that the user owns or is subscribed to
            out.print("All classes");
        }
        %>
        
    </div>
        
</body>
</html>