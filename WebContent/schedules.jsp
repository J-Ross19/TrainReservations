<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
      <title>Schedules</title>
      <style>
      	table {
			width:100%;
		}
		table, th, td {
  			border: 1px solid black;
 			border-collapse: collapse;
 			font-size: 8pt;
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
   	<h3>Search by Station ID:</h3>
   	<form action="schedules.jsp" method="post">
  		<label for="stationID">Station ID:</label>
 		<input type="text" name="stationID" required><br/><br/>
  		<input type="submit" value="Submit">
	</form>
	<h3>Search by Origin/Destination:</h3>
   	<form action="schedules.jsp" method="post">
  		<label for="originID">Origin ID:</label>
 		<input type="text" name="originID" required><br/>
 		<label for="destID">Destination ID:</label>
 		<input type="text" name="destID" required><br/><br/>
  		<input type="submit" value="Submit">
	</form>
    <br/>
    <h4>Edit Schedules:</h4>
   	<form action="modifySchedules.jsp" method="post">
  		<label for="transit">Transit Line Name:</label>
 		<input type="text" name="transit" required>
 		<h5>Action To Perform</h5>
        <input required type="radio" name="action" value="add"/>Add
  		<br/>
  		<input required type="radio" name="action" value="edit"/>Edit
  		<br/>
  		<input required type="radio" name="action" value="delete"/>Delete
        <br/><br/>
  		<input type="submit" value="Submit">
	</form>
    <br/>
    <h3>List of Train Schedules:</h3>
    <form action="schedules.jsp" method="get">
        <button>Reset</button>
	</form><br/>
    <%
    
	try {
		Database db = new Database();
	    Connection con = db.getConnection();
	    Statement stmt = con.createStatement();
	    
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query = "SELECT *, TIMEDIFF(destination_arrival_time,origin_departure_time) AS 'diff' FROM Schedule_Origin_of_Train_Destination_of_Train_On AS S join Train AS T on (T.id = S.train_id)";
		
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
			query += " WHERE origin_station_id = \'" + stationID + "\' or destination_station_id = \'" + stationID + 
			"\' or exists (SELECT * from Stops_In_Between AS B WHERE S.transit_line_name = B.transit_line_name and id = \'"+ stationID + "\')";
		} else if (originID != null && destID != null) {
			query +=
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
		
		
		
		//Execute query against the database.
		ResultSet rs = stmt.executeQuery(query);
		
		
		//Make an HTML table to show the results in:
		out.print("<table>");

		//make header row
		out.print("<tr>");
		
		//make header columns
		out.print("<th>Transit Line</td>");
		out.print("<th>Train ID</td>");
		out.print("<th>Origin Station</td>");
		out.print("<th>Destination Station</td>");
		out.print("<th>Number of Seats</td>");
		out.print("<th>Stops (by Station id)</td>");
		out.print("<th>Delayed?</td>");
		out.print("<th>Travel Time</td>");
		out.print("<th>Regular Fare</td>");
		out.print("<th>Senior/Child Fare</td>");
		out.print("<th>Disabled Fare</td>");

    	out.print("</tr>");
    	
    	
		//parse out the results
		while (rs.next()) {
			
			// Create row of data
			out.print("<tr>");
			
			out.print("<td>");
			out.print(rs.getString("transit_line_name"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getInt("train_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getInt("origin_station_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getInt("destination_station_id"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getInt("num_seats"));
			out.print("</td>");
			
			// List of Stops
			out.print("<td>");
			
			// Create a statement to get all stops
		    Statement stmt2 = con.createStatement();
			String stopQuery = "SELECT * FROM Stops_In_Between WHERE transit_line_name = \'" + rs.getString("transit_line_name") + "\' ORDER BY arrival_time";
			ResultSet rs2 = stmt2.executeQuery(stopQuery);
			String listOfStops = "" + rs.getInt("origin_station_id") + " (Arrives: " + rs.getString("origin_arrival_time") + " // Departs: " + rs.getString("origin_departure_time") + ")";
			while (rs2.next()) {
				listOfStops += "<br/>" + rs2.getInt("id") + " (Arrives: " + rs2.getString("arrival_time") + " // Departs: " + rs2.getString("departure_time") + ")";
			}
			
			listOfStops += "<br/>" + rs.getInt("destination_station_id") + " (Arrives: " + rs.getString("destination_arrival_time") + " // Departs: " + rs.getString("destination_departure_time") + ")";
			
			stmt2.close();
		    rs2.close();
		    
		    out.print(listOfStops);
		    
			out.print("</td>");
			
			String delayed = rs.getInt("isDelayed") == 0 ? "No" : "Yes";
			out.print("<td>");
			out.print(delayed);
			out.print("</td>");
			
			// Travel time
			out.print("<td>");
			out.print(rs.getString("diff"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getDouble("normal_fare"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getDouble("senior_child_fare"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getDouble("disabled_fare"));
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