<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
            <%@ page import="java.io.*,java.util.*,java.sql.*"%>
    <%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
   <head>
      <title>Admin Command Center</title>
   </head>
   <body>
     <p>Group 11:  Joshua Ross (jjr276), Ronak Parikh (rpp108), Bridget Savage (bhs46), James Hadley (jwh129), Srija Gottiparthi (sg1416)</p>
     <h3>Command Center</h3>
     
     <%
     	out.println("<p> Welcome Site Administrator " + ((String) (session.getAttribute("user")))+".</p>");
        out.println("<button onclick=\"window.location.href='messaging.jsp';\">Messages</button>");
        out.println("<button onclick=\"window.location.href='repMessaging.jsp';\">Reply to Messages</button>");
        out.println("<button onclick=\"window.location.href='logout.jsp';\">Log Out</button>");
     %>
     
     
     
         <form action="adminModifyLogin.jsp" method="post">
        <h5>Modify/Create Login Of Username:</h5>
        <input required name="username" type="text"/>
        
        <h5>Which Is A</h5>

  <input required type="radio" name="type" value="customer"/>Customer
  <br>
  <input required type="radio" name="type" value="employee"/>Employee
        <br>
        <h5>Action To Perform</h5>
          <input required type="radio" name="action" value="add"/>Add
  			<br>
  			<input required type="radio" name="action" value="edit"/>Edit
  			<br>
  			<input required type="radio" name="action" value="delete"/>Delete
        
        <br><br>
        
        
        <button>Continue</button>
    </form>
     
     
     
      <br><br>
     
     
     
     <form action="adminSalesReport.jsp" method="post">
     <h5>Calculate Sales Report For The Month Of</h5>
     
    <select required name="month" >
    <option value='1'>January</option>
    <option value='2'>February</option>
    <option value='3'>March</option>
    <option value='4'>April</option>
    <option value='5'>May</option>
    <option value='6'>June</option>
    <option value='7'>July</option>
    <option value='8'>August</option>
    <option value='9'>September</option>
    <option value='10'>October</option>
    <option value='11'>November</option>
    <option value='12'>December</option>
    </select>
  
	<input required type="number" name="year" min="1000" max="9999">
     
     <br><br>
     <button>Calculate</button>
     </form>
     
     
      <br><br>
     
     
    <form action="adminListReservations.jsp" method="post">
        <h5>List Reservations Of</h5>
        
        <input required name="key" type="text"/>
        
        <h5>Which Is A</h5>

  <input required type="radio" name="type" value="customerName"/>Customer Name
  <br>
  <input required type="radio" name="type" value="transiteLine"/>Transit Line Name
        <br><br>
        <button>Search</button>
    </form>
    
    
     <br><br>
    
    
    
        <form action="adminListRevenue.jsp" method="post">
        <h5>List Revenue Of</h5>
        
        <input required name="key" type="text"/>
        
        <h5>Which Is A</h5>

  <input required type="radio" name="type" value="customerName"/>Customer Name
  <br>
  <input required type="radio" name="type" value="transiteLine"/>Transit Line Name
  <br>
  <input required type="radio" name="type" value="destinationCity"/>Destination City
        <br><br>
        <button>Search</button>
    </form>
    
    
     <br><br>
    
    <h5>Best Customer:</h5>
    
    
     <br><br>
    
    <h5>Top 5 Most Active Train Lines:</h5>
    
    
    
     <br><br>
    
    <%  out.println("<button onclick=\"window.location.href='logout.jsp';\">Log Out</button>"); %>
     
   </body>
</html>