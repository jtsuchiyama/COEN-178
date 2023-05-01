SELECT FIRST||LAST fullname FROM Staff WHERE salary = (SELECT max(salary) FROM Staff);
SELECT last, salary FROM Staff WHERE salary = (SELECT salary FROM STAFF WHERE last='Zichal');
SELECT last, salary FROM Staff WHERE salary = (SELECT salary FROM STAFF WHERE UPPER(last) ='ZICHAL');
SELECT last, salary FROM Staff WHERE salary = (SELECT salary FROM STAFF WHERE UPPER(last) ='YOUNG');
SELECT last, salary FROM Staff WHERE salary IN (SELECT salary FROM STAFF WHERE UPPER(last) ='YOUNG');
SELECT salary, count(*) SALARIES_100K_ABOVE FROM Staff WHERE salary > 100000 GROUP BY (salary);
SELECT salary, count(*) SALARIES_100K_ABOVE FROM Staff WHERE salary > 100000 GROUP BY (salary) HAVING count(*) >= 10;
SELECT * FROM L_EMP;
WITH EmpCount AS (SELECT deptid, count(*) Count FROM L_EMP GROUP BY (deptid)) SELECT deptid FROM EmpCount WHERE Count >= (SELECT max(Count) FROM EmpCount);
