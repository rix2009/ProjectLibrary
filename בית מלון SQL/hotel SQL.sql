create schema hotel_hilton;
use hotel_hilton;
 
 create table job(
job_name char(25) not null,
hour_payment float,
primary key(job_name)
)engine = InnoDB;
 
create table worker(
worker_id char(13) not null,
first_name char(25),
last_name char(25),
date_of_birth date,
date_of_hire date,
job_name char(25),
manager_id char(13),
primary key(worker_id),
CONSTRAINT fk_job FOREIGN KEY (job_name) REFERENCES job(job_name)
on update cascade
on delete no action,
CONSTRAINT fk_manager_id FOREIGN KEY (manager_id) REFERENCES worker(worker_id)
on update cascade
on delete no action
)engine = innodb;

create table hotel_area(
area_number int not null,
area_name char(25),
open_hour time,
close_hour time,
primary key(area_number)
)engine = innodb;

create table worker_in_area(
area_number int not null,
worker_id char(13),
primary key(worker_id),
CONSTRAINT fk_area_number FOREIGN KEY (area_number) REFERENCES hotel_area(area_number)
on update cascade
on delete cascade,
CONSTRAINT fk_worker_id FOREIGN KEY (worker_id) REFERENCES worker(worker_id)
on update cascade
on delete cascade
)engine = innodb;

create table guest(
guest_id char(13) not null,
first_name char(25),
last_name char(25),
guest_country char(25),
contact_id char(13),
contact_phone char(20),
primary key(guest_id),
constraint fk_guest_contact_id foreign key (contact_id) references guest(guest_id)
on update cascade
on delete no action
)engine = InnoDB;

create table reservation(
res_number int not null,
credit_number char(19),
res_status char(25),
contact_id char(13),
primary key(res_number),
constraint fk_res_contact_id foreign key (contact_id) references guest(guest_id)
on update cascade
on delete no action
)engine = InnoDB;

create table room(
room_number int(4) not null,
room_type char(25),
housing_capacity int,
cost_per_night float,
r_description char(100),
area_number int,
primary key(room_number),
constraint fk_area_num foreign key (area_number) references hotel_area(area_number)
on update cascade
on delete no action
)engine = innodb;

create table room_in_reservation(
room_number int(4),
res_number int,
entry_date date,
exit_date date,
primary key(room_number, res_number, entry_date, exit_date),
constraint fk_room_number foreign key (room_number) references room(room_number)
on update cascade
on delete no action,
constraint fk_reservation_for_rooms foreign key (res_number) references reservation(res_number)
on update cascade
on delete cascade
)engine = InnoDB;

create table service(
ser_number int not null,
ser_name char(25),
ser_cost float,
area_number int,
primary key(ser_number),
constraint fk_service_area_number foreign key (area_number) references hotel_area(area_number)
on update cascade
on delete cascade
)engine = InnoDB;

create table service_in_reservation(
ser_number int,
ser_date date,
res_number int,
primary key(ser_number, ser_date, res_number),
constraint fk_service_number foreign key (ser_number) references service(ser_number)
on update cascade
on delete no action,
constraint fk_reservation_number foreign key (res_number) references reservation(res_number)
on update cascade
on delete cascade
)engine = InnoDB;

INSERT INTO `job` (`job_name`,`hour_payment`) VALUES 
("cleaner",27.92),
("bar-man",38.54),
("barista",36.60),
("waiter",35.20),
("receptionist",34.36),
("cook",28.35),
("manager",48.61),
("masagist",37.83),
("lifeguard",40.20);

