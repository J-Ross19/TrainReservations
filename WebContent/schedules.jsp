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
  			background-color: cyan;
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
 		<input type="text" name="stationID"><br/><br/>
  		<input type="submit" value="Submit">
	</form>
    <br/>
    <h3>Train Schedules:</h3>
    <form action="schedules.jsp" method="get">
        <button>Reset</button>
	</form><br/>
    <%
    
	try {
		Database db = new Database();
	    Connection con = db.getConnection();
	    Statement stmt = con.createStatement();
	    
		// Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
		String query = "SELECT *, TIMEDIFF(destination_arrival_time,origin_departure_time) AS 'diff' FROM Schedule_Origin_of_Train_Destination_of_Train_On join Train on (Train.id = Schedule_Origin_of_Train_Destination_of_Train_On.train_id)";
		
		// Check if stationID was set
		String stationID = request.getParameter("stationID");
		
		//request.setAttribute("empid", "1234"); ENDJSP
		//<jsp:include page="/servlet/MyServlet" flush="true"/>
		
		// If there is a statioID
		if (stationID != null) {
			// search by station id
			query += " WHERE origin_station_id = \'" + stationID + "\' or destination_station_id = \'" + stationID + "\'";
		} else if (1 == 0) {
			// search by origin and destination
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
		out.print("<th>Origin Arrival DateTime</td>");
		out.print("<th>Origin Departure DateTime</td>");
		out.print("<th>Destination Arrival DateTime</td>");
		out.print("<th>Destination Departure DateTime</td>");
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
			String stopQuery = "SELECT id FROM Stops_In_Between WHERE transit_line_name = \'" + rs.getString("transit_line_name") + "\' ORDER BY arrival_time";
			ResultSet rs2 = stmt2.executeQuery(stopQuery);
			String listOfStops = "" + rs.getInt("origin_station_id");
			while (rs2.next()) {
				listOfStops += ", " + rs2.getInt("id");
			}
			
			listOfStops += ", " + rs.getInt("destination_station_id");
			
			stmt2.close();
		    rs2.close();
		    
		    out.print(listOfStops);
		    
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("origin_arrival_time"));
			out.print("</td>");			
			
			out.print("<td>");
			out.print(rs.getString("origin_departure_time"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("destination_arrival_time"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("destination_departure_time"));
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