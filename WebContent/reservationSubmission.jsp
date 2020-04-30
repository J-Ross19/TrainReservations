<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Create Reservation</title>
</head>
<body>

	<%
		if ((String) session.getAttribute("user") == null) {
		String redirectURL = "http://localhost:8080/Login/login.jsp";
		response.sendRedirect(redirectURL);
	}

	//[reservation_number (PK), date_made, booking_fee, isMonthly, isWeekly,
//isRoundTrip, username (FK) references Customer not NULL]

	
	//Declaring stuff
	Database db = new Database();
	Connection con = db.getConnection();
	Statement st = con.createStatement();

	double booking_fee = 0;
	int isMonthly = 0;
	int isWeekly = 0;
	int isRoundTrip = 0;
	String username = (String)session.getAttribute("user");
	String query;
	String rideQuery = "";
	
	int fail = 0;
	
	//Retrieve values
	String booking_fee_type = request.getParameter("bookingFeeType");
	if (booking_fee_type.equals("monthly")) isMonthly = 1;
	if (booking_fee_type.equals("weekly")) isWeekly = 1;
	if (booking_fee_type.equals("round")) isRoundTrip = 1;
	
	//set up query
	if(isMonthly == 1 || isWeekly == 1){//if it's either of these, set query
		if (isMonthly == 1) {
			booking_fee = 1000;
		} else booking_fee = 300;
		query = "INSERT INTO Reservation_Portfolio(date_made, booking_fee, isMonthly, isWeekly, isRoundTrip, username)"
				+ " VALUES (\'" + java.time.LocalDate.now() + "\', \'" + booking_fee
				+ "\', \'" + isMonthly + "\', \'" + isWeekly + "\', \'" + isRoundTrip + "\', \"" + username + "\");";
	} else {//else, we need to retrieve values for each ride and add them up
		int numrows = Integer.parseInt(request.getParameter("numRows"));
		
		//Values we need to retrieve
		String discount;
		String seatingClass;
		String seatNumber;
		String origID;
		String destID;
		String transitLine;

		String hasRideQuery;

		for (int i = 0; i < numrows; i++){ //for each row		
			int isChildOrSenior = 0;
			int isDisabled = 0;
			double rideFare = 0;
			discount = request.getParameter("discount" + i);
			seatingClass = request.getParameter("class" + i);
			seatNumber = request.getParameter("seatNumber" + i);
			origID = request.getParameter("originId" + i);
			destID = request.getParameter("destId" + i);
			transitLine = request.getParameter("transitLine" + i);
			
			//verify that the transitLine and stops are acceptable
			Statement stVerify = con.createStatement(); // No need to verify 
			String verifyQuery = "SELECT * FROM"
					+		"(SELECT transit_line_name, origin_station_id AS id, origin_departure_time AS departure_time, origin_arrival_time AS arrival_time FROM Schedule_Origin_of_Train_Destination_of_Train_On"
					+		" UNION"
					+		" SELECT * FROM Stops_In_Between) AS Temp"
					+		" WHERE transit_line_name = '" + transitLine + "'"
					+		" and id = '" + origID + "'"
					+		" and departure_time < any (SELECT arrival_time FROM ("
					+		" SELECT transit_line_name, destination_station_id AS id, destination_departure_time AS departure_time, destination_arrival_time AS arrival_time FROM Schedule_Origin_of_Train_Destination_of_Train_On"
					+		" UNION"
					+		" SELECT * FROM Stops_In_Between) AS Temp"
					+		" WHERE transit_line_name = '" + transitLine + "'"
					+		" and id = '" + destID + "')";
			
					
			ResultSet originDest = stVerify.executeQuery(verifyQuery);
			
			if (!originDest.next()){ //something is wrong, abort
				originDest.close();
				stVerify.close();
		    	out.println("<p>An error has occurred. Please make sure you enter the transit line and stops correctly</p>");
		        out.println("<button onclick=\"window.location.href='reservations.jsp';\">Go Back</button><br><button onclick=\"window.location.href='customerHome.jsp';\">Return to Home Page</button>");
		        fail = 1;
				break;
			} else {
				originDest.close();
				stVerify.close();
			}
			
			//set discount values and determine rideFare for this ride
			String discountQuery = "SELECT ";
			if(discount.equals("childSenior")){
				isChildOrSenior = 1;
				discountQuery += "senior/child_fare AS fee from Schedule_Origin_of_Train_Destination_of_Train_On r "
						+ "where r.transit_line_name = \"" + transitLine + "\";";
			} else if (discount.equals("disabled")){
				isDisabled = 1;
				discountQuery += "disabled_fare AS fee from Schedule_Origin_of_Train_Destination_of_Train_On r "
						+ "where r.transit_line_name = \"" + transitLine + "\";";
			} else {
				discountQuery += "normal_fare AS fee from Schedule_Origin_of_Train_Destination_of_Train_On r "
						+ "where r.transit_line_name = \"" + transitLine + "\";";
			}
			
			Statement stDiscount = con.createStatement();
			ResultSet discountSet = stDiscount.executeQuery(discountQuery);
			if(!discountSet.next()){//transitLine doesn't exist
				discountSet.close();
				stDiscount.close();
				fail = 2;
		    	out.println("<p>An error has occurred. Please make sure you enter the transit line name correctly</p>");
		        out.println("<button onclick=\"window.location.href='reservationsCreate.jsp';\">Go Back</button><br><button onclick=\"window.location.href='customerHome.jsp';\">Return to Home Page</button>");
				break;
			} else {
				rideFare = discountSet.getDouble("fee");
				if (isChildOrSenior == 0 && isDisabled == 0 && isRoundTrip == 1){
					rideFare = 40;
				}
				if(seatingClass.equals("first")) {
					rideFare *=2;
				} else if (seatingClass.equals("business")){
					rideFare *=1.5;
				}
				discountSet.close();
				stDiscount.close();
			}
			
			
			//insert into HasRide table
			hasRideQuery = "INSERT INTO Has_Ride_Origin_Destination_PartOf(origin_id, destination_id, class, seat_number, isChildOrSenior, isDisabled, transitLineName)"
					+ " VALUES (\'" + origID + "\', \'" + destID
					+ "\', \"" + seatingClass + "\", \'" + seatNumber + "\', \'" 
					+ isChildOrSenior + "\', \'" + isDisabled + "\', \"" + transitLine + "\");";
			Statement stHasRide = con.createStatement();
			stHasRide.executeUpdate(hasRideQuery);
			stHasRide.close();
			
			booking_fee += rideFare;
		}
	}			
	
	//Create Reservation
	if (fail == 0) {//if it didn't fail 
		query = "INSERT INTO Reservation_Portfolio(date_made, booking_fee, isMonthly, isWeekly, isRoundTrip, username)"
				+ " VALUES (\'" + java.time.LocalDate.now() + "\', \'" + booking_fee
				+ "\', \'" + isMonthly + "\', \'" + isWeekly + "\', \'" + isRoundTrip + "\', \"" + username + "\");";
		st.executeUpdate(query);
		out.println("<h3>Reservation completed successfully! You have been charged $" + booking_fee + "</p>");  out.println("<button onclick=\"window.location.href='customerReservations.jsp';\">Back to Reservations</button><br><button onclick=\"window.location.href='customerHome.jsp';\">Return to Home Page</button>");
	}
	st.close();
	db.closeConnection(con);
	
	

  
	
	%>
	
	

</body>
</html>