INSERT INTO `worker` (`worker_id`,`first_name`,`last_name`,`date_of_birth`,`date_of_hire`,`job_name`,`manager_id`) VALUES
("1653052626199","Keane","Cote","82-11-15","17-01-25","manager","1653052626199"),
("1669082038499","Jillian","Little","98-08-31","20-04-08","manager","1669082038499"),
("1659081713199","Keane","Hooper","81-07-07","11-11-13","manager","1659081713199"),
("1665121847899","Frances","Abbott","78-06-17","13-06-28","waiter","1669082038499"),
("1626022648899","Nissim","Bartlett","92-09-27","13-09-16","waiter","1669082038499"),
("1687050511499","Rana","Chavez","91-11-26","16-01-10","waiter","1669082038499"),
("1654062711799","Joan","Stokes","75-06-27","19-06-24","receptionist","1669082038499"),
("1680022120099","Gillian","Gamble","99-03-29","16-12-13","receptionist","1669082038499"),
("1606081010399","Samuel","Saunders","78-05-27","11-08-23","masagist","1669082038499"),
("1628050600499","Denise","Hardin","84-09-04","11-03-20","bar-man","1669082038499"),
("1623051972399","Cleo","Bates","81-01-07","14-10-31","masagist","1659081713199"),
("1625102472499","Rhonda","Atkins","97-08-11","11-05-22","cook","1659081713199"),
("1654081382799","Harrison","Guy","90-04-26","11-05-31","bar-man","1659081713199"),
("1673063053399","Wing","Jenkins","99-12-10","15-04-16","barista","1653052626199"),
("1634112039799","Ulric","Beasley","71-09-12","16-04-25","bar-man","1653052626199"),
("1694040640899","Jermaine","Armstrong","82-03-15","19-04-15","waiter","1653052626199"),
("1665022216299","Rudyard","Hammond","70-01-15","18-11-08","cleaner","1653052626199"),
("1671030952699","Carla","Yates","80-07-16","11-10-18","cook","1653052626199"),
("1644041632399","Daryl","Baird","89-03-31","14-12-20","cleaner","1653052626199"),
("1608022254599","Aline","Gonzales","75-01-28","20-11-17","masagist","1653052626199"),
("1648002221989","Adam","Yona","93-03-03","20-10-09","lifeguard","1653052626199");

INSERT INTO `hotel_area` (`area_number`,`area_name`,`open_hour`,`close_hour`) VALUES
("2021","northern rooms","00:00","23:59"),
("2055","pool","07:00","18:00"),
("8922","dining room","07:30","20:30"),
("9573","loby","00:00","23:59"),
("3321","southern rooms","00:00","23:59"),
("9582","bar","12:00","01:30"),
("1234","office","08:00","17:00");

insert into `worker_in_area` (`area_number`,`worker_id`) values
("8922","1665121847899"),
("8922","1626022648899"),
("8922","1687050511499"),
("9573","1654062711799"),
("9573","1680022120099"),
("2055","1606081010399"),
("2055","1623051972399"),
("2055","1608022254599"),
("2055","1648002221989"),
("9582","1628050600499"),
("9582","1654081382799"),
("9582","1673063053399"),
("9582","1634112039799"),
("8922","1694040640899"),
("8922","1671030952699"),
("8922","1625102472499"),
("2021","1665022216299"),
("3321","1644041632399"),
("1234","1653052626199"),
("1234","1669082038499"),
("1234","1659081713199");

