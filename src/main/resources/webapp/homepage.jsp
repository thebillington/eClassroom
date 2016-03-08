<html>
<%@ page session="true"%>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <title>eClassroom Homepage</title>
    </head>
    
<body>

    <jsp:useBean id='lesson' scope='session' class='lessons.Lesson' type="lessons.Lesson" />
    
    <p>Welcome </p>

</body>
</html>