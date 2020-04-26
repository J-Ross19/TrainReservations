<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    if ((session.getAttribute("user") == null)) { // Create page for user not logged in
%>
<!DOCTYPE html>
<html>
   <head>
      <title>Train HomePage</title>
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
