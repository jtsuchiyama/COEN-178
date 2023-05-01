SET SERVEROUTPUT ON;
SET ECHO ON;

START create_tables.sql;
START add_tuples.sql;
START functionality.sql;

/* 2.0 Demonstrating Functionality */
/* Part A */
SELECT itemid, num_copies FROM Store_Items;

/* Trying to order 6 copies of itemid 3 when there are only 5 copies */
exec addItemOrder(1,3,4,'12-MAY-22',6,'');

/* Successful order of itemid 3 since the number ordered of 1 is less than the number available of 5 */
exec addItemOrder(1,3,4,'12-MAY-22',1,'');

/* Successful update of the number of copies in the Store_Items table */
SELECT itemid, num_copies FROM Store_Items;

/* Inserting a regular member into Item_Orders table */
SELECT custid, cust_type FROM Customers WHERE custid = 4;
SELECT * FROM Item_Orders;

/* Inserting a gold member into Item_Orders table */
SELECT custid, cust_type FROM Customers WHERE custid = 1;
exec addItemOrder(2,1,1,'01-JUN-22',12,'');
SELECT * FROM Item_Orders;

/* Part B */
/* Updating the customer type of custid 2 from regular to gold to check if the trigger works as desired */
exec addItemOrder(3,0,2,'05-JUN-22',3,'');
exec setShippingDate(3, '07-JUN-22');
exec addItemOrder(4,1,2,'05-JUN-22',2,'');
SELECT * FROM Customers WHERE custid = 2;
SELECT * FROM Item_Orders;
UPDATE Customers SET cust_type = 'gold' WHERE custid = 2;
SELECT * FROM Customers WHERE custid = 2;
SELECT * FROM Item_Orders;

/* Part C */
/* Trying to set a shipping date that is less than the ordering date */
exec setShippingDate(1, '11-MAY-22');

/* Correctly setting the shipping date */
exec setShippingDate(1, '14-MAY-22');
exec setShippingDate(2, '04-JUN-22');

SELECT * FROM Item_Orders;

/* Part D */
/* Regular customer purchasing 1 of itemid 3 */
/* (15*1 + 10) * 1.05 = 26.25 */
SELECT computeTotal(1) FROM dual;

/* Gold customer purchasing 12 of itemid 1 (An order of greater than $100) */
/* (20*12) * 1.05 * 0.9 = 226.8 */
SELECT computeTotal(2) FROM dual;

/* Part E */
/* Showing the item orders for customer Justin with a custid of 2 with an order date after May 17, 2022 */
exec showItemOrders(2,'17-MAY-22');
