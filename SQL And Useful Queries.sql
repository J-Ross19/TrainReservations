Create database TrainDatabase;
Use TrainDatabase;
create table Train (id int primary key auto_increment, num_seats int, num_cars int);
create table Station (id int primary key auto_increment, name varchar(100), state varchar(5), city varchar(100));
Create table Employee_Customer_Rep (ssn char(11) , name_firstname varchar(100), name_lastname varchar(100), username varchar(100) primary key, password varchar(100));
create table Employee_Site_Manager (ssn char (11) , name_firstname varchar(100), name_lastname varchar(100), username varchar(100) primary key, password varchar(100));
create table Customer (username varchar(100) primary key, password varchar(100), email varchar(100), street_address varchar(100), city varchar(100), state varchar(5), telephone varchar(20), zip varchar(100), name_firstname varchar(100), name_lastname varchar(100));
create table Reservation_Portfolio (reservation_number int primary key auto_increment, date_made datetime, booking_fee double, isMonthly boolean, isWeekly boolean, isRoundTrip boolean, username varchar(100) not NULL, foreign key(username) references Customer(username) on delete cascade);
create table Schedule_Origin_of_Train_Destination_of_Train_On (transit_line_name varchar(100) primary key, isDelayed boolean, normal_fare double, senior_child_fare double, disabled_fare double, destination_arrival_time datetime, destination_departure_time datetime, origin_arrival_time datetime, origin_departure_time datetime, origin_station_id int not NULL, foreign key(origin_station_id) references Station(id) on delete cascade, destination_station_id int not NULL, foreign key(destination_station_id) references Station(id) on delete cascade, train_id int not NULL, foreign key(train_id) references Train(id) on delete cascade);
create table Has_Ride_Origin_Destination_PartOf ( connection_number int auto_increment, class enum ('economy', 'business', 'first') , seat_number int , isChildOrSenior boolean,isDisabled boolean, reservation_number int, foreign key(reservation_number) references Reservation_Portfolio (reservation_number) on delete cascade, primary key (connection_number, reservation_number), origin_id int not NULL, foreign key(origin_id) references Station(id) on delete cascade, destination_id int not NULL, foreign key(destination_id) references Station(id) on delete cascade, transit_line_name varchar(100) not NULL, foreign key(transit_line_name) references Schedule_Origin_of_Train_Destination_of_Train_On(transit_line_name) on delete cascade);
create table Stops_In_Between (transit_line_name varchar(100), foreign key(transit_line_name) references Schedule_Origin_of_Train_Destination_of_Train_On(transit_line_name) on delete cascade, id int, foreign key(id) references Station(id) on delete cascade, departure_time datetime, arrival_time datetime, primary key (transit_line_name, id));
create table Messages (messageid int primary key auto_increment, username varchar(100) not NULL, topic varchar(50), message varchar(1000), usernameOfRep varchar(100), reply varchar(1000), foreign key(username) references Customer(username) on delete cascade, foreign key(usernameOfRep) references Employee_Customer_Rep(username) on delete cascade);

