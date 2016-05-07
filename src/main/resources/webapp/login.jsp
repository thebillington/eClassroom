<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%@ page session="true"%>
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" type="text/css" />
        <%@include file="/includes/header.jsp" %>
    
    <div id="login">
    
        <div id="loginBox">
            
            <p class="error">
            <%
            //Print the error message returned as a url parameter, if any
            String msg = request.getParameter("m");
            if(msg==null) {
               //Do nothing
            }
            else if(msg.equals("success")) {
               out.print("Account created succesfully.");
            }
            else if(msg.equals("user")) {
               out.print("Sorry, that username is already in use.");
            }
            else if(msg.equals("email")) {
               out.print("Sorry, that email is already in use.");
            }
            else if(msg.equals("bademail")) {
               out.print("Sorry, there is no account on record with that username/email.");
            }
            else if(msg.equals("badpass")) {
               out.print("Sorry, you have entered an incorrect password.");
            }
            %>
            </p>
        
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