INSERT INTO `guest` (`guest_id`,`first_name`,`last_name`,`guest_country`,`contact_id`,`contact_phone`) VALUES
("1661071164299","Wyatt","Richard","Israel","1661071164299","059-221-8486"),
("1631052395299","Erich","Ruiz","Israel","1631052395299","057-787-0789"),
("1644031537599","Leo","Snow","Israel","1661071164299","059-221-8486"),
("1628070849299","Jamalia","Bailey","Israel","1628070849299","050-182-9676"),
("1619050763299","Avye","Fernandez","Israel","1661071164299","059-221-8486"),
("1620120518299","Barclay","Mcgee","Israel","1628070849299","050-182-9676"),
("1688102638799","Burke","Nash","Britania","1688102638799","056-353-1736"),
("1681030606999","Brian","Crosby","United States","1688102638799","056-353-1736"),
("1645061925799","Hedy","Ware","Israel","1688102638799","056-353-1736"),
("1689111640099","Pearl","Shepard","Greece","1631052395299","057-787-0789"),
("1670100510499","Germane","Walters","Peru","1628070849299","050-182-9676"),
("1643070747699","Ishmael","Massey","Israel","1643070747699","056-828-0350"),
("1675010160199","Jamalia","Owens","Switzerland","1643070747699","056-828-0350"),
("1629122654999","Nehru","Noble","Germeny","1643070747699","056-828-0350"),
("1630081367099","Abraham","Summers","Israel","1631052395299","057-787-0789"),
("1626022515999","Hilel","Hatfield","Israel","1643070747699","056-828-0350"),
("1679112011799","Randall","Swanson","Ireland","1679112011799","057-516-2403"),
("1648012788799","Serina","Oliver","Israel","1679112011799","057-516-2403"),
("1618021183199","Reuben","Gardner","Italy","1679112011799","057-516-2403"),
("1651090885299","Dorian","Sharp","France","1679112011799","057-516-2403");

INSERT INTO `reservation` (`res_number`,`credit_number`,`res_status`,`contact_id`) VALUES
("112508","5396-9236-1838-5060","recived","1643070747699"),
("116181","5118-5830-8576-9282","recived","1631052395299"),
("118728","5514-8874-8474-3784","paid","1679112011799"),
("114312","5307-3824-8397-5323","cancelled","1661071164299"),
("117019","5180-4211-4276-0999","cancelled","1628070849299"),
("111681","5357-8031-9593-1659","accepted","1628070849299"),
("111697","5404-4642-6167-6596","cancelled","1688102638799"),
("111141","5354-5654-2438-6558","paid","1643070747699"),
("119591","5371-1044-8738-0651","cancelled","1679112011799"),
("113677","5287-8460-9197-2074","paid","1628070849299"),
("117700","5585-6514-0412-0406","cancelled","1643070747699"),
("111299","5406-0114-7474-6688","accepted","1679112011799"),
("118251","5446-2039-2495-1818","recived","1631052395299"),
("115549","5163-4750-9519-4953","recived","1631052395299"),
("115313","5535-9551-7673-5247","paid","1631052395299"),
("116719","5448-0995-1018-0566","cancelled","1688102638799"),
("114620","5229-9108-3865-4691","recived","1661071164299"),
("111760","5236-5203-0552-8566","cancelled","1628070849299"),
("117591","5514-1378-4981-8909","paid","1688102638799"),
("116451","5408-5713-1725-8843","recived","1661071164299");

INSERT INTO `room` (`room_number`,`room_type`,`housing_capacity`,`cost_per_night`,`r_description`,`area_number`) VALUES
("2852","single",1,"1501.90","mauris. Morbi non sapien great view molestie","2021"),
("1898","primium",6,"5697.41","pede. Nunc sed orci relaxing lobortis augue","3321"),
("4188","twin",2,"3060.52","sem. Pellentesque ut relaxing ipsum ac mi eleifend egestas.","2021"),
("4687","single",1,"1470.54","lacus. Etiam bibendum relaxing fermentum metus.","3321"),
("5092","twin",2,"3077.02","ante ipsum primis in faucibus great view orci.","2021"),
("3335","double",3,"4606.12","et libero. Proin mi. Aliquam gravida easy acces mauris ut mi.","3321"),
("6210","double",3,"4192.67","malesuada augue ut lacus. Nulla tincidunt.","2021"),
("1810","double",3,"4941.11","ante ipsum primis in great view faucibus orci.","3321"),
("7047","single",1,"1169.13","aliquam adipiscing lacus easy acces.relaxing Ut nec urna.","2021"),
("9701","twin",2,"3144.51","dui, semper et, lacinia vitae, sodales at, velit.","3321"),
("3046","twin",2,"3029.25","sollicitudin commodo ipsum. Suspendisse non leo.","3321"),
("9863","suite",6,"8938.13","semper auctor. Mauris easy acces vel turpis.","2021"),
("7702","suite",6,"8146.96","Phasellus libero mauris, aliquam eu, accumsan sed.","3321"),
("2782","single",1,"1516.52","in, hendrerit consectetuer, relaxing cursus et, magna.","2021"),
("9778","primium",4,"6087.68","Integer sem elit, easy acces pharetra great view ut.","3321"),
("2944","twin",2,"3852.92","taciti sociosqu ad litora relaxing torquent per conubia nostra.","3321"),
("7909","primium",4,"5541.81","nulla. In tincidunt great view congue turpis. In condimentum.","2021"),
("3388","single",1,"1203.04","easy acces urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum.","2021"),
("8564","primium",4,"5389.86","non enim. Mauris easy acces quis turpis vitae purus gravida sagittis.","3321"),
("7689","presidential suit",8,"9903.56","sem elit, great view pharetra ut, pharetra sed, hendrerit a, arcu.","2021");

