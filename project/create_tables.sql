DROP TABLE Item_Orders;
DROP TABLE Customers;
DROP TABLE Store_Items;

CREATE TABLE Customers (
	custid NUMBER(5,0) PRIMARY KEY,
	name VARCHAR(50),
	phone_email VARCHAR(50) UNIQUE NOT NULL,
	address VARCHAR(75),
	cust_type VARCHAR(7) CHECK (cust_type='regular' OR cust_type='gold'),
	date_joined DATE
);

CREATE TABLE Store_Items (
	itemid NUMBER(5,0) PRIMARY KEY,
	price NUMBER(5,2),
	is_tshirt VARCHAR(1),
	is_comic VARCHAR(1),
	tshirt_size VARCHAR(3),
	isbn NUMBER (13,0) UNIQUE,
	title VARCHAR(50),
	num_copies NUMBER(5,0) CHECK (num_copies >= 0),
	published_date DATE
);

CREATE TABLE Item_Orders (
	orderid NUMBER(5,0) PRIMARY KEY, 
	custid NUMBER(5,0),
	itemid NUMBER(5,0),
	date_of_order DATE,
	shipping_fee NUMBER(2,0),
	shipped_date DATE,
	num_items NUMBER(5,0),
	CONSTRAINT custid_fkey FOREIGN KEY (custid)REFERENCES Customers(custid),
	CONSTRAINT itemid_fkey FOREIGN KEY (itemid)REFERENCES Store_Items(itemid),
	CHECK (shipped_date >= date_of_order)
);
