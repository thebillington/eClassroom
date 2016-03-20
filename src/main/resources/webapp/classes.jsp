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
        Class
    </div>
        
</body>
</html>