#database inserts
insert into Employee_Site_Manager(ssn,name_firstname,name_lastname,username,password) values ('000-00-0000','Admin','Admin','admin','admin');
insert into Train(id,num_seats,num_cars) values (3,30,2);
insert into Station(id,name,state,city) values (5,'Piscataway Stop','NJ','Piscataway'),(6,'Princeton Stop','NJ','Princeton'), (7,'AC Stop','NJ','Atlantic City');
insert into Customer(username,password,email,street_address,city,state,telephone,zip,name_firstname,name_lastname) values('ron','par','fdf','fdfd','fdfd','df','fefd','fef','dfdf','dfddf'),('ben','par','fdf','fdfd','fdfd','df','fefd','fef','dfdf','dfddf');
insert into Reservation_Portfolio(reservation_number,date_made,booking_fee,isMonthly,isWeekly,isRoundTrip,username) values (15,'2020-01-01 10:10:10',40,false,false,true,'ron'),(16,'2020-01-01 10:10:10',300,false,true,false,'ron'),(17,'2020-01-01 10:10:10',1000,true,false,false,'ben');
insert into Schedule_Origin_of_Train_Destination_of_Train_On(transit_line_name,isDelayed,normal_fare,senior_child_fare,disabled_fare,destination_arrival_time,destination_departure_time,origin_arrival_time,origin_departure_time,origin_station_id,destination_station_id,train_id) values
('NJ Southern 83', false, 60,30,15,'2020-01-30 20:00:00','2020-01-30 21:00:00','2020-01-30 10:00:00','2020-01-30 10:30:00',5,7,3);
insert into Has_Ride_Origin_Destination_PartOf(connection_number,class,seat_number,isChildOrSenior,isDisabled, reservation_number, origin_id,destination_id,transit_line_name) values
(1,'first',3,false,false,15,5,6,'NJ Southern 83'),(2,'economy',3,false,false,15,5,6,'NJ Southern 83');
insert into Stops_In_Between(transit_line_name,id,departure_time,arrival_time) values
('NJ Southern 83',6,'2020-01-30 11:30:00','2020-01-30 15:30:00');

insert into Train(id,num_seats,num_cars) values (5,60,3);
insert into Station(id,state,city) values (1,'NJ','Manasquan'),(2,'NJ','Long Branch'), (3,'NJ','Newark');
insert into Schedule_Origin_of_Train_Destination_of_Train_On(transit_line_name,isDelayed,normal_fare,senior_child_fare,disabled_fare,destination_arrival_time,destination_departure_time,origin_arrival_time,origin_departure_time,origin_station_id,destination_station_id,train_id) values
('NJ Coastal 24', false, 20,10,5,'2020-01-30 10:00:00','2020-01-30 11:00:00','2020-01-30 07:00:00','2020-01-30 07:30:00',1,3,5);
insert into Stops_In_Between(transit_line_name,id,departure_time,arrival_time) values
('NJ Coastal 24',2,'2020-01-30 08:30:00','2020-01-30 08:00:00'), ('NJ Coastal 24',5,'2020-01-30 09:30:00','2020-01-30 09:00:00');
update Station set name = 'Manasquan Stop' where id = 1;
update Station set name = 'Long Branch Stop' where id = 2;
update Station set name = 'Newark Penn' where id = 3;

