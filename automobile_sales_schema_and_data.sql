create database automobile_sales;
use automobile_sales;


create table Brand (
    brand_id varchar(20) primary key,
    name varchar(50) not null,
    company_name varchar(100) not null
);


create table Model (
    model_id varchar(20) primary key,
    name varchar(50) not null,
    body_style varchar(30) not null,
    color varchar(30) not null,
    engine varchar(50) not null,
    transmission varchar(50) not null,
    brand_id varchar(20) not null,
    foreign key (brand_id) references Brand(brand_id)
);


create table Supplier (
    supplier_id varchar(20) primary key,
    name varchar(100) not null,
    plant_city varchar(50) not null,
    phone varchar(20)
);


create table Plant (
    plant_id varchar(20) primary key,
    name varchar(100) not null,
    type varchar(50) not null,
    city varchar(50) not null,
    state varchar(50) not null
);


create table Part (
    part_id varchar(20) primary key,
    name varchar(100) not null,
    type varchar(50) not null,
    mfg_date date not null,
    model_id varchar(20) not null,
    supplier_id varchar(20) null,
    plant_id varchar(20) null,
    foreign key (model_id) references Model(model_id),
    foreign key (supplier_id) references Supplier(supplier_id),
    foreign key (plant_id) references Plant(plant_id)
);


create table Dealer (
    dealer_id varchar(20) primary key,
    name varchar(100) not null,
    phone varchar(20),
    street varchar(150) not null,
    city varchar(50) not null,
    state varchar(50) not null,
    zip varchar(20) not null
);


create table Customer (
    c_id varchar(20) primary key,
    name varchar(100) not null,
    phone varchar(20),
    gender varchar(10) not null,
    annual_income decimal(12, 2) not null,
    street varchar(150) not null,
    city varchar(50) not null,
    state varchar(50) not null,
    zip varchar(20) not null
);


create table Vehicle (
    vin varchar(20) primary key,
    arrival_date date not null,
    sale_date date null,
    sale_price decimal(10, 2) null,
    status varchar(20) not null,
    model_id varchar(20) not null,
    plant_id varchar(20) not null,
    dealer_id varchar(20) not null,
    c_id varchar(20) null,
    part_id varchar(20) not null,
    foreign key (model_id) references Model(model_id),
    foreign key (plant_id) references Plant(plant_id),
    foreign key (dealer_id) references Dealer(dealer_id),
    foreign key (c_id) references Customer(c_id),
    foreign key (part_id) references Part(part_id)
);


insert into Brand (brand_id, name, company_name) values
('B001', 'Volkswagen', 'Volkswagen Group India'),
('B002', 'Skoda', 'Volkswagen Group India'),
('B003', 'Audi', 'Volkswagen Group India'),
('B004', 'Tata', 'Tata Motors'),
('B005', 'Mahindra', 'Mahindra & Mahindra');


insert into Model (model_id, name, body_style, color, engine, transmission, brand_id) values
('M001', 'Virtus GT', '4-Door Sedan', 'Cherry Red', '1.5L TSI Petrol', '7-Speed DCT', 'B001'),
('M002', 'Slavia', '4-Door Sedan', 'Crystal Blue', '1.5L TSI Petrol', '7-Speed DCT', 'B002'),
('M003', 'A5 Cabriolet', 'Convertible', 'Mythos Black', '2.0L TFSI Petrol', '7-Speed DCT', 'B003'),
('M004', 'Harrier', 'SUV', 'Oberon Black', '2.0L Kryotec Diesel', '6-Speed Automatic', 'B004'),
('M005', 'Thar Convertible', 'Convertible', 'Red Rage', '2.0L mStallion Petrol', '6-Speed Automatic', 'B005');


insert into Supplier (supplier_id, name, plant_city, phone) values
('S001', 'Getrag', 'Pune', '9820111222'),
('S002', 'Getrag', 'Sanand', '9820111333'),
('S003', 'Bosch India', 'Bengaluru', '9845011444'),
('S004', 'Bharat Forge', 'Pune', '9822011555');


insert into Plant (plant_id, name, type, city, state) values
('PL01', 'Chakan Assembly Plant', 'Final Assembly', 'Pune', 'Maharashtra'),
('PL02', 'Aurangabad Luxury Plant', 'Final Assembly', 'Aurangabad', 'Maharashtra'),
('PL03', 'Jamshedpur Powertrain Plant', 'Parts Manufacturing', 'Jamshedpur', 'Jharkhand'),
('PL04', 'Pimpri Vehicle Plant', 'Final Assembly', 'Pune', 'Maharashtra');