insert into `room_in_reservation` (`room_number`,`res_number`,`entry_date`,`exit_date`) values
("2852","112508","22-05-29","22-06-16"),
("4188","112508","22-05-29","22-06-16"),
("4687","112508","22-05-29","22-06-16"),
("2944","117700","21-09-03","21-10-11"),
("1898","116181","21-06-30","21-07-06"),
("4188","118728","22-01-18","22-01-25"),
("3335","114312","22-02-02","22-03-24"),
("3335","117019","22-01-30","22-02-11"),
("6210","117019","22-01-30","22-02-11"),
("7047","111681","21-11-27","21-12-10"),
("3046","111697","21-05-07","21-06-09"),
("2944","111141","21-07-30","21-08-27"),
("3388","111141","21-07-30","21-08-27"),
("9863","119591","21-10-07","21-10-14"),
("6210","113677","21-09-24","21-10-09"),
("1810","113677","21-09-24","21-10-09"),
("7689","117700","21-09-03","21-10-11"),
("7689","111299","21-08-23","21-08-28"),
("8564","118251","21-09-16","21-09-27"),
("9701","115549","21-08-24","21-08-30"),
("4188","115313","21-11-12","21-12-10"),
("2944","116719","22-05-30","22-06-15"),
("3335","114620","22-08-05","22-08-10"),
("3335","111760","22-06-11","22-06-18"),
("9863","117591","22-06-18","22-06-27"),
("9778","116451","21-08-20","21-08-31");

insert into `service` (`ser_number`,`ser_name`,`ser_cost`,`area_number`) values
("55432","massage",75.80,"2055"),
("55332","breakefast",35.80,"8922"),
("55232","lunch",65.25,"8922"),
("55132","dinner",72.35,"8922"),
("55532","swimming class",30.60,"2055"),
("55632","coctail",22.85,"9582"),
("55732","beer",15.85,"9582"),
("55832","jin&tonic",26.85,"9582"),
("55932","minibar refill",150.00,"2021"),
("55612","minibar refill",150.00,"3321"),
("55622","spaciel occasion prep",250.85,"2021"),
("55642","spaciel occasion prep",250.85,"3321"),
("55652","transfer",100.85,"9573"),
("55662","resturant room service",15.85,"8922");

insert into `service_in_reservation` (`ser_number`,`ser_date`,`res_number`) values
("55432","22-05-29","112508"),
("55332","21-06-02","112508"),
("55532","21-06-02","112508"),
("55532","21-07-02","116181"),
("55432","21-06-30","116181"),
("55332","22-01-18","118728"),
("55432","22-02-02","117019"),
("55622","22-01-30","117019"),
("55232","22-02-01","117019"),
("55432","21-11-27","111681"),
("55132","21-05-07","111697"),
("55832","21-07-30","111141"),
("55612","21-08-30","111141"),
("55652","21-10-07","119591"),
("55652","21-09-24","113677"),
("55652","21-10-09","113677"),
("55652","21-09-03","117700"),
("55332","21-08-23","111299"),
("55662","21-09-16","118251"),
("55332","21-08-24","115549"),
("55432","21-11-12","115313"),
("55432","22-05-30","116719"),
("55642","22-08-05","114620"),
("55132","22-06-11","111760"),
("55632","22-06-18","117591"),
("55532","21-08-20","116451");