#total fare (fare for each train taken + booking fee) for all reservations
select reservation_number, (booking_fee+sum(fare)) as totalfare from (select reservation_number, booking_fee, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as fare from (select r.reservation_number, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k) as n group by reservation_number
union
select reservation_number, booking_fee as totalfare from Reservation_Portfolio as ri where ri.isWeekly or ri.isMonthly;

#revenue by customer
select sum(totalfare) as totalfare from (
select reservation_number, (booking_fee+sum(fare)) as totalfare from (select reservation_number, booking_fee, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as fare from (select r.reservation_number, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k) as n group by reservation_number
union
select reservation_number, booking_fee as totalfare from Reservation_Portfolio as ri where ri.isWeekly or ri.isMonthly
) as cq, Reservation_Portfolio as rr where cq.reservation_number = rr.reservation_number and rr.username = USERNAMEHERE;
#by transitlinename
select  sum(farefare) as totalfare from 
(select reservation_number, transit_line_name, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as farefare from (select r.reservation_number, rd.transit_line_name, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k)
 as jl where transit_line_name = TRANSITHERE;
 #by destination city
 select  sum(farefare) as totalfare from 
(select reservation_number, transit_line_name, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as farefare from (select r.reservation_number, rd.transit_line_name, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k)
 as jl where transit_line_name in 
 (
 select transit_line_name from
(select zz.transit_line_name, origin_station_id, destination_station_id,id from Schedule_Origin_of_Train_Destination_of_Train_On as zz, Stops_In_Between as zx where zz.transit_line_name = zx.transit_line_name)as gggg
where origin_station_id in
(select id from Station where city = CITYHERE)
or destination_station_id in
(select id from Station where city = CITYHERE)
or id in
(select id from Station where city = CITYHERE)
 ); # all transit lines that stop at a sation with a destination city


#total sales of month
select sum(totalfare) from Reservation_Portfolio as jjk, (
select reservation_number, (booking_fee+sum(fare)) as totalfare from (select reservation_number, booking_fee, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as fare from (select r.reservation_number, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k) as n group by reservation_number
union
select reservation_number, booking_fee as totalfare from Reservation_Portfolio as ri where ri.isWeekly or ri.isMonthly
) as lkl where jjk.reservation_number = lkl.reservation_number and month(jjk.date_made) = 1 and year( jjk.date_made) = "2020";

#top transit lines
select transit_line_name, numberOfReservations from (select s.transit_line_name, count(*) as numberOfReservations from Has_Ride_Origin_Destination_PartOf as r, Schedule_Origin_of_Train_Destination_of_Train_On as s where s.transit_line_name=r.transit_line_name group by s.transit_line_name) as q order by numberOfReservations desc;

#get list of reservations
select  * from Reservation_Portfolio as reservations left outer join Has_Ride_Origin_Destination_PartOf as rides on rides.reservation_number = reservations.reservation_number where reservations.username = 'ron';
select  * from Reservation_Portfolio as reservations left outer join Has_Ride_Origin_Destination_PartOf as rides on rides.reservation_number = reservations.reservation_number where transit_line_name = 'NJ Southern 83';

#all rides
select  * from Reservation_Portfolio as reservations left outer join Has_Ride_Origin_Destination_PartOf as rides on rides.reservation_number = reservations.reservation_number;

#Lists to show
select * from Schedule_Origin_of_Train_Destination_of_Train_On;
select * from Stops_In_Between;
select username , "Customer" as type from Customer union select username, "Customer Rep" as type from Employee_Customer_Rep union select username, "Site Manager" as type from Employee_Site_Manager;
select * from Train;
select * from Station;


#best customer
select username from (select username, sum(totalfare) as totalCustomer from (select ff.username, ff.reservation_number, fg.totalfare from (select r.username, r.reservation_number from Reservation_Portfolio as r) as ff, (select reservation_number, (booking_fee+sum(fare)) as totalfare from (select reservation_number, booking_fee, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as fare from (select r.reservation_number, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k) as n group by reservation_number union select reservation_number, booking_fee as totalfare from Reservation_Portfolio as ri where ri.isWeekly or ri.isMonthly) as fg where ff.reservation_number = fg.reservation_number) as jj group by username) as kl where kl.totalCustomer in (select max(totalCustomer) as totalCustomer from (select username, sum(totalfare) as totalCustomer from (select ff.username, ff.reservation_number, fg.totalfare from (select r.username, r.reservation_number from Reservation_Portfolio as r) as ff, (select reservation_number, (booking_fee+sum(fare)) as totalfare from (select reservation_number, booking_fee, (if(isChildOrSenior,senior_child_fare,if(isDisabled,disabled_fare,normal_fare))*if(class='economy',1,if(class='business',1.5,2))) as fare from (select r.reservation_number, booking_fee, class,isChildOrSenior,isDisabled,normal_fare,senior_child_fare,disabled_fare  from Reservation_Portfolio as r, Has_Ride_Origin_Destination_PartOf as rd, Schedule_Origin_of_Train_Destination_of_Train_On as s where r.reservation_number = rd.reservation_number and rd.transit_line_name=s.transit_line_name) as k) as n group by reservation_number union select reservation_number, booking_fee as totalfare from Reservation_Portfolio as ri where ri.isWeekly or ri.isMonthly) as fg where ff.reservation_number = fg.reservation_number) as jj group by username) as kjkh);
