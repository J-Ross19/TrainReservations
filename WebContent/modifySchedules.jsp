<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
 <title>Train Schedule Modification</title>
</head>
<body>
<%
String transit = request.getParameter("transit"),action = request.getParameter("action"), username = "temp";
%>
<form action="modifyStops (besides origin/dest).jsp" method="post">
  		<label for="stop">Transit Line Name:</label>
 		<input type="text" name="transit" value="<%out.println(transit);%>" required>
 		<h5>Action To Perform</h5>
        <input required type="radio" name="action" value="add"/>Add
  		<br/>
  		<input required type="radio" name="action" value="edit"/>Edit
  		<br/>
  		<input required type="radio" name="action" value="delete"/>Delete
        <br/><br/>
  		<input type="submit" value="Submit">
</form>
<%
if(action.equals( "add")){ // Add a schedule
%>
		
	<h3>Create a Schedule</h3>
	<form action="createSchedule.jsp" method="post">
    	<h5>Transit Line Name</h5> <input type="text" name="transitLine" value="<%out.println(transit);%>" required>
    	<h5>Train ID</h5> <input type="number" name="trainID" required>
    	<h5>Origin Station ID</h5> <input type="number" name="originID" required>
    	<h5>Destination Station ID</h5><input type="number" name="destID" required>
    	<h5>Origin Arrival Time (YYYY-MM-DD hh:mm:ss)</h5> <input type="text" name="originATime" required>
    	<h5>Origin Departure Time (YYYY-MM-DD hh:mm:ss)</h5> <input type="text" name="originDTime" required>
    	<h5>Destination Arrival Time (YYYY-MM-DD hh:mm:ss)</h5> <input type="text" name="destATime" required>
    	<h5>Destination Departure Time (YYYY-MM-DD hh:mm:ss)</h5> <input type="text" name="destDTime" required>
    	<h5>Regular Fare</h5><input type="number" name="fare" required> <br/>
    	<h5>Senior/Child Fare</h5> <input type="number" name="scFare" required>
    	<h5>Disabled Fair</h5> <input type="number" name="dFare" required>
    	<br/><br/>
    	<input type="submit" value="Submit">
	</form>
	
<%
		
}else if (action.equals("edit")){
	Database db = new Database();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("SELECT * from Schedule where transit_line_name='" + transit + "';");
	if(!rs.next()){
	rs.close();
    st.close();
    con.close();
    out.println("<p>Sorry that user doesnt exist.</p>");
    out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
	}else{
		rs.first();
		String password = rs.getString("password"), email =rs.getString("email"), street = rs.getString("street_address"), city = rs.getString("city"), state = rs.getString("state"), tele = rs.getString("telephone"), zip = rs.getString("zip"), first = rs.getString("name_firstname"), last = rs.getString("name_lastname");
		
		rs.close();
	    st.close();
	    con.close();
%>
		
	<h3>Update an Account</h3>
	<form action="adminUpdateCustomer.jsp" method="post">
    <h5>First Name</h5> <input type="text" name="name_firstname" required value=<%out.println(first); %>>
    <h5>Last Name</h5> <input type="text" name="name_lastname" required value=<%out.println(last); %>>
    <h5>Username </h5><input type="text" name="username" required value=<%out.println(username); %> readonly>
    <h5>Password  </h5><input type="password" name="password" required value=<%out.println(password); %>>
    <h5>Email </h5><input type="text" name="email" required value=<%out.println(email); %>> <br/>
    <h5>Street Address </h5> <input type="text" name="street_address" required value=<%out.println(street); %>>
    <h5> City</h5> <input type="text" name="city" required value=<%out.println(city); %>>
    <h5>State</h5> <select name="state" required >
    <option value="AL">Alabama</option>
    <option value="AK">Alaska</option>
    <option value="AZ">Arizona</option>
    <option value="AR">Arkansas</option>
    <option value="CA">California</option>
    <option value="CO">Colorado</option>
    <option value="CT">Connecticut</option>
    <option value="DE">Delaware</option>
    <option value="DC">District Of Columbia</option>
    <option value="FL">Florida</option>
    <option value="GA">Georgia</option>
    <option value="HI">Hawaii</option>
    <option value="ID">Idaho</option>
    <option value="IL">Illinois</option>
    <option value="IN">Indiana</option>
    <option value="IA">Iowa</option>
    <option value="KS">Kansas</option>
    <option value="KY">Kentucky</option>
    <option value="LA">Louisiana</option>
    <option value="ME">Maine</option>
    <option value="MD">Maryland</option>
    <option value="MA">Massachusetts</option>
    <option value="MI">Michigan</option>
    <option value="MN">Minnesota</option>
    <option value="MS">Mississippi</option>
    <option value="MO">Missouri</option>
    <option value="MT">Montana</option>
    <option value="NE">Nebraska</option>
    <option value="NV">Nevada</option>
    <option value="NH">New Hampshire</option>
    <option value="NJ">New Jersey</option>
    <option value="NM">New Mexico</option>
    <option value="NY">New York</option>
    <option value="NC">North Carolina</option>
    <option value="ND">North Dakota</option>
    <option value="OH">Ohio</option>
    <option value="OK">Oklahoma</option>
    <option value="OR">Oregon</option>
    <option value="PA">Pennsylvania</option>
    <option value="RI">Rhode Island</option>
    <option value="SC">South Carolina</option>
    <option value="SD">South Dakota</option>
    <option value="TN">Tennessee</option>
    <option value="TX">Texas</option>
    <option value="UT">Utah</option>
    <option value="VT">Vermont</option>
    <option value="VA">Virginia</option>
    <option value="WA">Washington</option>
    <option value="WV">West Virginia</option>
    <option value="WI">Wisconsin</option>
    <option value="WY">Wyoming</option>
</select>
<script>


function selectElement(id, valueToSelect) {    
    let element = document.getElementsByName(id)[0];
    element.value = valueToSelect;
}

selectElement('state', '<%out.print(state); %>')
</script>
    <h5>Zip Code</h5> <input type="text" name="zip" required value=<%out.println(zip); %>>
    <h5>Phone Number</h5> <input type="text" name="telephone" required value=<%out.println(tele); %>><br/><br><br>
    <input type="submit" value="Update Account"><br><br><br>
</form>
		
<%
	}
}else{
	Database db = new Database();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	st.executeUpdate("delete from Customer where username= \""+username +"\";");
	st.close();
	db.closeConnection(con);
	out.println("<p>Deleted</p>");
	
	out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
}
%>
</body>
</html>