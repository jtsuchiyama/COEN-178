SELECT * FROM Customer;
SELECT * FROM DeliveryService;
SELECT * FROM Schedule;
SELECT firstname||lastname AS fullname FROM Customer;
SELECT * FROM Customer ORDER BY lastname;
SELECT * FROM Schedule ORDER BY serviceid ASC, custid DESC;
SELECT serviceid FROM DeliveryService WHERE serviceid NOT IN (SELECT serviceid FROM Schedule);
SELECT firstname FROM Customer, Schedule WHERE day='m' AND Customer.custid = Schedule.custid;

SELECT DISTINCT lastname FROM Customer, Schedule WHERE Customer.custid IN (SELECT custid FROM Schedule);
SELECT MAX(servicefee) highest_Servicefee FROM DeliveryService;
SELECT day,COUNT(day) FROM Schedule GROUP BY day; 
SELECT A.custid, B.custid, A.city FROM Customer A, Customer B WHERE A.city = B.city AND A.custid < B.custid;
SELECT DISTINCT Customer.custid, Customer.firstname, Customer.lastname, Customer.city FROM Customer, DeliveryService, Schedule WHERE Customer.custid IN (SELECT custid FROM Schedule) AND DeliveryService.serviceid = Schedule.serviceid AND Customer.city = DeliveryService.location;
SELECT MIN(salary), MAX(salary) FROM staff;
