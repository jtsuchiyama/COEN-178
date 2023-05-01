CREATE TABLE AlphaCoEmp(
Name VARCHAR(25) Primary Key, 
Title VARCHAR(20) DEFAULT NULL, 
Salary Number(10,2) DEFAULT 0
);

INSERT INTO AlphaCoEmp (name) SELECT last from Staff;
INSERT INTO AlphaCoEmp (name) SELECT DISTINCT last from Staff;
SELECT * FROM AlphaCoEmp;

Create Table Emp_Work(
name VARCHAR(25) Primary Key, 
Project VARCHAR(20) default NULL,
Constraint FK_AlphaCo Foreign Key (name) REFERENCES AlphaCoEmp(name)
);

insert into Emp_Work(name) (Select Name from AlphaCoEmp where REGEXP_LIKE(name,'(^[ags])','i'));
SELECT name FROM Emp_Work;
Delete from AlphaCoEmp Where name='Smith';

Alter table Emp_Work drop constraint FK_AlphaCo;
Alter table Emp_Work add constraint FK_AlphaCo FOREIGN KEY (name) references AlphaCoEmp(name) on delete cascade;
Delete from AlphaCoEmp Where name='Smith';
SELECT name FROM Emp_Work WHERE name='Smith';
