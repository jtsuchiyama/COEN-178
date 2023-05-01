DELETE FROM Item_Orders;
DELETE FROM Customers;
DELETE FROM Store_Items;

INSERT INTO Customers VALUES (0,'Jake',8084222222,'415 S Beretania St, Honolulu, HI 96813','gold','16-MAY-19');
INSERT INTO Customers VALUES (1,'Landis',8081111111,'1315 10th St, Sacramento, CA 95814','gold','02-MARCH-20');
INSERT INTO Customers VALUES (2,'Justin',8084204204,'12333 W Olympic Blvd, Los Angeles, CA','regular','21-JUNE-21');
INSERT INTO Customers VALUES (3,'Jarin',8088088088,'3308 Kanaina Ave, Honolulu, HI 96815','regular','08-JAN-19');
INSERT INTO Customers VALUES (4,'Ryan',8081234567,'20 W 34th St, New York, NY 10001','regular','11-DEC-22');

INSERT INTO Store_Items VALUES (0, 15, 1, 0, 'sm','','','','');
INSERT INTO Store_Items VALUES (1, 20, 1, 0, 'lrg','','','','');
INSERT INTO Store_Items VALUES (2, 25, 1, 0, 'xl','','','','');
INSERT INTO Store_Items VALUES (3, 15, 0, 1, '','9781421582696','My Hero Academia','5','4-APR-15');
INSERT INTO Store_Items VALUES (4, 15, 0, 1, '','9781569319000','Naruto','9','16-APR-03');
INSERT INTO Store_Items VALUES (5, 15, 0, 1, '','9781974700523','Demon Slayer','7','03-APR-18');
