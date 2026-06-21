create database flight_book;
use flight_book;
create table airline (airline_id int primary key auto_increment,
                      name varchar(50));
insert into airline (name) values('Alaska Airlines');
create table airport (airport_id int primary key auto_increment,
					  name varchar(50),
                      code varchar(50), 
                      city varchar(50));
insert into airport (name,code,city) values
('Los Angeles Intl Airport','LAX','Los Angeles'),
('San Francisco Intl Airport','SFO','San Francisco');
create table flight (flight_id int primary key auto_increment,
airline_id int,
flight_number varchar(10),
departure_airport int,
arrival_airport int,
duration varchar(20),
distance int,
foreign key (airline_id) references airline(airline_id),
foreign key (departure_airport) references airport(airport_id),
foreign key (arrival_airport) references airport(airport_id));
insert into flight (airline_id,flight_number,departure_airport,arrival_airport,duration,distance) values
(1,'1490',1,2,'1h 15m',236),
(1,'1473',2,1,'1h 15m',236);
create table passenger (passenger_id int primary key auto_increment,
                        name varchar(100));
insert into passenger (name) values
('john smith'),
('jennifer smith');
create table booking (booking_id int primary key auto_increment,
                      confirmation_number varchar(20),
                      booking_date date);
insert into booking (confirmation_number,booking_date) values
('taegkx','2019-04-01');
create table ticket (ticket_id int primary key auto_increment,
                     ticket_number varchar(20),
					 passenger_id int,
                     booking_id int,
                     price decimal(10,2),
                     foreign key (passenger_id) references passenger(passenger_id),
                     foreign key (booking_id) references booking(booking_id));
insert into ticket (ticket_number,passenger_id,booking_id,price) values
('0177200658',1,1,357.60),
('0178410326',2,1,357.60);
create table flight_schedule (schedule_id int primary key auto_increment,
                              flight_id int,
                              departure_time datetime,
                              arrival_time datetime,
                              class varchar(50),
                              foreign key (flight_id) references flight(flight_id));
insert into flight_schedule (flight_id, departure_time, arrival_time, class) values
(1,'2019-04-05 08:20:00','2019-04-05 09:35:00','economy'),
(2,'2019-04-07 14:00:00','2019-04-07 15:15:00','economy');
create table booking_flight (booking_id int,
                             schedule_id int,
						     primary key (booking_id,schedule_id),
                             foreign key (booking_id) references booking(booking_id),
                             foreign key (schedule_id) references flight_schedule(schedule_id));
insert into booking_flight (booking_id, schedule_id) values(1,1),(1,2);
# show booking details
select b.confirmation_number, p.name, t.ticket_number, t.price
from booking b
join ticket t on b.booking_id = t.booking_id
join passenger p on t.passenger_id = p.passenger_id;

# flight details with airports
select f.flight_number, a1.code as departure, a2.code as arrival
from flight f
join airport a1 on f.departure_airport = a1.airport_id
join airport a2 on f.arrival_airport = a2.airport_id;

# total booking cost
select sum(price) as total_price
from ticket
where booking_id = 1;

# count total passengers in a booking
select booking_id, count(*) as total_passengers
from ticket
group by booking_id;

# find highest ticket price
select max(price) as highest_price
from ticket;

# total revenue generated
select sum(price) as total_revenue
from ticket;

# find earliest flight
select min(departure_time) as earliest_flight
from flight_schedule;

# find latest flight
select max(arrival_time) as latest_flight
from flight_schedule;