insert into Part (part_id, name, type, mfg_date, model_id, supplier_id, plant_id) values
('PT01', 'Getrag 7DCT Gearbox Batch-A', 'Transmission', '2026-02-10', 'M001', 'S001', null),
('PT02', 'Getrag 7DCT Gearbox Batch-B', 'Transmission', '2026-02-15', 'M002', 'S001', null),
('PT03', 'Getrag S-Tronic Gearbox', 'Transmission', '2026-01-05', 'M003', 'S001', null),
('PT04', 'Getrag 6AT Gearbox Sanand', 'Transmission', '2026-02-12', 'M005', 'S002', null),
('PT05', 'Kryotec Engine Block', 'Engine', '2025-08-20', 'M004', null, 'PL03'),
('PT06', 'Bosch ECU Module', 'Electronics', '2024-05-10', 'M001', 'S003', null);


insert into Dealer (dealer_id, name, phone, street, city, state, zip) values
('D001', 'Autobahn Motors', '9820555101', 'Andheri East', 'Mumbai', 'Maharashtra', '400069'),
('D002', 'Sundaram Luxury Cars', '9845555102', 'MG Road', 'Bengaluru', 'Karnataka', '560001'),
('D003', 'Fairdeal Auto', '9431555103', 'Bistupur Main Road', 'Jamshedpur', 'Jharkhand', '831001'),
('D004', 'Connaught Royale Motors', '9811555104', 'Connaught Place', 'New Delhi', 'Delhi', '110001');


insert into Customer (c_id, name, phone, gender, annual_income, street, city, state, zip) values
('C001', 'Rajesh Sharma', '9876543210', 'Male', 1800000.00, 'MG Road', 'Bengaluru', 'Karnataka', '560001'),
('C002', 'Priya Patel', '9876543211', 'Female', 2400000.00, 'FC Road', 'Pune', 'Maharashtra', '411004'),
('C003', 'Amitabh Verma', '9876543212', 'Male', 4500000.00, 'Park Street', 'Kolkata', 'West Bengal', '700016'),
('C004', 'Sneha Iyer', '9876543213', 'Female', 1200000.00, 'Anna Salai', 'Chennai', 'Tamil Nadu', '600002'),
('C005', 'Vikram Singh', '9876543214', 'Male', 3200000.00, 'Sakchi Boulevard', 'Jamshedpur', 'Jharkhand', '831001'),
('C006', 'Ananya Das', '9123456780', 'Female', 5500000.00, 'Banjara Hills', 'Hyderabad', 'Telangana', '500034');


insert into Vehicle (vin, arrival_date, sale_date, sale_price, status, model_id, plant_id, dealer_id, c_id, part_id) values
('VIN2024VW001', '2024-06-01', '2024-06-15', 1750000.00, 'Sold', 'M001', 'PL01', 'D001', 'C001', 'PT06'),
('VIN2024MH002', '2024-03-01', '2024-03-12', 1680000.00, 'Sold', 'M005', 'PL04', 'D003', 'C004', 'PT04'),
('VIN2025TT003', '2025-09-01', '2025-09-25', 2250000.00, 'Sold', 'M004', 'PL04', 'D003', 'C005', 'PT05'),
('VIN2025AU004', '2025-03-05', '2025-03-20', 6800000.00, 'Sold', 'M003', 'PL02', 'D004', 'C003', 'PT03'),
('VIN2026VW005', '2026-02-20', '2026-03-05', 1780000.00, 'Sold', 'M001', 'PL01', 'D001', 'C002', 'PT01'),
('VIN2026SK006', '2026-02-22', '2026-03-10', 1760000.00, 'Sold', 'M002', 'PL01', 'D001', 'C001', 'PT02'),
('VIN2026AU007', '2026-01-15', '2026-03-18', 6900000.00, 'Sold', 'M003', 'PL02', 'D004', 'C006', 'PT03'),
('VIN2026MH008', '2026-02-25', '2026-03-22', 1700000.00, 'Sold', 'M005', 'PL04', 'D002', 'C005', 'PT04'),
('VIN2026TT009', '2026-07-10', '2026-08-05', 2300000.00, 'Sold', 'M004', 'PL04', 'D003', 'C004', 'PT05'),
('VIN2026AU010', '2026-05-01', null, null, 'In Inventory', 'M003', 'PL02', 'D004', null, 'PT03'),
('VIN2026VW011', '2026-09-15', null, null, 'In Inventory', 'M001', 'PL01', 'D002', null, 'PT01');