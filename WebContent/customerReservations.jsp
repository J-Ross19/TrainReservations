<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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

	<!-- TODO: Implement an option to cancel current reservations -->

	<%
		if ((String) session.getAttribute("user") == null) {
		String redirectURL = "http://localhost:8080/Login/login.jsp";
		response.sendRedirect(redirectURL);
	}
	%>

	<h3>Reservations</h3>

	<p>
		Welcome, <% out.print((String) session.getAttribute("user"));%>
	</p>

	<button onclick="window.location.href='reservationsCreate.jsp';">Make a New Reservation</button>

	<br>

	<h4>View Reservations</h4>

	<% 
		Database db = new Database();
		Connection con = db.getConnection();
	%>

	<h5>Current Reservations</h5>
	<!-- Should let an individual see which reservations they have made that are pending -->
	
	<%
	
	//temporary
		Statement stmt = con.createStatement();

		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query = "SELECT * FROM Customer AS C join Reservation_Portfolio AS R using (username)"
		+ " join Has_Ride_Origin_Destination_PartOf AS H using (reservation_number)"
		+ " join Schedule_Origin_of_Train_Destination_of_Train_On AS S using (transit_line_name)"
		+ " join Train AS T on (S.train_id = T.id);";

		//Execute query against the database.
		ResultSet rs = stmt.executeQuery(query);
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make header row
		out.print("<tr>");
		//make header columns
		out.print("<th>Reservation Number</td>");
		out.print("<th>Username</td>");
		out.print("<th>Customer Name</td>");
		out.print("<th>Type of Reservation</td>");
		out.print("<th>Reservation Created</td>");
		out.print("<th>Booking Fee</td>");
		out.print("<th>Transit Line</td>");
		out.print("<th>Train ID</td>");
		out.print("<th>Boarding Class</td>");
		out.print("<th>Seat Number</td>");
		out.print("<th>Origin Station ID</td>");
		out.print("<th>Destination Station ID</td>");

		out.print("</tr>");
	
		//Add rows
		while (rs.next()) {
			// Create row of data
			out.print("<tr>");

			out.print("<td>");
			out.print(rs.getInt("reservation_number"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("username"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("name_firstname") + " " + rs.getString("name_lastname"));
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
			out.print(rs.getString("transit_line_name"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("train_id"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("class"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("seat_number"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("H.origin_id"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs.getString("H.destination_id"));
			out.print("</td>");

			out.print("</tr>");
		}
		rs.close();
		stmt.close();
	out.print("</table>");
	
	/* 
	* Copied from Ronak's code on the "reservations.jsp" sheet
	* This code should get a list of all reservations of the user
	*/
	try {

		Statement stmt1 = con.createStatement();

		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query1 = "SELECT * FROM Customer AS C join Reservation_Portfolio AS R using (username)"
		+ " join Has_Ride_Origin_Destination_PartOf AS H using (reservation_number)"
		+ " join Schedule_Origin_of_Train_Destination_of_Train_On AS S using (transit_line_name)"
		+ " join Train AS T on (S.train_id = T.id)"
		+ " WHERE date_made = \"" + java.time.LocalDate.now() + "\""
		+ " AND username = \"" + (String) session.getAttribute("user") + "\";";

		//Execute query against the database.
		ResultSet rs1 = stmt1.executeQuery(query1);
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make header row
		out.print("<tr>");
		//make header columns
		out.print("<th>Reservation Number</td>");
		out.print("<th>Username</td>");
		out.print("<th>Customer Name</td>");
		out.print("<th>Type of Reservation</td>");
		out.print("<th>Reservation Created</td>");
		out.print("<th>Booking Fee</td>");
		out.print("<th>Transit Line</td>");
		out.print("<th>Train ID</td>");
		out.print("<th>Boarding Class</td>");
		out.print("<th>Seat Number</td>");
		out.print("<th>Origin Station ID</td>");
		out.print("<th>Destination Station ID</td>");

		out.print("</tr>");
	
		//Add rows
		while (rs1.next()) {
			// Create row of data
			out.print("<tr>");

			out.print("<td>");
			out.print(rs1.getInt("reservation_number"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("username"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("name_firstname") + " " + rs1.getString("name_lastname"));
			out.print("</td>");

			// Type of Reservation
			String typeOfRes = "";
			if (rs1.getInt("isMonthly") == 1) {
				typeOfRes = "Monthly";
			} else if (rs1.getInt("isWeekly") == 1) {
				typeOfRes = "Weekly";
			} else if (rs1.getInt("isRoundTrip") == 1) {
				typeOfRes = "Round Trip";
			} else {
				typeOfRes = "Single Ride";
			}
			out.print("<td>");
			out.print(typeOfRes);
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("date_made"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getDouble("booking_fee"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("transit_line_name"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("train_id"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("class"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("seat_number"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("H.origin_id"));
			out.print("</td>");

			out.print("<td>");
			out.print(rs1.getString("H.destination_id"));
			out.print("</td>");

			out.print("</tr>");
		}
		rs1.close();
		stmt1.close();
	} catch (Exception e){
		
	}
	out.print("</table>");
	%>

	<h5>Current Reservations</h5>
	<!-- Should let an individual see which reservations they have made that are pending -->
	
	<%
			/* 
			* Copied from Ronak's code on the "reservations.jsp" sheet
			* This code should get a list of all reservations of the user
			*/
			try {

				Statement stmt2 = con.createStatement();

				// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String query2 = "SELECT * FROM Customer AS C join Reservation_Portfolio AS R using (username)"
				+ " join Has_Ride_Origin_Destination_PartOf AS H using (reservation_number)"
				+ " join Schedule_Origin_of_Train_Destination_of_Train_On AS S using (transit_line_name)"
				+ " join Train AS T on (S.train_id = T.id)"
				+ " WHERE username = \"" + (String) session.getAttribute("user") + "\";";

				//Execute query against the database.
				ResultSet rs2 = stmt2.executeQuery(query2);
				
				//Make an HTML table to show the results in:
				out.print("<table>");

				//make header row
				out.print("<tr>");
				//make header columns
				out.print("<th>Reservation Number</td>");
				out.print("<th>Username</td>");
				out.print("<th>Customer Name</td>");
				out.print("<th>Type of Reservation</td>");
				out.print("<th>Reservation Created</td>");
				out.print("<th>Booking Fee</td>");
				out.print("<th>Transit Line</td>");
				out.print("<th>Train ID</td>");
				out.print("<th>Boarding Class</td>");
				out.print("<th>Seat Number</td>");
				out.print("<th>Origin Station ID</td>");
				out.print("<th>Destination Station ID</td>");

				out.print("</tr>");

				//Filter such that only current reservations show
				while (rs2.next()) {

			if (rs2.getString("date_made").substring(0, 9).equals(java.time.LocalDate.now())) {

				// Create row of data
				out.print("<tr>");

				out.print("<td>");
				out.print(rs2.getInt("reservation_number"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("username"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("name_firstname") + " " + rs2.getString("name_lastname"));
				out.print("</td>");

				// Type of Reservation
				String typeOfRes = "";
				if (rs2.getInt("isMonthly") == 1) {
					typeOfRes = "Monthly";
				} else if (rs2.getInt("isWeekly") == 1) {
					typeOfRes = "Weekly";
				} else if (rs2.getInt("isRoundTrip") == 1) {
					typeOfRes = "Round Trip";
				} else {
					typeOfRes = "Single Ride";
				}
				out.print("<td>");
				out.print(typeOfRes);
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("date_made"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getDouble("booking_fee"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("transit_line_name"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("train_id"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("class"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("seat_number"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("H.origin_id"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs2.getString("H.destination_id"));
				out.print("</td>");

				out.print("</tr>");
			}
				}
				rs2.close();
				stmt2.close();
			} catch (Exception e) {

			}
			out.print("</table>");

			//close the connection.
			db.closeConnection(con);
		%>
	
	<br>
	
	<button onclick="window.location.href='customerHome.jsp';">Return to Homepage</button>
	


</body>
</html>