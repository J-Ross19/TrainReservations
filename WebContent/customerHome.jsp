<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<!DOCTYPE html>
<html>
   <head>
      <title>Train HomePage</title>
   </head>
   <body>
   	<p>Welcome <%=session.getAttribute("user")%>!</p>
   	<button onclick="window.location.href='messaging.jsp';">Message customer support</button>
	<button onclick="window.location.href='logout.jsp';">Log Out</button>
   	
    
     
   </body>
</html>
<%
    }
%>
