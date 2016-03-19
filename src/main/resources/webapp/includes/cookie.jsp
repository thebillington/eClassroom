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