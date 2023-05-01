CREATE TABLE Customer (
custid varchar(5),
firstname varchar(10),
lastname varchar(15),
city varchar(10),
PRIMARY KEY (custid)
);

CREATE TABLE DeliveryService (
serviceid varchar(10),
item varchar(15),
location varchar (15),
servicefee float,
PRIMARY KEY (serviceid)
);

CREATE TABLE Schedule (
serviceid varchar(10), 
FOREIGN KEY (serviceid) REFERENCES DeliveryService(serviceid),
custid varchar(5), 
FOREIGN KEY (custid) REFERENCES Customer(custid),
day varchar(2) NOT NULL CHECK (day in ('m','t','w','r','f'))
);
