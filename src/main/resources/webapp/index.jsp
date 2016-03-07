<html>
<%@ page session="true"%>
    <head>
        <link rel="stylesheet" href="style.css">
    <title>Test Page</title>
    </head>
    
<body>
<jsp:useBean id='lesson' scope='session' class='lessons.Lesson' type="lessons.Lesson" />
    
    <p style = "text-align: center; top: 2px; color: red;"><jsp:getProperty name="lesson" property="error"/></p>

</body>
</html>