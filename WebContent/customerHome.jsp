<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Train HomePage</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
		<style>
		body {
		margin: 0 !important;
		}
		</style>
   </head>
   <body>
   	<%
    	if ((session.getAttribute("user") == null))
    	{
    		response.sendRedirect("notFound.jsp");
    	}
	%>
   	<p>Welcome <%=session.getAttribute("user")%>!</p>
   	<button onclick="window.location.href='customerReservations.jsp';">Manage Reservations</button>
   	<button onclick="window.location.href='messaging.jsp';">Message customer support</button>
	<button onclick="window.location.href='logout.jsp';">Log Out</button>



   </body>
</html>