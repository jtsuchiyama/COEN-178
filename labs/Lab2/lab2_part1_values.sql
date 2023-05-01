INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('c1','John','Smith','SJ');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('c2', 'Mary', 'Jones','SFO');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('a1', 'Vincent','Chen','SJ');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('a12', 'Greg', 'King','SJ');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('c7', 'James','Bond','LA');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('x10', 'Susan','Blogg','SFO');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('d4','Jake','Tsuchiyama','HNL');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('d7','Jarin','Simon','SLC');
INSERT INTO Customer(custid, firstname, lastname, city) VALUES ('r2','Jenna','Yoshimi','SJ');

INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dsg1','grocery','SJ',25.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dsb1','books','SJ',10.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dsm2','movies','LA',10.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dby3','babygoods','SFO',15.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dsg2','grocery','SFO',20.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('dg5','greengoods','SFO',30.0);
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('vg9','videogames','HNL','15.0');
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('ff4', 'fastfood','SLC','7.5');
INSERT INTO DeliveryService(serviceid, item, location, servicefee) VALUES ('pf2','petfood','SJ','10.0');

INSERT INTO Schedule(serviceid,custid,day) VALUES ('dsg1','c1','m');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('dsg1','a12','w');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('dby3','x10','f');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('dg5','c1','r');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('dg5','c1','t');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('dg5','c32','t');

INSERT INTO Schedule(serviceid,custid,day) VALUES ('dsg2','c1','s');

INSERT INTO Schedule(serviceid,custid,day) VALUES ('vg9','d4','w');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('ff4','d7','m');
INSERT INTO Schedule(serviceid,custid,day) VALUES ('pf2','r2','f');
