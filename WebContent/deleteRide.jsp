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
	   	
	   	// Check if we are deleting just the ride
	   	int numOldRows = 0;
	   	Statement findRows = con.createStatement();
		ResultSet oldRows = findRows.executeQuery("SELECT count(*) AS 'count' FROM Has_Ride_Origin_Destination_PartOf WHERE reservation_number in" 
				+	" (SELECT reservation_number from Has_Ride_Origin_Destination_PartOf where connection_number = '" + connection_number + "')" 
				+	" group by reservation_number;");
		if (oldRows.next()) {
			numOldRows = Integer.parseInt(oldRows.getString("count"));
		} else {
			out.print("ERROR! undefined behavior");
		}
	   	oldRows.close();
	   	findRows.close();
	   	
	   	
	   	Statement st = con.createStatement();
	   	if (numOldRows > 1) {
	   		st.executeUpdate("DELETE FROM Has_Ride_Origin_Destination_PartOf WHERE connection_number='" + connection_number + "'");
	   	} else {
	   		String query = "DELETE FROM Reservation_Portfolio WHERE reservation_number in"
	   			+	" (SELECT reservation_number from Has_Ride_Origin_Destination_PartOf where connection_number = '" + connection_number + "')";
	   		st.executeUpdate(query);
	   	}
	   	st.close();
	   	db.closeConnection(con);
	 %>
	 
	<form id="refresh" action="modifyReservationsCR.jsp" method="post">
	<input type="hidden" name="resID" value="<%out.print(resID);%>">
	<input type="hidden" name="action" value="edit">
	</form>
</body>
</html>