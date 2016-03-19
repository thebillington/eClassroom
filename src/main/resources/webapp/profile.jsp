<%@include file="/includes/cookie.jsp" %>

<html>
    
    <%
    if(thisUser == null) {
       response.sendRedirect("/");
    }   
    %>
        
    <%@ page session="true"%>
        
    <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/profile.js"></script>
        
    <head>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/profile.css" type="text/css" />
    
    <%@include file="/includes/header.jsp" %>
        
    <div id="main">
        
        <div id="profileOptions">
            <ul>
                <li id="viewOp" onclick="view()">Overview</li>
                <li id="editOp" onclick="edit()">Edit Profile</li>
                <li id="classesOp" onclick=classes()>My Classes</li>
                <li id="workOp" onclick="work()">Work Due</li>
                <li id="deleteOp" onclick="deleteUser()">Delete Account</li>
            </ul>
        </div>
        
        <div id="profileView">
            
        </div>
        
        <div id="profileEdit">
            Edit
        </div>
        
        <div id="classes">
            Classes
        </div>
        
        <div id="work">
            Work
        </div>
        
        <div id="delete">
            Delete
        </div>
        
    </div>
        
</body>
</html>