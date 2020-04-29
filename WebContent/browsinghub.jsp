<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<html>


	<!-- page with all the features -->
	<head>
		<meta charset="ISO-8859-1">
		<title>Browse and Search</title>
	</head>
	
	<body>
	
		<h2>Browse and Search</h2>
		
		<!-- train scheds -->
		<section>
			<!-- search for train schedules 
			by origin, destination, date of travel -->
			<h3>Search Train Schedules</h3>
			
			<form action="trainSched.jsp" method="post">
				<label for="origin">Origin:</label>
  				<input name="origin" type="text"/>
  
  				<label for="dest">Destination:</label>
  				<input name="dest" type="text"/>
  				<br>
				<label for="tDate">Date of Travel (YYYY-MM-DD):</label>
				<input name="tDate" type="text"/>				
				<br>
				<label for="appt">Choose a time for your meeting:</label>
				<button>Search</button>
			</form>
		</section>
		
		<!-- sort trains -->
		<section>
			<!-- sort by different criteria 
			(by arrival time, departure time, 
			origin, destination, fare)  -->
			<h3>Sort All Trains</h3>
			<form action="sortTrains.jsp" method="post">
				
				<label for="type">Sort by:</label>

				<select id="type">
  					<option value="aTime">Arrival Time</option>
 					<option value="dTime">Departure Time</option>
  					<option value="origin">Origin</option>
 					<option value="dest">Destination</option>
 					<option value="fare">Fare</option>
				</select>
				
				<label for="order">Order:</label>

				<select id="order">
  					<option value="asc">Ascending</option>
 					<option value="des">Descending</option>
				</select>
				<br>
				<button>Search</button>
			</form>
		</section>
		
		
		<!-- train stops -->
		<section>
			<!-- a user should be able to see all 
			the stops a train will make -->
			<h3>See Train Stops</h3>
    
			<form action="stops.jsp" method="post">	
				<label for="origin">Origin:</label>
  				<input name="origin" type="text"/>
  
  				<label for="dest">Destination:</label>
  				<input name="dest" type="text"/>
  				<br>
				<button>Search</button>
			</form>
		</section>
	</body>

</html>
