<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
   <head>
      <title>Schedules</title>
   </head>
   <body>
   	<form action="customerRepHome.jsp" method="get">
        <button>Home</button>
	</form>
   	<h3>Search by Station ID:</h3>
   	<form action="reservations.jsp" method="post">
  		<label for="stationID">Station ID:</label>
 		<input type="text" name="resID"><br/><br/>
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
		String query = "SELECT * FROM Schedule_Origin_of_Train_Destination_of_Train_On join Stops_In_Between using (transit_line_name)";
		
		// Check if username was set
		String stationID = request.getParameter("stationID");
		
		//request.setAttribute("empid", "1234"); ENDJSP
		//<jsp:include page="/servlet/MyServlet" flush="true"/>
		
		// If there is a username
		if (stationID != null) {
			// search by station id
			query += " WHERE id = \'" + stationID + "\'";
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
		out.print("<td>Transit Line</td>");
		out.print("<td>Train ID</td>");
		out.print("<td>Origin</td>");
		out.print("<td>Destination</td>");
		out.print("<td>Seats Available</td>");
		out.print("<td>Stops (by Station id)</td>");
		out.print("<td>Origin Arrival DateTime</td>");
		out.print("<td>Origin Departure DateTime</td>");
		out.print("<td>Destination Arrival DateTime</td>");
		out.print("<td>Destination Departure DateTime</td>");
		out.print("<td>Travel Time</td>");
		out.print("<td>Fare</td>");

    	out.print("</tr>");
    	
    	/*
		//parse out the results
		while (rs.next()) {
			
			// Create row of data
			out.print("<tr>");
			
			out.print("<td>");
			out.print(rs.getInt("Transit Line"));
			out.print("</td>");
			
			out.print("<td>");
			out.print(rs.getString("Departure Time"));
			out.print("</td>");
			
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
			
			out.print("</tr>");

		}
		*/
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