-- 테이블 명세
-- 1. 캠핑카대여회사는 캠핑카들을 관리/운영한다.
-- 2. 캠핑카정비소는 정비되는 캠핑카에 대한 수리기록을 유지한다.
-- 3. 고객은 캠핑카를 정비소를 통해 정비할 수 있다.
-- 4. 고객은 캠핑카를 대여할 수 있다.

-- create database carrent;
use carrent;
create table rentcompanys(
	company_id varchar(10) not null primary key,
    company_addr varchar(30) not null,
    company_phone varchar(15) not null,
    rent_resonable_person varchar(10) not null,
    rent_resonable_email varchar(25)
);

ALTER TABLE rentcompanys ADD CONSTRAINT company_id_pk PRIMARY KEY (company_id);

create table rentcars(
	car_id varchar(13) not null,
    company_id varchar(10) not null,
    carname varchar(20) not null,
    carnumber varchar(7) not null,
    passengers int not null,
    car_image varchar(14) not null,
    detail_info varchar(40),
    car_expense decimal(8,2) not null,
    regist_car_date date not null
);

ALTER TABLE rentcars ADD CONSTRAINT rentcar_id_pk PRIMARY KEY (car_id, company_id);

ALTER TABLE rentcars ADD (CONSTRAINT R_1 FOREIGN KEY (company_id) REFERENCES rentcompanys(company_id));

create table repairshops(
	shop_id varchar(10) not null,
    shop_name varchar(20) not null,
    shop_addr varchar(15) not null,
    shop_phone varchar(15) not null,
    shop_resonable_person varchar(15) not null,
    shop_resonable_email varchar(20)
);

ALTER TABLE repairshops ADD CONSTRAINT shop_id_pk PRIMARY KEY (shop_id);

create table customers(
	driver_id varchar(20) not null,
    cust_name varchar(15) not null,
    cust_phone varchar(15) not null,
    cust_email varchar(20),
    prior_use_date date not null,
    prior_use_car varchar(15) not null
);

ALTER TABLE customers ADD CONSTRAINT customer_id_pk PRIMARY KEY (driver_id);

create table rentinfos(
	rent_id varchar(20) not null,
    car_id varchar(13) not null,
    company_id varchar(10) not null,
    driver_id varchar(20) not null,
    rent_start_date date not null,
    charge_fee decimal(8,2) not null,
    duedate date not null,
    other_billing_info varchar(40),
    other_billing_fee decimal(8,2)
);

ALTER TABLE rentinfos ADD CONSTRAINT rent_id_pk PRIMARY KEY (rent_id);

ALTER TABLE rentinfos ADD (CONSTRAINT R_2 FOREIGN KEY (car_id) REFERENCES rentcars(car_id));
ALTER TABLE rentinfos ADD (CONSTRAINT R_3 FOREIGN KEY (company_id) REFERENCES rentcars(company_id));
ALTER TABLE rentinfos ADD (CONSTRAINT R_4 FOREIGN KEY (driver_id) REFERENCES customers(driver_id));

create table repairinfos(
	repair_id varchar(15) not null,
    car_id varchar(13) not null,
    shop_id varchar(10) not null,
    company_id varchar(10) not null,
    driver_id varchar(20) not null,
    repair_info varchar(40) not null,
    repair_date date not null,
    repair_fee decimal(10,2) not null,
    repair_fee_duedate date not null,
    other_repair_info varchar(40)
);

ALTER TABLE repairinfos ADD CONSTRAINT repairinfo_id_pk PRIMARY KEY (repair_id);

ALTER TABLE repairinfos ADD (CONSTRAINT R_5 FOREIGN KEY (car_id) REFERENCES rentcars(car_id));
ALTER TABLE repairinfos ADD (CONSTRAINT R_6 FOREIGN KEY (company_id) REFERENCES rentcars(company_id));
ALTER TABLE repairinfos ADD (CONSTRAINT R_7 FOREIGN KEY (driver_id) REFERENCES customers(driver_id));
ALTER TABLE repairinfos ADD (CONSTRAINT R_8 FOREIGN KEY (shop_id) REFERENCES repairshops(shop_id));

commit;