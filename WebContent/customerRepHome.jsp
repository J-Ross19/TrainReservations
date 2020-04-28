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
      <title>Train Employee Home</title>
   </head>
   <body>
   	<p>You are not logged in</p><br/>
   	<form action="login.jsp" method="get">
        <button>Log in</button>
	</form>
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
   	<form action="repMessaging.jsp" method="get">
        <button>Reply to Customer Messages</button>
	</form>
	<form action="reservations.jsp" method="get">
        <button>Access Reservations</button>
	</form>
	<form action="schedules.jsp" method="get">
        <button>Access Train Schedules</button>
	</form>
    <br/>
    <form action="logout.jsp" method="get">
        <button>Log Out</button>
	</form>

   </body>
</html>
<%
    }
%>
