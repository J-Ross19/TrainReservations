Group 11 TrainReservations Project
CS 336 Rutgers University

Group Members: Ronak Parikh (rpp108), Joshua Ross (jjr276), Srija Gottiparthi (sg1416), Bridget Savage, James Hadley

Project URL: http://ec2-18-217-84-106.us-east-2.compute.amazonaws.com:8080/FinalProject/

Credentials:
Here is all the login info for everything in the form (username, password):
gmail (group11datamanagement@gmail.com,asecurepassword)
Amazon AWS (group11datamanagement@gmail.com,Asecurepassw0rd) note the 0 and uppercase A
RDS DB (admin, asecurepassword) the name of the DBMS in the RDS server is group11database
The URL of the RDS MySQL database is group11database.cyivjxy8m4jv.us-east-2.rds.amazonaws.com on port 3306 and you can do like group11database.cyivjxy8m4jv.us-east-2.rds.amazonaws.com:3306/<Name of Database in MySQL> to access a particular database in the MySQL database server.
EC2 Webserver keypair name is asecurekey and the actual private key is a file called asecurekey.pem that is attached which was converted into asecureputtykey.ppk which is also attached (you need the putty key to ssh into the EC2 server (probably dont ever need to do that though)).
The ec2 server public URL is ec2-18-217-84-106.us-east-2.compute.amazonaws.com and it hosts the Apache Tomcat7 webserver. You can ssh into it using putty with the private puttykey file mentioned above in SSH>Auth in the drop down menu on the side when you open putty and with the host name ec2-user@ec2-18-217-84-106.us-east-2.compute.amazonaws.com
If you go to ec2-18-217-84-106.us-east-2.compute.amazonaws.com:8080 in a browser like chrome, you get to the control panel where you can manage the running Tomcat7 webserver, and if you login with (admin,asecurepassword) on the managerApp button you can deploy war files. To then see the running final app you go to ec2-18-217-84-106.us-east-2.compute.amazonaws.com:8080/<name of app>



Admin login of website:
  Username: admin
  Password: admin

Who did what:
ER Diagram (entire group)
Schema (Ronak + Joshua)
I. Create accounts of users; login, logout. (Joshua + Ronak)
II. Browsing and search functionality (Bridget)
  [X] search for train schedules by origin, destination, date of travel
  [X] sort by different criteria (by arrival time, departure time, origin, destination, fare)
  [X] a user should be able to see all the stops a train will make
III. Reservations (James)
  [X] a customer should be able to make a reservation for a specific route (Ronak: GUI/Javascript, James: all else)
  [X] get a discount in case of child/senior/disabled
  [X] cancel existing reservation
  [X] view current and past reservations with their details.
IV. Messaging functions (Srija)
  [X] send a question to the customer service (customer reps will reply it)
  [X] Rep replies to customer questions (I misread the checklist and did this too because I thought it was my part)
  [X] browse questions and answers
  [X] search questions and answers
  [X] get an alert message in case a route is delayed.
V. Admin functions (Ronak)
  [X] Admin (create an admin account ahead of time)
  [X] Add, Edit and Delete information for an employee/customer
  [X] Obtain sales reports for a particular month
  [X] Produce a list of reservations:
  [X] by transit line and train number (e.g. NortheastCorridor #3425)
  [X] by customer name
  [X] Produce a listing of revenue per:
  [X] transit line
  [X] destination city
  [X] customer name
  [X] best customer
  [X] best 5 most active transit lines
VI. Customer representative: (Joshua)
  [X] Add, Edit and Delete reservations
  [X] Add, Edit and Delete information for train schedules
  [X] Replies to customer questions (Note. Srija did this believing it was part of messaging)
  [X] Produces a list of train schedules for a specific origin and destination
  [X] Produces a list of train schedules for a given station (as origin/destination)
  [X] Produce a list of all customers who have seats reserved on a given transit line and train
