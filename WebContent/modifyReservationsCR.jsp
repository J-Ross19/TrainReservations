<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
 <title>Train Schedule Modification</title>
 <style>
	table {
  		font-family: arial, sans-serif;
  		border-collapse: collapse;
  		white-space: nowrap;
	}

	td, th {
		font-family: arial, sans-serif;
		font-size: 8pt;
  		border: 1px solid #dddddd;
  		text-align: left;
  		padding: 8px;
	}

	tr:nth-child(even) {
  		background-color: #dddddd;
	}
  </style>
</head>
<body>
	<form action="schedules.jsp" method="get">
     	<button>Back</button>
	</form>
<%
String transit = request.getParameter("transit"),action = request.getParameter("action"), username = "fake", type = "nope";
if(action.equals("add")){ // Add a schedule
%>

   <script>
   function addRow(){
   let numRows = parseInt(document.getElementsByName("numRows")[0].value);
   document.getElementsByName("numRows")[0].value=numRows+1;
	let table =   document.getElementsByName("table")[0];
   var row  = table.insertRow(numRows);
   var cell1 = row.insertCell(0);
   var cell2 = row.insertCell(1);
   var cell3 = row.insertCell(2);
   var cell4 = row.insertCell(3);
   var cell5 = row.insertCell(4);
   var cell6 = row.insertCell(5);
 
	cell1.innerHTML = "<input required name=\"transitLine"+numRows+1+"\" type=\"text\"/> <label for=\"transitLine"+numRows+1+"\"> Transit Line Name</label> ";
	cell2.innerHTML = "<select required name=\"class"+numRows+1+"\" > <option value='first'>First</option> <option value='business'>Business</option> <option value='economy'>Economy</option> </select>"
	cell3.innerHTML = "<input required name=\"originId"+numRows+1+"\" type=\"number\"/> <label for=\"originId"+numRows+1+"\"> Origin Station Id</label>"
	cell4.innerHTML = "<input required name=\"destId"+numRows+1+"\" type=\"number\"/> <label for=\"destId"+numRows+1+"\"> Destination Station Id</label>"
	cell5.innerHTML = "<input required name=\"seatNumber"+numRows+1+"\" type=\"number\"/> <label for=\"seatNumber"+numRows+1+"\"> Seat Number</label>"
	cell6.innerHTML = "<select required name=\"discount"+numRows+1+"\" ><option value='none'>None of the Above</option><option value='childSenior'>Child/Senior</option><option value='disabled'>Disabled</option></select>"
   }
   
   function updateTable(){
	   var x = document.getElementsByName("table")[0];
	   var y = document.getElementsByName("jkjk")[0];
	   let z = document.getElementsByName("llll")[0];
	   if(document.getElementsByName("bookingFeeType")[0].value=='monthly' || document.getElementsByName("bookingFeeType")[0].value=='weekly'){
		   y.style.display = "none";
		   x.style.display = "none";
		   z.setAttribute("formnovalidate");
	   }else{
		   y.style.display = "block";
		   x.style.display = "block";
		   z.removeAttribute("formnovalidate");
	   }
	   
   }
   
   </script>
   
   
     <form action="reservationSubmition.jsp" method="post">
     <h5>Reservation</h5>

  
  	<select required name="bookingFeeType"  onclick = "updateTable();">
  	<option value='single' onclick = "updateTable();">One Way Trip</option>
    <option value='monthly'onclick = "updateTable();">Monthly Pass</option>
    <option value='weekly'onclick = "updateTable();">Weekly Pass</option>
    <option value='round'onclick = "updateTable();">Round Trip</option>
   
    </select><br>
    <label for="bookingFeeType"> Type of Reservation</label>
  
  	<input type="hidden" name="numRows" value =1>
  	<br>
     <table name="table">
     <tr>
     <td>
	<input required name="transitLine1" type="text"/>
	<label for="transitLine1"> Transit Line Name</label>
	</td>
	<td>
	<select required name="class1" >
    <option value='first'>First</option>
    <option value='business'>Business</option>
    <option value='economy'>Economy</option>
    </select>
    </td>
    <td>
        	<input required name="originId1" type="number"/>
	<label for="originId1"> Origin Station Id</label>
	</td>
	<td>
	    	<input required name="destId1" type="number"/>
	<label for="destId1"> Destination Station Id</label>
    </td>
    <td>
    	<input required name="seatNumber1" type="number"/>
	<label for="seatNumber1"> Seat Number</label>
	</td>
	<td>
		<select required name="discount1" >
		<option value='none'>None of the Above</option>
    <option value='childSenior'>Child/Senior</option>
    <option value='disabled'>Disabled</option>
    </select>
    </td>
	</tr>
     </table>
     <button type="button" name="jkjk" onclick="addRow();">Add Ride</button>
     <br><br>
     <button name = "llll" type="submit">Submit</button>
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
	st.executeUpdate("delete from Customer where username= \""+ username +"\";");
	st.close();
	db.closeConnection(con);
	out.println("<p>Deleted</p>");	
	out.println("<button onclick=\"window.location.href='commandcenter.jsp';\">Go Back</button>");
	}
	



%>
</body>
</html>
