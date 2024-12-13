create database hospital;
use hospital;
  # 1 patient table
create  table patient(
patient_id int primary key,
patient_name varchar(50),
patient_age int not null,
patient_gender varchar(20),
patient_address varchar(30),
patient_phone varchar(15) not null
);
insert into patient(patient_id,patient_name,patient_age,patient_gender,patient_address,patient_phone)
					values(1,'manju',23,'male','dharmapuri', 9345728406),
						  (2,'prathick',22,'male','chennai', 8056158698),
                          (3,'ezhumalai',23,'male','viluppuram',9787862491),
                          (4,'hemalatha',23,'female','karur',8110095665),   
					      (5,'keerthana',23,'female', 'tamilnadu', 7788994455);
drop table patient;
truncate table patient; 
select *from patient; 

set sql_safe_updates=0;     
select now();

      # 2 doctor table 
create table doctor(
doctor_id int primary key ,
doctor_name varchar(50) not null,
doctor_speciality varchar(50),
doctor_schedule varchar(60),
doctor_phone_number varchar(70),
doctor_staff_id int
);
insert into doctor values (1,'manju','heart','morning',9345728406,1),
						 (2,'arun','eye','eving',8056158698,2),
						 (3,'bala','teerth','night',9787862491,3),
						 (4,'vijay','brain','morning',8110095665,4),
						 (5,'ajith','bone','eving',7788994455,5);
drop table doctor;
truncate table doctor;
select *from doctor;

      # 3 appointment table
create table appointment(
tocken_id int primary key auto_increment,
patient_id int,foreign key(patient_id) references patient (patient_id),
doctor_id int,foreign key (doctor_id) references doctor(doctor_id),
appointment_date date,
appointment_time varchar(70)
);
insert into appointment(patient_id,doctor_id,appointment_date,appointment_time)
                       values (1, 1, '2020-07-01', '10:01:am'),
                              (2, 2, '2021-05-22', '09:20:am'),
                              (3, 3, '2022-02-06', '02:30:pm'),
                              (4, 4, '2023-09-15', '11:10:pm'),
							  (5, 5, '2024-07-19', '07:50:am');
drop table appointment;
truncate table appointment;
select*from appointment;

		# 4 patient history
create table patient_history(
patient_id int,foreign key (patient_id) references patient (patient_id),
patient_height decimal(5,2),
patient_weight decimal(4,2) ,
patient_bp varchar(30),
patient_tempreage varchar(52),
patient_issue varchar(60)
);
insert into patient_history(patient_id,patient_height,patient_weight,patient_bp,patient_tempreage,patient_issue)
                            values(1,100.63,50.10,100,110,'eye'),
					              (2,150.96,55.22,108,120,'heart'),
					              (3,123.85,60.88,112,130,'teerth'),
					              (4,125.56,65.85,115,140,'bone'),
							      (5,182.72,70.44,128,150,'brain');
select * from patient_history;
drop table patient_history;
truncate table patient_history;
select distinct *from  patient_history;

         # 5 staff details
create table staff_details(
staff_id int primary key auto_increment ,
staff_fir_name varchar(50),
staff_sec_name varchar(50),
staff_roll varchar(50),
staff_salary int,
staff_date date
);
insert into staff_details (staff_fir_name,staff_sec_name,staff_roll,staff_salary,staff_date)
						  values('kavi','nesh','management',25000,'2021-01-02'),
						        ('sakthi','vel','insurance',30000,'2022-05-22'), 
                                ('dinesh','kumar','pharmacy',33000,'2023-08-15'),
						        ('manju','nathan','casher',40000,'2024-10-17'),
								('arun','kumar','parking',50000,'2025-05-19');
drop table staff_details;
truncate table staff_details;
select distinct *from staff_details;
select*from staff_details;

        # 6 room
create table room(
room_number int primary key auto_increment,
room_type varchar(50),
staff_id int,foreign key(staff_id) references staff_details(staff_id),
admission_date date 
);
insert into room(room_type,staff_id,admission_date)
                 values('icu',1,'2021-05-20'),
					   ('ccu',2,'2022-09-23'),
                       ('general',3,'2023-06-18'),
                       ('ac',4,'2019-08-30'),
                       ('general',5,'2020-01-15');                       
drop table room;
truncate table room;
select distinct *from room;
select*from room;
                       
		# 7 bill table 
create table bill(
invoice_number int primary key auto_increment,
patient_id int,foreign key(patient_id) references patient (patient_id),
bill_name varchar(20),
bill_date date,
cost_method varchar(50)
);
insert into bill (patient_id, bill_name,bill_date,cost_method)
									values(1,'manju','2021-05-05','cash'),
									      (2,'bala','2022-08-08','phonepe'),
										  (3,'vijay','2023-06-09', 'cash'),
										  (4,'manju','2018-01-22','gpay'),
										  (5,'murgan','2016-11-30','phonepe');
select * from bill;
drop table bill;
select distinct *from bill;
truncate table bill;

insert into bill (patient_id, bill_name,bill_date,cost_method,total_cost)
values (5,'manju',2015-07-15,'cash',30000);ly

