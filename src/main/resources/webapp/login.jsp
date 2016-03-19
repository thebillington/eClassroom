<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%@ page session="true"%>
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" type="text/css" />
    
<%@include file="/includes/header.jsp" %>
    
    <div id="login">
    
        <div id="loginBox">
        
            <h3>Login</h3>
            
            <form action="login" method="POST" >
                
                <input type="hidden" name="request" value="login">
                
                Email/Username: <input type="text" name="email" value="thebillington"><br /><br />
                Password: <input type="password" name="password" value="irule"><br /><br />
                
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