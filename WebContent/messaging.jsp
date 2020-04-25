<!-- MADE BY SRIJA GOTTIPARTHI, DATABASES GROUP 11 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Message a Customer Representative</title>
</head>
<body>
     <h3>Message a Customer Representative</h3>
    <form action="sendMessage.jsp" method="post">
        <h5>Message topic:</h5>
        <input name="topic" type="text">
        <h5>Message:</h5>
        <input name="message" type="text"/>
        <br><br>
        <button>Send</button>
    </form>
    <h3>A representative will get back to you as soon as possible.</h3>
    <br>
    <h3>Past Messages:</h3>
    <%
	    Database db = new Database();
	    Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    Statement st2 = con.createStatement();
	    
	    String uName = (String)session.getAttribute("user");
	    ResultSet rs = st.executeQuery("SELECT * from Messages where username=\'" + uName + "\'");
	    while(rs.next())
	    {
	    	String u = rs.getString("username");
	    	String t = rs.getString("topic");
	    	String m = rs.getString("message");
	    	String ssn = rs.getString("ssn");
	    	String a = "";
	    	ResultSet agents = st2.executeQuery("SELECT username from Employee_Customer_Rep WHERE ssn=\'" + ssn + "\';");
	    	if (agents.next())
	    	{
	    		a = agents.getString("username");
	    	}
	    	String rep = rs.getString("reply");
	    	String displayMessage = "";
	    	if (a == null || rep == null)
	    	{
	    		displayMessage = "Topic: " + t 
	    	    		+ "<br>Message: " + m + "<br>Response: No response.";
	    	}
	    	else
	    	{
	    		displayMessage = "Topic: " + t + "<br>Message: " + m 
			    		+ "<br>Response: " + rep + "<br>Agent: " + a;
	    	}
	    	
	    	out.print("<p>" + displayMessage + "</p>");
	    }
	    
	    st.close();
	    st2.close();
    	db.closeConnection(con);
    %>
   </body>
</html>