#alter
alter table bill add column total_cost int ;
alter table bill rename column cost_method to payment_method; 
alter table bill add column total_amount int;
alter table bill drop total_amount;
select*from bill;

#one row delete
delete from bill where patient_id=5;

# modify
alter table bill modify bill_name varchar(50);

# update
update bill set total_cost=20000 where patient_id=1;
update bill set total_cost=80000 where patient_id=2;
update bill set total_cost=20000 where patient_id=3;
update bill set total_cost=50000 where patient_id=4;
update bill set total_cost=30000 where patient_id=5;

# count cash
select * from bill where payment_method ='cash';
select bill_name,count(*)as count from bill where bill_name='manju' ;

#aggregate function
select min(total_cost) from bill;
select max(total_cost) from bill;
select avg(total_cost) from bill;
select sum(total_cost) from bill;
select count(patient_id) from bill;
select*from bill;

#subquery
select *from bill where total_cost=(select min(total_cost) from bill);
select *from bill where total_cost=(select max(total_cost)from bill);

# >, <, <=, =>, =, !
select *from bill where total_cost >50000;
select *from bill where total_cost <36000;
select*from bill where total_cost <=35000;
select *from bill where total_cost >=50000;
select *from bill where total_cost !=35000;
select *from bill;

#between
select *from bill where total_cost between 20000 and 30000 order by total_cost asc; 
select *from bill where total_cost between 20000 and 50000 order by total_cost desc;
select *from bill where total_cost not between 50000 and 68000 order by total_cost desc;
select*from bill;

#not min and max clear
select min(total_cost)as total_cost from bill;
  
# second largest number in salary
select max(total_cost) from bill where total_cost <(select max(total_cost) from bill);
select * from bill;

#second values 
select (total_cost) from bill order by  patient_id desc limit 3 offset 1;
select * from bill;


#order by / asc,desc
select *from bill order by bill_name;
select *from bill order by invoice_number asc; 
select *from bill order by invoice_number desc; 
select * from bill;

#group by /having by
select bill_name ,count(*),avg(total_cost)as total from bill group by bill_name; 
select bill_name ,count(*),avg(total_cost)as total from bill group by bill_name having bill_name='manju';

#concat
select*from staff_details;
select concat(staff_fir_name,'   ',staff_sec_name) as staff_name from staff_details;

#upper and lower/staff_details
select upper(staff_fir_name) as staff_fir_name from staff_details;
select lower(staff_fir_name) as staff_fir_name from staff_details;

select lower(staff_sec_name) as staff_sec_name from staff_details;
select upper(staff_sec_name) as staff_sec_name from staff_details;

#upper and lower/bill
select upper(bill_name) from bill;
select lower(bill_name) from bill;

#like
select * from bill where bill_name like 'm%';
select * from bill where bill_name like '____u%';
select * from bill where bill_name like '%___a';
select * from bill where bill_name like 'm%';
select * from bill where bill_name like '%y';
select * from bill;

select*from patient;
select*from doctor;

# 1) left join / patient and doctor;
select patient.patient_id,patient.patient_name,patient.patient_age  ,  doctor.doctor_id,doctor.doctor_name,doctor.doctor_phone_number 
from patient
left join doctor on patient.patient_id=doctor.doctor_id;

select*from patient;
select * from doctor;

# 2) right join / patient and bill;
select patient.patient_id,patient.patient_name,  bill.invoice_number,bill.bill_name,bill.payment_method
from patient
right join bill on patient.patient_id=bill.invoice_number;

select*from patient;
select*from bill;

# 3) left join / doctor and room;
select doctor.doctor_id,doctor.doctor_name,doctor.doctor_staff_id  ,  room.room_number,room.room_type,room.staff_id
from doctor
left join room on doctor.doctor_id=room.staff_id;

select*from doctor;
select*from room;

# inner join / doctor and bill;
select doctor.doctor_id,doctor.doctor_name,doctor.doctor_phone_number  ,  bill.patient_id,bill.bill_name,bill.total_cost
from doctor
inner join bill on doctor.doctor_id=bill.patient_id;

# inner join / patient and doctor;
select patient.patient_id,patient.patient_name   ,  doctor.doctor_id,doctor.doctor_name 
from patient 
inner join doctor on patient.patient_id=doctor.doctor_id;

# outer join / patient and doctor;
select patient.patient_id,patient.patient_name   ,  doctor.doctor_id,doctor.doctor_name 
from patient
 outer join doctor on patient.patient_id=doctor.doctor_id;

# self join / patient and doctor;
create view joins as 
select patient.patient_id,patient.patient_name  ,  doctor.doctor_id,doctor.doctor_name 
from patient,
doctor where patient.patient_id=doctor.doctor_id;
select *from bill;

#case
select *,
case when  room_type='ccu' then 'critical care'
when room_type='icu' then 'intensive care'
else 'normal care'
end as status from room;

# all tablessssss
select * from patient;
select * from doctor;
select * from appointment;
select * from patient_history;
select * from staff_details;
select * from room;
select * from bill;
