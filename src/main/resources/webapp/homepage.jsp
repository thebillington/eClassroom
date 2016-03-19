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

    <jsp:useBean id='lesson' scope='session' class='lessons.Lesson' type="lessons.Lesson" />
    
    <p style = "text-align: center; top: 2px; color: red;"><jsp:getProperty name="lesson" property="error"/></p>
    
    <%
    if(cookie != null) {
       out.println("<p>Hello " + cookie.getValue() + "</p>");
    }
    else {
       out.println("<p>Hello " + cookie.getValue() + "</p>");
    }
    %>

</body>
</html>