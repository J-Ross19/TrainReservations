<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
      <title>Reservations</title>
      <style>
      	table {
      		width: 100%;
      	}
      	table, th, td {
      		border: 1px solid black;
			border-collapse: collapse;
		}
		th, td {
			text-align: center;
		}
		table tr:nth-child(even) {
			background-color: #eee;
		}
		table tr:nth-child(odd) {
			background-color: #fff;
		}
		table th {
			background-color: aqua;
			color: black;
		}
      </style>
   </head>
   <body>
   	<form action="customerRepHome.jsp" method="get">
        <button>Home</button>
	</form>
   	<h3>Search by Reservation Number:</h3>
   	<form action="reservations.jsp" method="post">
  		<label for="resID">Reservation Number:</label>
 		<input type="text" name="resID"><br/><br/>
  		<input type="submit" value="Submit">
	</form>
    <br/>
    <h3>Add Reservation</h3>
    <form method="post" action="some_page" class="inline">
		<input type="hidden" name="extra_submit_param" value="extra_submit_value">
		<button type="submit" name="submit_param" value="submit_value" class="link-button">
			ADD
		</button>
	</form>
    <h3>Train Reservations:</h3>
    <form action="reservations.jsp" method="get">
        <button>Reset</button>
	</form>
	<br/>
    <%
    
	try {

		Database db = new Database();
	    Connection con = db.getConnection();
	    Statement stmt = con.createStatement();
	    
		
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query = "SELECT * FROM Reservation_Portfolio join Has_Ride_Origin_Destination_PartOf using (reservation_number)";
		
		// Check if username was set
		String resID = request.getParameter("resID");
		
		//request.setAttribute("empid", "1234"); ENDJSP
		//<jsp:include page="/servlet/MyServlet" flush="true"/>
		
		// If there is a username
		if (resID != null) {
			query += " WHERE reservation_number = \'" + resID + "\'";
		}
		
		//Execute query against the database.
		ResultSet rs = stmt.executeQuery(query);
		
		
		//Make an HTML table to show the results in:
		out.print("<table style=\'border: 1px solid black\' align:\'center\'>");

		//make header row
		out.print("<tr>");
		//make header columns
		out.print("<th>Reservation Number</td>");
		out.print("<th>Username</td>");
		out.print("<th>Type of Reservation</td>");
		out.print("<th>Reservation Created</td>");
		out.print("<th>Booking Fee</td>");
		out.print("<th>Boarding Class</td>");
		out.print("<th>Seat Number</td>");
		out.print("<th>Transit Line</td>");
		out.print("<th>Origin Station ID</td>");
		out.print("<th>Destination Station ID</td>");
		//out.print("<th>Edit</td>");
		//out.print("<th>Remove</td>");

    	out.print("</tr>");
    	
		//parse out the results
		while (rs.next()) {
			
			// Create row of data
			out.print("<tr>");
			
			out.print("<td>");
			out.print(rs.getInt("reservation_number"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("username"));
			out.print("</td>");
			
			// Type of Reservation
			String typeOfRes = "";
			if (rs.getInt("isMonthly") == 1) {
				typeOfRes = "Monthly";
			} else if (rs.getInt("isWeekly") == 1) {
				typeOfRes = "Weekly";
			} else if (rs.getInt("isRoundTrip") == 1) {
				typeOfRes = "Round Trip";
			} else {
				typeOfRes = "Single Ride";
			}
			out.print("<td>");
			out.print(typeOfRes);
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("date_made"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getDouble("booking_fee"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("class"));
			out.print("</td>");			
			
			out.print("<td>");
			out.print(rs.getString("seat_number"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("transit_line_name"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("origin_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("destination_id"));
			out.print("</td>");
			
			// Create edit functionality
			
			// Create remove functionality



			out.print("</td>");
			
			out.print("</tr>");

		}
		out.print("</table>");

		//close the connection.
		stmt.close();
	    rs.close();
    	db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}
    
    
    %>
    
   </body>
</html>