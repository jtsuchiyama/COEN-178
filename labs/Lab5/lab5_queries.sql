Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	DBMS_OUTPUT.put_line('Hello '||message);
END;
/
Show Errors;

SET SERVEROUTPUT ON

exec DisplayMessage('include a message');

Select ROUND(DBMS_RANDOM.value (10,100)) from DUAL;

UPDATE AlphaCoEmp SET salary = 0;

SELECT * FROM AlphaCoEmp;

Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	-- Local variables
	l_emprec Emp_cur%rowtype;
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		update AlphaCoEmp
	set salary = l_salary
	where name = l_emprec.name;
END LOOP;
commit;
END;
/
show errors;

exec setSalaries (50000,100000);

SELECT * FROM AlphaCoEmp;

SELECT * FROM AlphaCoEmp WHERE salary >= 80000 AND salary <= 100000;

SELECT * FROM AlphaCoEmp WHERE name='Wilson' OR name='Vega';

Create or Replace Procedure setEmpSalary(p_name in VARCHAR, low in
INTEGER, high in INTEGER)
As
Cursor Emp_cur IS 
	SELECT * FROM AlphaCoEmp;
	l_emprec Emp_cur%rowtype;
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		UPDATE AlphaCoEmp
	SET salary = l_salary
	WHERE name = p_name;
END LOOP;
commit;
END;
/
show errors;

exec setEmpSalary('Wilson',50000,100000);

SELECT * FROM AlphaCoEmp WHERE name='Wilson' OR name='Vega';

Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)
Return NUMBER IS
	l_salary AlphaCoEmp.salary%type;
BEGIN
	SELECT salary
	INTO l_salary
	FROM AlphaCoEmp
	where name=p_name;	

	return l_salary;
END;
/
show errors;

Select getEmpSalary('Wilson')
From Dual;

Create or Replace Procedure assignJobTitlesAndSalaries
As
	type titlesList IS VARRAY(5) OF AlphaCoEmp.title%type;
	type salaryList IS VARRAY(5) of AlphaCoEmp.salary%type;
	v_titles titlesList;
	v_salaries salaryList;
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	l_emprec Emp_cur%rowtype;
	l_title AlphaCoEmp.title%type;
	l_salary AlphaCoEmp.salary%type;
	l_randomnumber INTEGER := 1;

BEGIN
/* Titles are stored in the v_titles array */
/* Salaries for each title are stored in the v_salaries array.
The salary of v_titles[0] title is at v_salaries[0].
*/
v_titles := titlesList('advisor', 'director', 'assistant', 'manager','supervisor');
v_salaries := salaryList(130000, 100000, 600000, 500000, 800000);
/* use a for loop to iterate through the set */
for l_emprec IN Emp_cur
LOOP
	/* We get a random number between 1-5 both inclusive */
	l_randomnumber := dbms_random.value(1,5);
	/* Get the title using the random value as the index into the v_tiles array */
	l_title := v_titles(l_randomnumber);
	/* Get the salary using the same random value as the index into the v_salaries array */
	l_salary := v_salaries(l_randomnumber);
	/* Update the employee title and salary using the l_title and l_salary */
	update AlphaCoEmp
	set title = l_title
	where name = l_emprec.name;

	update AlphaCoEmp
	set salary = l_salary
	where name = l_emprec.name;
END LOOP;

commit;
END;
/
Show errors;

exec assignJobTitlesAndSalaries();

SELECT * FROM AlphaCoEmp;

Create or Replace Procedure assignJobTitlesAndSalaries
As
        type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type;
        type salaryList IS VARRAY(6) of AlphaCoEmp.salary%type;
        v_titles titlesList;
        v_salaries salaryList;
Cursor Emp_cur IS
        Select * from AlphaCoEmp;
        l_emprec Emp_cur%rowtype;
        l_title AlphaCoEmp.title%type;
        l_salary AlphaCoEmp.salary%type;
        l_randomnumber INTEGER := 1;

BEGIN
/* Titles are stored in the v_titles array */
/* Salaries for each title are stored in the v_salaries array.
The salary of v_titles[0] title is at v_salaries[0].
*/
v_titles := titlesList('advisor', 'director', 'assistant', 'manager','supervisor','bigboss');
v_salaries := salaryList(130000, 100000, 600000, 500000, 800000,'4200000');
/* use a for loop to iterate through the set */
for l_emprec IN Emp_cur
LOOP
        /* We get a random number between 1-5 both inclusive */
        l_randomnumber := dbms_random.value(1,6);
        /* Get the title using the random value as the index into the v_tiles array */
        l_title := v_titles(l_randomnumber);
        /* Get the salary using the same random value as the index into the v_salaries array */
        l_salary := v_salaries(l_randomnumber);
        /* Update the employee title and salary using the l_title and l_salary */
        update AlphaCoEmp
        set title = l_title
        where name = l_emprec.name;

        update AlphaCoEmp
        set salary = l_salary
        where name = l_emprec.name;
