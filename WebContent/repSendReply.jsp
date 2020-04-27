<!-- MADE BY SRIJA GOTTIPARTHI, DATABASES GROUP 11 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sending reply...</title>
</head> 
<body>
	<%
		int qid = Integer.parseInt(request.getParameter("qid"));
		String newReply = request.getParameter("reply");
		String uName = (String)session.getAttribute("user");
		//String ssn = "";
		//String agent = null;
		//String reply = null;
		
		Database db = new Database();
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    Statement st2 = con.createStatement();
	    
	    //ResultSet ssns = st2.executeQuery("SELECT ssn from Employee_Customer_Rep WHERE username='" + uName + "';");
	    //if (ssns.next())
	    //{
	    	//ssn = ssns.getString("ssn");
	    //}
	    
	    String query = "UPDATE Messages SET reply=\'" + newReply + "\', usernameOfRep=\'" + uName + "\' WHERE messageid= " + qid + ";";
	    st.executeUpdate(query);
	    st.close();
	    st2.close();
	    //ssns.close();
    	db.closeConnection(con);
	%>
	<h3>Reply sent!</h3>
	<form action="repMessaging.jsp" method="post">
    	<button>Return to Messaging Dashboard</button>
    </form>
</body>
</html>