/* #1 What is the most popular room and how many times it was booked?*/
select room_number, count(room_number) as "times_room_booked"
from room_in_reservation 
group by room_number
order by 2 desc
limit 1;

/* #2 What is the most expensive room?*/
select room_number, room_type, cost_per_night
from room
where (select max(cost_per_night) from room) = cost_per_night;

/* #3 How many guests are from every country?*/
select guest_country, count(guest_country) as num_of_guests
from guest 
group by guest_country
order by guest_country;

/* 4# What is the average, maximum, and minimum price for a room?*/
select min(cost_per_night) as "minimum room price", max(cost_per_night) as "maximum room price", avg(cost_per_night) as "average room price" 
from room;

/* #5 What is the revenue of each month in the year?*/
select month(rir.entry_date) as month, round((sum(r.cost_per_night)*(rir.exit_date - rir.entry_date)),2) as "sum_of_revenue_per_month"
from room as r join room_in_reservation as rir
on r.room_number = rir.room_number
join reservation as re
on rir.res_number = re.res_number
where re.res_status not like "cancelled"
group by 1
order by 2 desc;

/* 6# Which workers work in the pool and what are their jobs ,how much are they paid per hour? */
select worker.first_name, worker.last_name, worker.job_name, job.hour_payment
from worker
join worker_in_area on worker.worker_id = worker_in_area.worker_id
join hotel_area on hotel_area.area_number = worker_in_area.area_number
join job on worker.job_name = job.job_name
where hotel_area.area_name like "pool";

/* 7# the reservation “Erich” made and their expanses */
select reservation.res_number, reservation.res_status , room.room_number, datediff(room_in_reservation.exit_date, room_in_reservation.entry_date) as days_stayed,
round(room.cost_per_night * datediff(room_in_reservation.exit_date, room_in_reservation.entry_date), 2) as "room final cost",
service.ser_name, count(service_in_reservation.ser_number) as "amount of services", round(sum(service.ser_cost),2) as "sum service cost"
from reservation join guest
on reservation.contact_id = guest.guest_id
join room_in_reservation
on room_in_reservation.res_number = reservation.res_number
join room
on room_in_reservation.room_number = room.room_number
join service_in_reservation
on service_in_reservation.res_number = reservation.res_number
join service
on service_in_reservation.ser_number = service.ser_number
where guest.first_name like "Erich"
group by room.room_number, service_in_reservation.ser_number;

/* 8# Info about rooms with the words “great view”, “relaxing”, “easy access” in their description */
select * from room
where r_description like "%great view%" or r_description like "%relaxing%" or r_description like "%easy access%"
order by area_number, housing_capacity;

/* 9# All areas that are open between 18:00 and 20:00 and their openning and closing hours*/
select area_name, open_hour, close_hour
from hotel_area
where open_hour between "18:00" and "20:00" or close_hour between "18:00" and "20:00"
or (open_hour < "18:00" and close_hour > "20:00");

/* 10# How many workers each manager manage their names and where they work? */
select concat(manager.first_name, " " ,manager.last_name) as "manager", concat(worker.first_name, " ", worker.last_name) as "manages",
hotel_area.area_name
from worker as manager join worker
on manager.worker_id = worker.manager_id
join worker_in_area
on worker.worker_id = worker_in_area.worker_id
join hotel_area
on hotel_area.area_number = worker_in_area.area_number
where worker.worker_id not in (select distinct manager_id from worker)
group by worker.worker_id
order by manager.worker_id, hotel_area.area_name;

