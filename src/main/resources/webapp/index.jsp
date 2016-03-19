<%
Cookie[] cookies = request.getCookies();
Cookie cookie = null;
if( cookies != null ){
   for (int i = 0; i < cookies.length; i++){
        if(cookies[i].getName().equals("user")){
            cookie = cookies[i];
        }
    }   
}
%>

<html>
<%@ page session="true"%>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <title>eClassroom Homepage</title>
    </head>
    
<body>
    
    <%
    if(cookie != null) {
       out.println("Welcome " + cookie.getValue());
    }
    else {
       out.println("<p>Welcome to eClassroom. Click <a href='login'>here</a> to login or signup!");
    }
    %>

</body>
</html>