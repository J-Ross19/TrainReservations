<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
            <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
   <head>
      <title>Create Reservation</title>
      <style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  
}

td, th {
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
   
   	<%
		if ((String) session.getAttribute("user") == null) {
		String redirectURL = "http://localhost:8080/Login/login.jsp";
		response.sendRedirect(redirectURL);
	}
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
 
	cell1.innerHTML =   " <input required name=\"transitLine"+numRows+1+"\" type=\"text\"/> <label for=\"transitLine"+numRows+1+"\"> Transit Line Name</label> ";
	cell2.innerHTML =  "	<select required name=\"class"+numRows+1+"\" > <option value='first'>First</option> <option value='business'>Business</option> <option value='economy'>Economy</option> </select>"
	cell3.innerHTML = " <input required name=\"originId"+numRows+1+"\" type=\"number\"/> <label for=\"originId"+numRows+1+"\"> Origin Station Id</label>"
	cell4.innerHTML =	" <input required name=\"destId"+numRows+1+"\" type=\"number\"/> <label for=\"destId"+numRows+1+"\"> Destination Station Id</label>"
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
   
   
     <form action="reservationSubmission.jsp" method="post">
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
     <button  name="llll" type="submit">Submit</button>
     </form>
   
   	<button onclick="window.location.href='customerReservations.jsp';">Cancel Reservation</button>
	
   
      </body>
</html>