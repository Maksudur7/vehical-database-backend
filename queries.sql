create table Users (
  user_id serial primary key,
  name varchar(50),
  email varchar(100) unique not null,
  phone varchar(50) not null,
  role varchar(20) check(role in('Admin', 'Customer'))
)

create table Vehicles(
  vehicle_id serial primary key,
  name varchar(50),
  type varchar(20) not null check(type in('car','bike','truck')),
  model varchar(20) not null,
  registration_number varchar(50) not null unique,
  rental_price varchar(20) not null,
  status varchar(20) not null check(status in('available', 'rented', 'maintenance'))
)

create table Bookings(
  booking_id serial primary key,
  user_id int references Users(user_id) on delete cascade,
  vehicle_id int references Vehicles(vehicle_id) on delete cascade,
  start_date date not null,
  end_date date not null,
  status varchar(20) not null check(status in('completed', 'confirmed', 'pending')),
  total_cost decimal(10,2) not null
)
  
select b.booking_id, u.name as customer_name, v.name as vehicle_name , b.start_date, b.end_date, b.status from Bookings b
join Users u using(user_id)
join Vehicles v using(vehicle_id)

select * from Vehicles v 
where not exists(
  select * from Bookings b where b.vehicle_id = v.vehicle_id
)

select * from Vehicles v
where v.status = 'available' and v.type = 'car'

select v.name as vehical_name , count(b.booking_id) from Bookings b
join Vehicles v using(vehicle_id) 
group by v.name 
having count(b.booking_id) > 2;







