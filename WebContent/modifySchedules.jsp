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
<%String username = request.getParameter("username"),type = request.getParameter("type"),action = request.getParameter("action");

if(type.equals( "customer")){
	
	if(action.equals( "add")){
		
		%>
		
		<h3>Create an Account</h3>
	<form action="adminCreateCustomer.jsp" method="post">
    <h5>First Name</h5> <input type="text" name="name_firstname" required>
    <h5>Last Name</h5> <input type="text" name="name_lastname" required>
    <h5>Username </h5><input type="text" name="username" required value=<%out.println(username); %>>
    <h5>Password  </h5><input type="password" name="password" required>
    <h5>Email </h5><input type="text" name="email" required> <br/>
    <h5>Street Address </h5> <input type="text" name="street_address" required>
    <h5> City</h5> <input type="text" name="city" required>
    <h5>State</h5> <select name="state" required>
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
    <h5>Zip Code</h5> <input type="text" name="zip" required>
    <h5>Phone Number</h5> <input type="text" name="telephone" required><br/><br><br>
    <input type="submit" value="Create Account"><br><br><br>
</form>
		
		<%
		
	}else if (action.equals("edit")){
		 Database db = new Database();
		    Connection con = db.getConnection();
		    Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * from Customer where username='" + username + "';");
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
	
}else if (type.equals("employee")){
	if(action.equals( "add")){
		
		%>
				<h3>Create an Account</h3>
	<form action="adminCreateEmployee.jsp" method="post">
    <h5>First Name</h5> <input type="text" name="name_firstname" required>
    <h5>Last Name</h5> <input type="text" name="name_lastname" required>
    <h5>Username </h5><input type="text" name="username" required value=<%out.println(username); %>>
    <h5>Password  </h5><input type="password" name="password" required>
    <h5>SSN</h5> <input type="text" name="ssn" required>
        <select required name="type" >
    <option value="rep">Customer Representative</option>
    <option value="manag">Site Manager</option>
    </select>
    <br/><br><br>
    <input type="submit" value="Create Account"><br><br><br>
</form>
		
		<%
		
	}else if (action.equals("edit")){
		
		 Database db = new Database();
		    Connection con = db.getConnection();
		    Statement st = con.createStatement(), st2 = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * from Employee_Customer_Rep where username='" + username + "';");
		ResultSet rs2 = st2.executeQuery("SELECT * from Employee_Site_Manager where username='" + username + "';");
		if(!rs.next()&&!rs2.next()){
		rs.close();
		rs2.close();
 	st.close();
		st2.close();
 	con.close();
 	out.println("<p>Sorry that user doesnt exist.</p>");
     out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
		}else{
			rs.beforeFirst();
			String typer;
			String ssn, first, last, password;
			if(rs.next()){
				//customer rep
				typer="rep";
				rs.first();
				ssn = rs.getString("ssn");
				first = rs.getString("name_firstname");
				last = rs.getString("name_lastname");
				password = rs.getString("password");
			}else{
				typer="manag";
				rs2.first();
				ssn = rs2.getString("ssn");
				first = rs2.getString("name_firstname");
				last = rs2.getString("name_lastname");
				password = rs2.getString("password");
				//manager
			}
			
		
			rs.close();
	    	st.close();
			rs2.close();
	    	st2.close();
	    	con.close();

%>
		
		

<h3>Update an Account</h3>
	<form action="adminUpdateEmployee.jsp" method="post">
    <h5>First Name</h5> <input type="text" name="name_firstname" required value=<%out.println(first); %>>
    <h5>Last Name</h5> <input type="text" name="name_lastname" required value=<%out.println(last); %>>
    <h5>Username </h5><input type="text" name="username" required value=<%out.println(username); %> readonly>
    <h5>Password  </h5><input type="password" name="password" required value=<%out.println(password); %>>
    <h5>SSN</h5> <input type="text" name="ssn" required value=<%out.println(ssn); %>>
        <input required name="type" type ="hidden" readonly value=<%out.println(typer); %>>
    
    <br/><br><br>
    <input type="submit" value="Update Account"><br><br><br>
</form>
		
		<%
		}
		
	}else{
		if(username.equals("admin")){
			out.println("<p>Cannot Delete The Original Site Manager</p>");
			 out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
		}else{
		Database db = new Database();	
		Connection con = db.getConnection();
	   Statement st = con.createStatement();
	   st.executeUpdate("delete from Employee_Customer_Rep where username= \""+username +"\";");
	   Statement st2 = con.createStatement();
	   st2.executeUpdate("delete from Employee_Site_Manager where username= \""+username +"\";");
		st.close();
		st2.close();
		db.closeConnection(con);
		out.println("<p>Deleted</p>");
		
		 out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
		}
	}
	
}


%>
</body>
</html>