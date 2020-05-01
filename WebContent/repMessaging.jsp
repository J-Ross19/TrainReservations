<!-- MADE BY SRIJA GOTTIPARTHI, DATABASES GROUP 11 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Representative Messaging Dashboard</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
	<style>
	body {
	margin: 0 !important;
	}
	</style>
</head>
<body>
    <%
    	if ((session.getAttribute("user") == null) || (session.getAttribute("employee") == null))
    	{
    		response.sendRedirect("notFound.jsp");
    	}
	%>
    
    <h3>Respond to Customers</h3>
    <form action="repSendReply.jsp" method="post">
        <h5>Question ID:</h5>
        <input name="qid" type="text">
        <h5>Response:</h5>
        <input name="reply" type="text"/>
        <br><br>
        <button>Send</button>
    </form>
    <form action="customerRepHome.jsp">
    	<button>Back to Home</button>
    </form>
    <br>
    <h3>Unanswered Messages:</h3>
    <%
	    Database db = new Database();
	    Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    
	    //String uName = (String)session.getAttribute("user");
	    ResultSet rs = st.executeQuery("SELECT * from Messages where usernameOfRep IS NULL and reply IS NULL");
	    if(!rs.next())
	    {
	    	out.print("<p>There are no unanswered messages.</p>");
	    }
	    else
	    {
	    	while(rs.next())
		    {
		    	int qid = rs.getInt("messageid");
		    	String u = rs.getString("username");
		    	String t = rs.getString("topic");
		    	String m = rs.getString("message");

		    	String displayMessage = "Question ID: " + qid + "<br>Customer Username: " + u + "<br>Topic: " + t + "<br>Message: " + m;
		    	
		    	out.print("<p>" + displayMessage + "</p>");
		    }
	    }
	    
	    st.close();
	    rs.close();
    	db.closeConnection(con);
    %>
   </body>
</html>