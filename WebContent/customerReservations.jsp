<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*, java.util.concurrent.TimeUnit"%>
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

		<button onclick="window.location.href='customerReservations.jsp';">Refresh Page</button>
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
		
		/* 
		* Copied from Ronak's code on the "reservations.jsp" sheet
		* This code should get a list of all reservations of the user
		*/
		
		String username = (String) session.getAttribute("user");
		
		try {
	
			DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date1 = df1.format(new java.util.Date());
			
			Statement stmt1 = con.createStatement();
	
			// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String query1 = "SELECT * FROM Customer AS C join Reservation_Portfolio AS R using (username)"
			+ " join Has_Ride_Origin_Destination_PartOf AS H using (reservation_number)"
			+ " join Schedule_Origin_of_Train_Destination_of_Train_On AS S using (transit_line_name)"
			+ " join Train AS T on (S.train_id = T.id)"
			+ " WHERE username = \"" + username + "\""
			+ " AND origin_arrival_time >= \'" + date1 + "\'"
			+ " ORDER BY reservation_number DESC;";
	
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
	
				int reservation_number = rs1.getInt("reservation_number");
				
				out.print("<td>");
				out.print(reservation_number);
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
			out.println("<p>An error has occurred. Table 1 cannot be displayed.</p>");
			out.println("<p>" + e.getMessage() + "</p>");
		}
		out.print("</table>");
		
		%>
		
	<h5>Active Passes</h5>
	
		<%
		
		Statement stmt2 = con.createStatement();
		
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query2 = "SELECT * FROM Reservation_Portfolio WHERE username = \"" + username + "\""
				+ " ORDER BY reservation_number DESC;";
	
		//Execute query against the database.
		ResultSet rs2 = stmt2.executeQuery(query2);
		
		//Make an HTML table to show the results in:
		out.print("<table>");
	
		//make header row
		out.print("<tr>");
		//make header columns
		out.print("<th>Reservation Number</td>");
		out.print("<th>Username</td>");
		out.print("<th>Type of Reservation</td>");
		out.print("<th>Reservation Created</td>");
		out.print("<th>Booking Fee</td>");
	
		out.print("</tr>");
	
	
		DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date firstDate = df2.parse(df2.format(new java.util.Date()));
		
		//Add rows
		while (rs2.next()) {
			
			java.util.Date secondDate = df2.parse(rs2.getString("date_made"));
			
		    long diffInMillies = Math.abs(secondDate.getTime() - firstDate.getTime());
		    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
		    
			// Type of Reservation
			String typeOfRes = "";
			if (rs2.getInt("isMonthly") == 1 && diff <= 31) {
				typeOfRes = "Monthly";
			} else if (rs2.getInt("isWeekly") == 1 && diff <= 7) {
				typeOfRes = "Weekly";
			} else {
				continue;
			}
			// Create row of data
			out.print("<tr>");
	
			out.print("<td>");
			out.print(rs2.getInt("reservation_number"));
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs2.getString("username"));
			out.print("</td>");
	
	
			out.print("<td>");
			out.print(typeOfRes);
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs2.getString("date_made"));
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs2.getDouble("booking_fee"));
			out.print("</td>");
	
			out.print("</tr>");
		}
		rs2.close();
		stmt2.close();
		out.print("</table>");
		
		%>

	<h5>Delete Reservation</h5>
	
	<form action="reservationsCancel.jsp" method="post">
		<p>Please enter the reservation id:
		<input required name="reservationID" type="number"/>
		</p> <br>
		<button type="submit">Submit</button>
	</form>

	<h5>Past Reservations</h5>
	<!-- Should let an individual see which reservations they have made that expired -->
	
		<%
		/* 
		* Copied from Ronak's code on the "reservations.jsp" sheet
		* This code should get a list of all reservations of the user
		*/
		try {
			
			DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date3 = df3.format(new java.util.Date());
			
			Statement stmt3 = con.createStatement();

			// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String query3 = "SELECT * FROM Customer AS C join Reservation_Portfolio AS R using (username)"
			+ " join Has_Ride_Origin_Destination_PartOf AS H using (reservation_number)"
			+ " join Schedule_Origin_of_Train_Destination_of_Train_On AS S using (transit_line_name)"
			+ " join Train AS T on (S.train_id = T.id)"
			+ " WHERE username = \"" + username + "\""
			+ " AND origin_arrival_time < \'" + date3 + "\'"
			+ " ORDER BY reservation_number DESC;";

			//Execute query against the database.
			ResultSet rs3 = stmt3.executeQuery(query3);
			
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
			while (rs3.next()) {

				// Create row of data
				out.print("<tr>");

				out.print("<td>");
				out.print(rs3.getInt("reservation_number"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("username"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("name_firstname") + " " + rs3.getString("name_lastname"));
				out.print("</td>");

				// Type of Reservation
				String typeOfRes = "";
				if (rs3.getInt("isMonthly") == 1) {
					typeOfRes = "Monthly";
				} else if (rs3.getInt("isWeekly") == 1) {
					typeOfRes = "Weekly";
				} else if (rs3.getInt("isRoundTrip") == 1) {
					typeOfRes = "Round Trip";
				} else {
					typeOfRes = "Single Ride";
				}
				out.print("<td>");
				out.print(typeOfRes);
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("date_made"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getDouble("booking_fee"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("transit_line_name"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("train_id"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("class"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("seat_number"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("H.origin_id"));
				out.print("</td>");

				out.print("<td>");
				out.print(rs3.getString("H.destination_id"));
				out.print("</td>");

				out.print("</tr>");
			}
			rs3.close();
			stmt3.close();
		} catch (Exception e) {
			out.println("<p>An error has occurred. Table 3 cannot be displayed.</p>");
			out.println("<p>" + e.getMessage() + "</p>");
		}
		out.print("</table>");
		%>
		
	<h5>Expired Passes</h5>
	
		<%
		
		Statement stmt4 = con.createStatement();
		
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query4 = "SELECT * FROM Reservation_Portfolio WHERE username = \"" + username + "\""
				+ " ORDER BY reservation_number DESC;";
	
		//Execute query against the database.
		ResultSet rs4 = stmt4.executeQuery(query4);
		
		//Make an HTML table to show the results in:
		out.print("<table>");
	
		//make header row
		out.print("<tr>");
		//make header columns
		out.print("<th>Reservation Number</td>");
		out.print("<th>Username</td>");
		out.print("<th>Type of Reservation</td>");
		out.print("<th>Reservation Created</td>");
		out.print("<th>Booking Fee</td>");
	
		out.print("</tr>");
	
	
		DateFormat df4 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date firstDate2 = df4.parse(df4.format(new java.util.Date()));
		
		//Add rows
		while (rs4.next()) {
			
			java.util.Date secondDate2 = df4.parse(rs4.getString("date_made"));
			
		    long diffInMillies = Math.abs(secondDate2.getTime() - firstDate2.getTime());
		    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
		    
			// Type of Reservation
			String typeOfRes = "";
			if (rs4.getInt("isMonthly") == 1 && diff > 31) {
				typeOfRes = "Monthly";
			} else if (rs4.getInt("isWeekly") == 1 && diff > 7) {
				typeOfRes = "Weekly";
			} else {
				continue;
			}
			// Create row of data
			out.print("<tr>");
	
			out.print("<td>");
			out.print(rs4.getInt("reservation_number"));
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs4.getString("username"));
			out.print("</td>");
	
	
			out.print("<td>");
			out.print(typeOfRes);
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs4.getString("date_made"));
			out.print("</td>");
	
			out.print("<td>");
			out.print(rs4.getDouble("booking_fee"));
			out.print("</td>");
	
			out.print("</tr>");
		}
		rs4.close();
		stmt4.close();
		out.print("</table>");
		
		%>

	<h3>List of Train Schedules:</h3>

		<%
			
		Statement st5 = con.createStatement();
	
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query5 = "SELECT *, TIMEDIFF(destination_arrival_time,origin_departure_time) AS 'diff', num_seats - count(seat_number) AS 'availSeats'" 
			+	" from Train AS T join Schedule_Origin_of_Train_Destination_of_Train_On AS S on (S.train_id = T.id)" 
			+	" left outer join (SELECT DISTINCT transit_line_name, seat_number FROM Has_Ride_Origin_Destination_PartOf) AS Seats using (transit_line_name)";
		
		// Query for temporary table containing all stops
		/*
		SELECT transit_line_name, origin_station_id AS id, origin_departure_time AS departure_time, origin_arrival_time AS arrival_time FROM Schedule_Origin_of_Train_Destination_of_Train_On
		UNION
		SELECT transit_line_name, destination_station_id AS id, destination_departure_time AS departure_time, destination_arrival_time AS arrival_time FROM Schedule_Origin_of_Train_Destination_of_Train_On
		UNION
		SELECT * FROM Stops_In_Between
		ORDER BY transit_line_name, arrival_time;
		*/
		
		// Check if stationID was set
		String stationID = request.getParameter("stationID");
		
		//request.setAttribute("empid", "1234"); ENDJSP
		String originID = request.getParameter("originID");	
		String destID = request.getParameter("destID");	
		
		// If there is a statioID
		if (stationID != null) {
			// search by station id
			query5 += " WHERE origin_station_id = \'" + stationID + "\' or destination_station_id = \'" + stationID + 
			"\' or exists (SELECT * from Stops_In_Between AS B WHERE S.transit_line_name = B.transit_line_name and id = \'"+ stationID + "\')";
		} else if (originID != null && destID != null) {
			query5 +=
					" join"
				+	" (SELECT transit_line_name, origin_station_id AS 'id', origin_departure_time AS 'departure_time', origin_arrival_time AS 'arrival_time' FROM Schedule_Origin_of_Train_Destination_of_Train_On"
				+	" UNION"
				+	" SELECT transit_line_name, destination_station_id AS 'id', destination_departure_time AS 'departure_time', destination_arrival_time AS 'arrival_time' FROM Schedule_Origin_of_Train_Destination_of_Train_On"
				+	" UNION"
				+	" SELECT * FROM Stops_In_Between"
				+	" ORDER BY transit_line_name, arrival_time) AS Temp using (transit_line_name)"
				+	" WHERE Temp.id = \'" + originID + "\'"
				+	" and Temp.arrival_time < any"
				+	" (SELECT Temp.arrival_time FROM Schedule_Origin_of_Train_Destination_of_Train_On AS S2"
				+	" join"
				+	" (SELECT transit_line_name, origin_station_id AS 'id', origin_departure_time AS 'departure_time', origin_arrival_time AS 'arrival_time' FROM Schedule_Origin_of_Train_Destination_of_Train_On"
				+	" UNION"
				+	" SELECT transit_line_name, destination_station_id AS 'id', destination_departure_time AS 'departure_time', destination_arrival_time AS 'arrival_time' FROM Schedule_Origin_of_Train_Destination_of_Train_On"
				+	" UNION"
				+	" SELECT * FROM Stops_In_Between"
				+	" ORDER BY transit_line_name, arrival_time) AS Temp using (transit_line_name)"
				+	" WHERE S.transit_line_name = S2.transit_line_name"
				+	" and Temp.id = \'" + destID + "\')";
		}
		
		query5 += " GROUP BY T.id, transit_line_name";
		
		//Execute query against the database.
		ResultSet rs5 = st5.executeQuery(query5);
		
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make header row
		out.print("<tr>");
		
		//make header columns
		out.print("<th>Transit Line</td>");
		out.print("<th>Train ID</td>");
		out.print("<th>Origin Station</td>");
		out.print("<th>Destination Station</td>");
		out.print("<th>Seats Available</td>");
		out.print("<th>Stops (by Station id)</td>");
		out.print("<th>Delayed?</td>");
		out.print("<th>Travel Time</td>");
		out.print("<th>Regular Fare</td>");
		out.print("<th>Senior/Child Fare</td>");
		out.print("<th>Disabled Fare</td>");

    	out.print("</tr>");
    	
    	
		//parse out the results
		while (rs5.next()) {
			
			// Create row of data
			out.print("<tr>");
			
			out.print("<td>");
			out.print(rs5.getString("transit_line_name"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getInt("train_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getInt("origin_station_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getInt("destination_station_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getInt("availSeats"));
			out.print("</td>");
			
			// List of Stops
			out.print("<td>");
			
			// Create a statement to get all stops
		    Statement stmt6 = con.createStatement();
			String stopQuery = "SELECT * FROM Stops_In_Between WHERE transit_line_name = \'" + rs5.getString("transit_line_name") + "\' ORDER BY arrival_time";
			ResultSet rs6 = stmt6.executeQuery(stopQuery);
			String listOfStops = "" + rs5.getInt("origin_station_id") + " (Arrives: " + rs5.getString("origin_arrival_time") + " // Departs: " + rs5.getString("origin_departure_time") + ")";
			while (rs6.next()) {
				listOfStops += "<br/>" + rs6.getInt("id") + " (Arrives: " + rs6.getString("arrival_time") + " // Departs: " + rs6.getString("departure_time") + ")";
			}
			
			listOfStops += "<br/>" + rs5.getInt("destination_station_id") + " (Arrives: " + rs5.getString("destination_arrival_time") + " // Departs: " + rs5.getString("destination_departure_time") + ")";
			
			stmt6.close();
		    rs6.close();
		    
		    out.print(listOfStops);
		    
			out.print("</td>");
			
			String delayed = rs5.getInt("isDelayed") == 0 ? "No" : "Yes";
			out.print("<td>");
			out.print(delayed);
			out.print("</td>");
			
			// Travel time
			out.print("<td>");
			out.print(rs5.getString("diff"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getDouble("normal_fare"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getDouble("senior_child_fare"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs5.getDouble("disabled_fare"));
			out.print("</td>");
			
			out.print("</tr>");

		}
		
		out.print("</table>");
		
		
		//close the connection.
		rs5.close();
		st5.close();
		db.closeConnection(con);
		%>
	
	<br>
	
	<button onclick="window.location.href='customerHome.jsp';">Return to Homepage</button>
	


</body>
</html>