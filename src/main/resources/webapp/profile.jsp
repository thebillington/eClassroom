<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%
    if(thisUser == null) {
       response.sendRedirect("/");
    }   
    %>
    
    <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <p>Welcome <%out.print(thisUser.getUsername());%> to your profile page.</p>
        
    </div>
        
        
</body>
</html>