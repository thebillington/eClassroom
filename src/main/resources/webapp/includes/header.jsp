        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" type="text/css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css" type="text/css" />
    <title>eClassroom</title>
    </head>
    
<body>

<div id="header">
    
    <ul>
        <li><a href="/">Home</a></li>
        <li><a>Classes</a></li>
    
    <%
    if(cookie != null) {
       out.println("<li><a href='profile'>" + thisUser.getUsername() + "</a></li>");
       out.println("<li class='logout'><a href='/logout'>Logout</a></li>");
    }
    else {
       out.println("<li><a href='login'>Login/Signup</a><li>");
    }
    %>
    
    </ul>
        
</div>