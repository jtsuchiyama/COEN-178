SET SERVEROUTPUT ON;
SET ECHO ON;

/* Part A */
CREATE OR REPLACE PROCEDURE addItemOrder (orderid NUMBER, item_id NUMBER, customerid NUMBER, date_ordered DATE, number_ordered NUMBER, shipped_date DATE)
AS
	number_copies Store_Items.num_copies%type;
	customer_type Customers.cust_type%type;
	shipping_fee Item_Orders.shipping_fee%type;
BEGIN
	SELECT num_copies INTO number_copies FROM Store_Items WHERE itemid = item_id;
	IF number_ordered > number_copies THEN
		Raise_Application_Error(-20999,'The number of copies ordered is greater than the number of copies in stock');
	END IF;

	SELECT cust_type INTO customer_type FROM Customers WHERE custid = customerid;
	IF customer_type = 'regular' THEN
		shipping_fee:= 10;
	ELSE
		shipping_fee:= 0;
	END IF;

	INSERT INTO Item_Orders VALUES(orderid, customerid, item_id, date_ordered, shipping_fee, '', number_ordered);

	UPDATE Store_Items SET num_copies = number_copies - number_ordered WHERE itemid = item_id;
END;
/
SHOW ERRORS;

/* Part B */
CREATE OR REPLACE TRIGGER goldUpdateTrig
AFTER UPDATE ON Customers
FOR EACH ROW
DECLARE
BEGIN 
	UPDATE Item_Orders SET shipping_fee = 0 WHERE :old.custid = custid AND :old.cust_type <> :new.cust_type AND :new.cust_type = 'gold' AND shipped_date IS NULL;
	DBMS_OUTPUT.PUT_LINE('Updating all shipping fees for customer with cust id ' || :old.custid || ' since they are now a gold customer.');
END;
/
SHOW ERRORS;

/* Part C */
CREATE OR REPLACE PROCEDURE setShippingDate(order_id NUMBER, shippingDate DATE)
AS
	ordered_date Item_Orders.date_of_order%type;
BEGIN
	SELECT date_of_order INTO ordered_date FROM Item_Orders WHERE orderid = order_id;
	IF ordered_date > shippingDate THEN
		Raise_Application_Error(-20999,'The shippedDate is less than the OrderedDate');
	ELSE
		UPDATE Item_Orders SET Shipped_Date = shippingDate WHERE orderid = order_id;
	END IF;
END;
/
SHOW ERRORS;

/* Part D */
CREATE OR REPLACE FUNCTION computeTotal(order_id NUMBER)
RETURN NUMBER IS
	total NUMBER(5,2);
	item_id Item_Orders.itemid%type;
	price_ Store_Items.price%type;

	num_ordered Item_Orders.num_items%type;

	shippingFee Item_Orders.shipping_fee%type;

	cust_id Item_Orders.custid%type;
	custType Customers.cust_type%type;
	
BEGIN
	SELECT itemid INTO item_id FROM Item_Orders WHERE orderid = order_id;
	SELECT price INTO price_ FROM Store_Items WHERE itemid = item_id;

	SELECT num_items INTO num_ordered FROM Item_Orders WHERE orderid = order_id;

	SELECT shipping_fee INTO shippingFee FROM Item_Orders WHERE orderid = order_id;

	SELECT custid INTO cust_id FROM Item_Orders WHERE orderid = order_id;
	SELECT cust_type INTO custType FROM Customers WHERE custid = cust_id;

	total:= (price_ * num_ordered + shippingFee);

	IF custType = 'gold' AND total >= 100 THEN
		total:= total * 0.9;
	END IF;

	total:= total*1.05;

	RETURN total;
END;
/
SHOW ERRORS;

/* Part E */
CREATE OR REPLACE PROCEDURE showItemOrders(customerid NUMBER, less_date DATE)
AS
	CURSOR c1 IS SELECT * FROM Item_Orders WHERE less_date < date_of_order AND custid = customerid;
	cust_name Customers.name%type;
	email_phone Customers.phone_email%type;
	cust_address Customers.address%type;
	custType Customers.cust_type%type;

	item_price Store_Items.price%type;
	item_title Store_Items.title%type;

	total_items NUMBER;
	tax NUMBER;
	discount NUMBER;
	grand_total NUMBER;
BEGIN
	FOR item_order IN c1 LOOP
		SELECT name, phone_email, address, cust_type INTO cust_name, email_phone, cust_address, custType FROM Customers WHERE Customers.custid = item_order.custid;
		DBMS_OUTPUT.PUT_LINE('Customer Name: ' || cust_name);
		DBMS_OUTPUT.PUT_LINE('Customer ID: ' || item_order.custid);
		DBMS_OUTPUT.PUT_LINE('Phone Number/Email: ' || email_phone);
		DBMS_OUTPUT.PUT_LINE('Address: ' || cust_address);		

		SELECT price, title INTO item_price, item_title FROM Store_Items WHERE item_order.itemid = Store_Items.itemid;
		DBMS_OUTPUT.PUT_LINE('Order ID: ' || item_order.orderid);
		DBMS_OUTPUT.PUT_LINE('Item ID: ' || item_order.itemid);
		DBMS_OUTPUT.PUT_LINE('Title: ' || item_title);
		DBMS_OUTPUT.PUT_LINE('Price of Item: ' || item_price);
		DBMS_OUTPUT.PUT_LINE('Date Ordered: ' || item_order.date_of_order);
		DBMS_OUTPUT.PUT_LINE('Shipped Date: ' || item_order.shipped_date);
		
		total_items:= item_price * item_order.num_items + item_order.shipping_fee;
		tax:= 5;
		IF custType = 'gold' AND total_items >= 100 THEN
			discount:= 10;
		ELSE
			discount:= 0;
		END IF;

		grand_total:= computeTotal(item_order.orderid);		

		DBMS_OUTPUT.PUT_LINE('Total for all Items: ' || total_items);
		DBMS_OUTPUT.PUT_LINE('Tax: ' || tax || '%');
		DBMS_OUTPUT.PUT_LINE('Shipping Fee: ' || item_order.shipping_fee);
		DBMS_OUTPUT.PUT_LINE('Discount: ' || discount || '%');
		DBMS_OUTPUT.PUT_LINE('Grand Total: ' || grand_total);
	END LOOP;
END;
/
SHOW ERRORS
