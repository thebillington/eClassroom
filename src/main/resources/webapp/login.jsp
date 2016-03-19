<html>
<%@ page session="true"%>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <title>Test Page</title>
    </head>
    
<body>
    
<jsp:useBean id='lesson' scope='session' class='lessons.Lesson' type="lessons.Lesson" />
    
    <p style = "text-align: center; top: 2px; color: red;"><jsp:getProperty name="lesson" property="error"/></p>
    
    <div style="position: absolute; top: 10%; width: 40%; height: 80%; border: 2px solid black; left: 30%; border-radius: 10px;">
    
        <div style="position:absolute; top:100px; width: 80%; left: 10%;">
        
            <h3>Login</h3>
            
            <form action="login" method="POST" >
                
                <input type="hidden" name="request" value="login">
                
                Email/Username: <input type="text" name="email" value="email"><br /><br />
                Password: <input type="password" name="password" value="password"><br /><br />
                
                <input type="submit" />
                
            </form>
            
            <br /><br />
            
            <h3>Sign up</h3>
            
            <form action="login" method="POST" >
                
                <input type="hidden" name="request" value="signup">
                
                Email: <input type="text" name="email" value="email"><br /><br />
                Username: <input type="text" name="username" value="username"><br /><br />
                Password: <input type="password" name="password" value="password"><br /><br />
                
                DOB: <input type="text" name="day" value="dd">
                <input type="text" name="month" value="mm">
                <input type="text" name="year" value="yyyy"><br /><br />
                
                <input type="radio" name="type" value="teacher">Teacher
                <input type="radio" name="type" value="student">Student<br /><br />
                
                <input type="submit" />
                
            </form>
            
        </div>
        
    </div>

</body>
</html>