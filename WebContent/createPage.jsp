<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Create Account</title>
</head>
<body>
<p>Group 11:  Joshua Ross (jjr276), Ronak Parikh (rpp108), Bridget Savage (bhs46), James Hadley (jwh129), Srija Gottiparthi (sg1416)</p>
<h3>Create an Account</h3>
<form action="create.jsp" method="post">
    <h5>First Name</h5> <input type="text" name="name_firstname" autocomplete="off" required>
    <h5>Last Name</h5> <input type="text" name="name_lastname" autocomplete="off" required>
    <h5>Username </h5><input type="text" name="username" autocomplete="off" required>
    <h5>Password  </h5><input type="password" name="password" autocomplete="off" required>
    <h5>Email </h5><input type="text" name="email" autocomplete="off" required> <br/>
    <h5>Street Address </h5> <input type="text" name="street_address" autocomplete="off" required>
    <h5> City</h5> <input type="text" name="city" autocomplete="off" required>
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
    <h5>Zip Code</h5> <input type="text" name="zip" autocomplete="off" required>
    <h5>Phone Number</h5> <input type="text" name="telephone" autocomplete="off" required><br/><br><br>
    <input type="submit" value="Create Account"><br><br><br>
</form>
</body>
</html>