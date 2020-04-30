<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Ride</title>
</head>
<body>
<%
String resID = request.getParameter("resID"),action = request.getParameter("action"),connection_number = request.getParameter("connNum");
%>
	<script>
	
		window.onload = function() {
			document.forms["refresh"].submit();
		};
		
	</script>
	<% 
		
	   	Database db = new Database();
	   	Connection con = db.getConnection();
	   	Statement st = con.createStatement();
	   	st.executeUpdate("DELETE FROM Has_Ride_Origin_Destination_PartOf WHERE connection_number='" + connection_number + "'");
	   	st.close();
	   	db.closeConnection(con);
	 %>
	 
	<form id="refresh" action="modifyReservationsCR.jsp" method="post">
	<input type="hidden" name="resID" value="<%out.print(resID);%>">
	<input type="hidden" name="action" value="edit">
	</form>
</body>
</html>