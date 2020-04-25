<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="main.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    //Class.forName("com.mysql.jdbc.Driver");
    Database db = new Database();	
	Connection con = db.getConnection();
    Statement st = con.createStatement();
    Statement st2 = con.createStatement();
    ResultSet rs = st.executeQuery("select * from Customer where username='" + userid + "' and password='" + pwd + "'");
    ResultSet rs2 = st2.executeQuery("select * from Employee_Customer_Rep where username='" + userid + "' and password='" + pwd + "'");
    
    if (rs.next()&&userid!=null) {
    	rs.close();
    	st.close();
    	st2.close();
    	db.closeConnection(con);
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("<p>Logged in as " + userid+".</p>");
        out.println("<button onclick=\"window.location.href='messaging.jsp';\">Messages</button>");
        out.println("<button onclick=\"window.location.href='logout.jsp';\">Log Out</button>");
        //response.sendRedirect("success.jsp");
        //NOTE: I get that the success.jsp page is supposed to demonstrate using the sessions, but it makes no sense for a login page
        
    } 
    else if (rs2.next() && userid!=null)
    {
    	rs2.close();
    	st.close();
    	st2.close();
    	db.closeConnection(con);
        session.setAttribute("user", userid); // the username will be stored in the session
        out.println("<p>Logged in as Customer Rep " + userid+".</p>");
        out.println("<button onclick=\"window.location.href='messaging.jsp';\">Messages</button>");
        out.println("<button onclick=\"window.location.href='repMessaging.jsp';\">Reply to Messages</button>");
        out.println("<button onclick=\"window.location.href='logout.jsp';\">Log Out</button>");
    }
    else {
    	rs.close();
    	rs2.close();
    	st.close();
    	st2.close();
    	db.closeConnection(con);
        out.println("<p>That username and/or password was not recognized.</p> <button onclick=\"window.location.href='login.jsp';\">Go Back</button>");
    }
    
    rs.close();
    rs2.close();
%>
</body>
</html>