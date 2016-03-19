<html>
<%@ page session="true"%>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <title>eClassroom Homepage</title>
    </head>
    
<body>

    <jsp:useBean id='lesson' scope='session' class='lessons.Lesson' type="lessons.Lesson" />
    
    <p style = "text-align: center; top: 2px; color: red;"><jsp:getProperty name="lesson" property="error"/></p>
    
    <p>Welcome .</p>

</body>
</html>