END LOOP;

commit;
END;
/
Show errors;

exec assignJobTitlesAndSalaries();

SELECT * FROM AlphaCoEmp;

Create or Replace Function calcSalaryRaise( p_name in
AlphaCoEmp.name%type, percentRaise IN NUMBER)
RETURN NUMBER
	IS
		l_salary AlphaCoEmp.salary%type;
		l_raise AlphaCoEmp.salary%type;
		l_cnt Integer;
BEGIN
	-- Find the current salary of p_name from AlphaCoEMP table.
	Select salary into l_salary from AlphaCoEmp
	where name = p_name;
	-- Calculate the raise amount
	l_raise := l_salary * (percentRaise/100);
	-- Check if the p_name is in Emp_Work table.
	-- If so, add a $1000 bonus to the
	-- raise amount
	Select count(*) into l_cnt from Emp_Work
	where name = p_name;
	if l_cnt >= 1 THEN
	l_raise := l_raise + 1000;
End IF;
	/* return a value from the function */
	return l_raise;
END;
/
Show Errors;

Select calcSalaryRaise('Stone',2) from Dual;

Select name, title, salary CURRENTSALARY, (salary +
trunc(calcSalaryRaise(name,2))) NEWSALARY
from AlphaCoEmp where upper(name) = upper('Stone');

Create or Replace Function calcSalaryRaise( p_name in
AlphaCoEmp.name%type, percentRaise IN NUMBER)
RETURN NUMBER
        IS
                l_salary AlphaCoEmp.salary%type;
                l_raise AlphaCoEmp.salary%type;
                l_cnt Integer;
BEGIN
        -- Find the current salary of p_name from AlphaCoEMP table.
        Select salary into l_salary from AlphaCoEmp
        where upper(name) = upper(p_name);
        -- Calculate the raise amount
        l_raise := l_salary * (percentRaise/100);
        -- Check if the p_name is in Emp_Work table.
        -- If so, add a $1000 bonus to the
        -- raise amount
        Select count(*) into l_cnt from Emp_Work
        where upper(name) = upper(p_name);
        if l_cnt >= 1 THEN
        l_raise := l_raise + 1000;
End IF;
        /* return a value from the function */
        return l_raise;
END;
/
Show Errors;

Select name, title, salary CURRENTSALARY, (salary +
trunc(calcSalaryRaise(lower(name),2))) NEWSALARY
from AlphaCoEmp where upper(name) = upper('Stone');

Create table EmpStats (title VARCHAR(20) Primary KEY,empcount INTEGER,
lastModified DATE);

Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type)
RETURN NUMBER IS
	l_cnt Integer;
BEGIN
	Select count(*) into l_cnt from AlphaCoEmp
	Group by title
	Having title = p_title;
	return l_cnt;
END;
/

select countByTitle('director') from Dual;

select countByTitle('advisor') from Dual;

CREATE or REPLACE procedure saveCountByTitle
AS
	l_advisor_cnt integer := 0;
	l_director_cnt integer := 0;
	l_assistant_cnt integer := 0;
	l_manager_cnt integer := 0;
	l_supervisor_cnt integer := 0;
	l_bigboss_cnt integer := 0;
BEGIN
	DELETE FROM EmpStats;
	l_advisor_cnt := countByTitle('advisor');
	insert into EmpStats values ('advisor',l_advisor_cnt,SYSDATE);
	l_director_cnt := countByTitle('director');
        insert into EmpStats values ('director',l_director_cnt,SYSDATE);
	l_assistant_cnt := countByTitle('assistant');
        insert into EmpStats values ('assistant',l_assistant_cnt,SYSDATE);
	l_manager_cnt := countByTitle('manager');
        insert into EmpStats values ('manager',l_manager_cnt,SYSDATE);
	l_supervisor_cnt := countByTitle('supervisor');
        insert into EmpStats values ('supervisor',l_supervisor_cnt,SYSDATE);
END;
/
Show errors;


Execute saveCountByTitle();

SELECT * FROM EmpStats;
