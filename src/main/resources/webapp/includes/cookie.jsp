<%@ page import="users.User" %>
<%@ page import="index.HomeController" %>
<%
Cookie[] cookies = request.getCookies();
Cookie cookie = null;
User thisUser = null;
if( cookies != null ){
   for (int i = 0; i < cookies.length; i++){
        if(cookies[i].getName().equals("user")){
            cookie = cookies[i];
            thisUser = HomeController.retrieveUser(cookie.getValue());
        }
    }   
}
%>