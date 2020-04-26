<%
    if ((session.getAttribute("user") == null)) { // Create page for user not logged in
%>
<!DOCTYPE html>
<html>
   <head>
      <title>Train Employee Home</title>
   </head>
   <body>
   	<p>You are not logged in</p><br/>
	<button onclick="window.location.href='login.jsp';">Log in</button>
   </body>
</html>

<%
	} else { // Create page for user that is logged in
%>
<!DOCTYPE html>
<html>
   <head>
      <title>Train Employee Home</title>
   </head>
   <body>
   	<p>Logged in as <%=session.getAttribute("user")%></p>
    <button onclick="window.location.href='messaging.jsp';">Messages</button>
    <button onclick="window.location.href='repMessaging.jsp';">Reply to Messages</button><br/>
    <button onclick="window.location.href='logout.jsp';">Log Out</button>
    

   </body>
</html>
<%
    }
%>
