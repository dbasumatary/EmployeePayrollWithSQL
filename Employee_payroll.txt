/*Employee payroll problem*/

/*UC1: Creating a payroll service database*/

mysql> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| jdbcappdemo        |
| mysql              |
| performance_schema |
| practice           |
| rfp                |
| rfp255             |
| sakila             |
| sys                |
| world              |
+--------------------+
10 rows in set (0.00 sec)


mysql> CREATE DATABASE payroll_service;
Query OK, 1 row affected (0.07 sec)

mysql> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| jdbcappdemo        |
| mysql              |
| payroll_service    |
| performance_schema |
| practice           |
| rfp                |
| rfp255             |
| sakila             |
| sys                |
| world              |
+--------------------+
11 rows in set (0.00 sec)

mysql> USE payroll_service;
Database changed


/****************************************************************************************************************/


/*UC2: Creating employee payroll table*/


mysql> CREATE TABLE employee_payroll(ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(55), Salary DOUBLE, Start DATE);
Query OK, 0 rows affected (0.28 sec)

mysql> DESCRIBE employee_payroll;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| ID     | int         | NO   | PRI | NULL    | auto_increment |
| Name   | varchar(55) | YES  |     | NULL    |                |
| Salary | double      | YES  |     | NULL    |                |
| Start  | date        | YES  |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

/****************************************************************************************************************/


/*UC3: Insert employee payroll data in table*/

mysql> INSERT INTO employee_payroll(Name, Salary, Start) values
    -> ('Bill', 100000.00, '2023-03-11'),
    -> ('Terisa', 200000.00, '2023-03-14'),
    -> ('Charlie', 300000.00, '2023-03-17');
Query OK, 3 rows affected (0.20 sec)
Records: 3  Duplicates: 0  Warnings: 0

/****************************************************************************************************************/

/*UC4: Retrieve employee payroll data*/


mysql> SELECT * FROM employee_payroll;
+----+---------+--------+------------+
| ID | Name    | Salary | Start      |
+----+---------+--------+------------+
|  1 | Bill    | 100000 | 2023-03-11 |
|  2 | Terisa  | 200000 | 2023-03-14 |
|  3 | Charlie | 300000 | 2023-03-17 |
+----+---------+--------+------------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC5: Retrieve salary data*/


mysql> SELECT Salary FROM employee_payroll where Name = "Charlie";
+--------+
| Salary |
+--------+
| 300000 |
+--------+
1 row in set (0.00 sec)

mysql> SELECT * FROM employee_payroll WHERE Start_Date BETWEEN CAST('2023-03-12' AS DATE)AND DATE(NOW());
ERROR 1054 (42S22): Unknown column 'Start_Date' in 'where clause'
mysql> SELECT * FROM employee_payroll WHERE Start BETWEEN CAST('2023-03-12' AS DATE)AND DATE(NOW());
+----+---------+--------+------------+
| ID | Name    | Salary | Start      |
+----+---------+--------+------------+
|  2 | Terisa  | 200000 | 2023-03-14 |
|  3 | Charlie | 300000 | 2023-03-17 |
+----+---------+--------+------------+
2 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC6: Add new column Gender and setting the respective genders*/


mysql> ALTER TABLE employee_payroll ADD COLUMN Gender char(1) AFTER Name;
Query OK, 0 rows affected (0.12 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------+--------+------------+
| ID | Name    | Gender | Salary | Start      |
+----+---------+--------+--------+------------+
|  1 | Bill    | NULL   | 100000 | 2023-03-11 |
|  2 | Terisa  | NULL   | 200000 | 2023-03-14 |
|  3 | Charlie | NULL   | 300000 | 2023-03-17 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> UPDATE employee_payroll set Gender = 'M' WHERE Name = 'Bill' or Name = 'Charlie';
Query OK, 2 rows affected (0.06 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> UPDATE employee_payroll set Gender = 'F' WHERE Name = 'Terisa';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+--------+--------+------------+
| ID | Name    | Gender | Salary | Start      |
+----+---------+--------+--------+------------+
|  1 | Bill    | M      | 100000 | 2023-03-11 |
|  2 | Terisa  | F      | 200000 | 2023-03-14 |
|  3 | Charlie | M      | 300000 | 2023-03-17 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC7: Find sum, avg, min, max and number of male and female employees*/


mysql> SELECT SUM(Salary) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| SUM(Salary) |
+-------------+
|      400000 |
+-------------+
1 row in set (0.03 sec)

mysql> SELECT SUM(Salary) FROM employee_payroll WHERE Gender = 'F' GROUP BY Gender;
+-------------+
| SUM(Salary) |
+-------------+
|      200000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Salary) FROM employee_payroll GROUP BY Gender;
+-------------+
| AVG(Salary) |
+-------------+
|      200000 |
|      200000 |
+-------------+
2 rows in set (0.02 sec)

mysql> SELECT AVG(Salary) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| AVG(Salary) |
+-------------+
|      200000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(Salary) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| MIN(Salary) |
+-------------+
|      100000 |
+-------------+
1 row in set (0.06 sec)

mysql> SELECT MAX(Salary) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| MAX(Salary) |
+-------------+
|      300000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(ID) FROM employee_payroll WHERE Gender = 'M' GROUP BY Gender;
+-----------+
| COUNT(ID) |
+-----------+
|         2 |
+-----------+
1 row in set (0.00 sec)

/****************************************************************************************************************/

/*UC8: Add additional columns in employee_payroll table*/

mysql>  ALTER TABLE employee_payroll ADD COLUMN Phone VARCHAR(55) AFTER Name;
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  ALTER TABLE employee_payroll ADD COLUMN Address VARCHAR(150) DEFAULT 'TBD' AFTER Phone;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  ALTER TABLE employee_payroll ADD COLUMN Department VARCHAR(150) NOT NULL AFTER Address;
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+-------+---------+------------+--------+--------+------------+
| ID | Name    | Phone | Address | Department | Gender | Salary | Start      |
+----+---------+-------+---------+------------+--------+--------+------------+
|  1 | Bill    | NULL  | TBD     |            | M      | 100000 | 2023-03-11 |
|  2 | Terisa  | NULL  | TBD     |            | F      | 200000 | 2023-03-14 |
|  3 | Charlie | NULL  | TBD     |            | M      | 300000 | 2023-03-17 |
+----+---------+-------+---------+------------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> UPDATE employee_payroll SET Phone='152909182' where Name='Charlie';
Query OK, 1 row affected (0.06 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employee_payroll SET Phone='736017461' where Name='Bill';
Query OK, 1 row affected (0.09 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employee_payroll SET Phone='890275650' where Name='Terisa';
Query OK, 1 row affected (0.04 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+---------+------------+--------+--------+------------+
| ID | Name    | Phone     | Address | Department | Gender | Salary | Start      |
+----+---------+-----------+---------+------------+--------+--------+------------+
|  1 | Bill    | 736017461 | TBD     |            | M      | 100000 | 2023-03-11 |
|  2 | Terisa  | 890275650 | TBD     |            | F      | 200000 | 2023-03-14 |
|  3 | Charlie | 152909182 | TBD     |            | M      | 300000 | 2023-03-17 |
+----+---------+-----------+---------+------------+--------+--------+------------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC9: Adding more columns*/


mysql> ALTER TABLE employee_payroll RENAME COLUMN Salary TO Basic_Pay;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD COLUMN Deductions DOUBLE NOT NULL AFTER Basic_Pay;
Query OK, 0 rows affected (0.14 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD COLUMN Taxable_Pay DOUBLE NOT NULL AFTER Deductions;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD COLUMN Income_Tax DOUBLE NOT NULL AFTER Taxable_Pay;
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD COLUMN Net_Pay DOUBLE NOT NULL AFTER Income_Tax;
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Phone     | Address | Department | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    | 736017461 | TBD     |            | M      |    100000 |          0 |           0 |          0 |       0 | 2023-03-11 |
|  2 | Terisa  | 890275650 | TBD     |            | F      |    200000 |          0 |           0 |          0 |       0 | 2023-03-14 |
|  3 | Charlie | 152909182 | TBD     |            | M      |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC10: Updating the row for Terisa*/

mysql> UPDATE employee_payroll SET Department='Sales' WHERE Name='Terisa';
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Phone     | Address | Department | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    | 736017461 | TBD     |            | M      |    100000 |          0 |           0 |          0 |       0 | 2023-03-11 |
|  2 | Terisa  | 890275650 | TBD     | Sales      | F      |    200000 |          0 |           0 |          0 |       0 | 2023-03-14 |
|  3 | Charlie | 152909182 | TBD     |            | M      |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
3 rows in set (0.00 sec)

mysql> INSERT INTO employee_payroll(Name, Phone, Department, Gender, Basic_Pay, Deductions, Taxable_Pay, Income_Tax, Net_Pay, Start)
    -> VALUES('Terisa',890275650,'Marketing','F',200000.00, 100000.00, 200000.00, 50000.00, 150000.00, '2023-03-14');
Query OK, 1 row affected (0.12 sec)

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Phone     | Address | Department | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    | 736017461 | TBD     |            | M      |    100000 |          0 |           0 |          0 |       0 | 2023-03-11 |
|  2 | Terisa  | 890275650 | TBD     | Sales      | F      |    200000 |          0 |           0 |          0 |       0 | 2023-03-14 |
|  3 | Charlie | 152909182 | TBD     |            | M      |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
|  4 | Terisa  | 890275650 | TBD     | Marketing  | F      |    200000 |     100000 |      200000 |      50000 |  150000 | 2023-03-14 |
+----+---------+-----------+---------+------------+--------+-----------+------------+-------------+------------+---------+------------+
4 rows in set (0.00 sec)


mysql> ALTER TABLE employee_payroll DROP Phone;
Query OK, 0 rows affected (3.21 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll DROP Address;
Query OK, 0 rows affected (0.36 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll DROP Department;
Query OK, 0 rows affected (0.26 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll DROP Gender;
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    |    100000 |          0 |           0 |          0 |       0 | 2023-03-11 |
|  2 | Terisa  |    200000 |          0 |           0 |          0 |       0 | 2023-03-14 |
|  3 | Charlie |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
|  4 | Terisa  |    200000 |     100000 |      200000 |      50000 |  150000 | 2023-03-14 |
+----+---------+-----------+------------+-------------+------------+---------+------------+
4 rows in set (0.10 sec)

mysql> DELETE FROM employee_payroll WHERE ID=4;
Query OK, 1 row affected (0.18 sec)

mysql> SELECT * FROM employee_payroll;
+----+---------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    |    100000 |          0 |           0 |          0 |       0 | 2023-03-11 |
|  2 | Terisa  |    200000 |          0 |           0 |          0 |       0 | 2023-03-14 |
|  3 | Charlie |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
+----+---------+-----------+------------+-------------+------------+---------+------------+
3 rows in set (0.06 sec)

mysql>  CREATE TABLE employee_details(EMP_ID INT AUTO_INCREMENT PRIMARY KEY, Name VARCHAR(55) NOT NULL, Gender CHAR NOT NULL, Mobile INT(10) NOT NULL,
    ->  Address VARCHAR(105) NOT NULL, Email VARCHAR(55) NOT NULL, FOREIGN KEY (EMP_ID) REFERENCES employee_payroll (ID));
Query OK, 0 rows affected, 1 warning (1.68 sec)

mysql> SHOW TABLES;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| employee_details          |
| employee_payroll          |
+---------------------------+
2 rows in set (0.28 sec)

mysql> DESCRIBE employee_details;
+---------+--------------+------+-----+---------+----------------+
| Field   | Type         | Null | Key | Default | Extra          |
+---------+--------------+------+-----+---------+----------------+
| EMP_ID  | int          | NO   | PRI | NULL    | auto_increment |
| Name    | varchar(55)  | NO   |     | NULL    |                |
| Gender  | char(1)      | NO   |     | NULL    |                |
| Mobile  | int          | NO   |     | NULL    |                |
| Address | varchar(105) | NO   |     | NULL    |                |
| Email   | varchar(55)  | NO   |     | NULL    |                |
+---------+--------------+------+-----+---------+----------------+
6 rows in set (0.04 sec)

mysql> INSERT INTO employee_details(Name, Gender, Mobile, Address, Email) VALUES('Bill','M',9876543210,'New York', 'killbill@xyz.com');
ERROR 1264 (22003): Out of range value for column 'Mobile' at row 1
mysql> INSERT INTO employee_details(Name, Gender, Mobile, Address, Email) VALUES('Bill','M',987654,'New York', 'killbill@xyz.com');
Query OK, 1 row affected (0.15 sec)

mysql> INSERT INTO employee_details(Name, Gender, Mobile, Address, Email) VALUES('Terisa','F',45673,'Boston', 'terisa@xyz.com');
Query OK, 1 row affected (0.18 sec)

/****************************************************************************************************************/

/*UC11: Implement ER diagramm to payroll service diagram*/


mysql> CREATE TABLE employee_department(Dept_Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, EmpId INT NOT NULL, DeptName VARCHAR(55) NOT NULL,
    -> FOREIGN KEY(EmpId) REFERENCES employee_details(EMP_ID));
Query OK, 0 rows affected (0.39 sec)

mysql> SHOW TABLES;
+---------------------------+
| Tables_in_payroll_service |
+---------------------------+
| employee_department       |
| employee_details          |
| employee_payroll          |
+---------------------------+
3 rows in set (0.00 sec)

mysql> DESCRIBE employee_department;
+----------+-------------+------+-----+---------+----------------+
| Field    | Type        | Null | Key | Default | Extra          |
+----------+-------------+------+-----+---------+----------------+
| Dept_Id  | int         | NO   | PRI | NULL    | auto_increment |
| EmpId    | int         | NO   | MUL | NULL    |                |
| DeptName | varchar(55) | NO   |     | NULL    |                |
+----------+-------------+------+-----+---------+----------------+
3 rows in set (0.00 sec)

mysql> INSERT INTO employee_department(EmpId, DeptName) values(1, 'HR'), (2, 'Sales'), (3, 'Marketing');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`payroll_service`.`employee_department`, CONSTRAINT `employee_department_ibfk_1` FOREIGN KEY (`EmpId`) REFERENCES `employee_details` (`EMP_ID`))
mysql> SELECT * FROM employee_details;
+--------+--------+--------+--------+----------+------------------+
| EMP_ID | Name   | Gender | Mobile | Address  | Email            |
+--------+--------+--------+--------+----------+------------------+
|      1 | Bill   | M      | 987654 | New York | killbill@xyz.com |
|      2 | Terisa | F      |  45673 | Boston   | terisa@xyz.com   |
+--------+--------+--------+--------+----------+------------------+
2 rows in set (0.02 sec)

mysql> INSERT INTO employee_department(EmpId, DeptName) values(1, 'HR'), (2, 'Sales');
Query OK, 2 rows affected (0.08 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_department;
+---------+-------+----------+
| Dept_Id | EmpId | DeptName |
+---------+-------+----------+
|       4 |     1 | HR       |
|       5 |     2 | Sales    |
+---------+-------+----------+
2 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC12: Do the previous queries for newly linked tables*/


mysql> SELECT * FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
| ID | Name   | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | EMP_ID | Name   | Gender | Mobile | Address  | Email            |
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
|  1 | Bill   |    100000 |          0 |           0 |          0 |   80000 | 2023-03-11 |      1 | Bill   | M      | 987654 | New York | killbill@xyz.com |
|  2 | Terisa |    200000 |          0 |           0 |          0 |  150000 | 2023-03-14 |      2 | Terisa | F      |  45673 | Boston   | terisa@xyz.com   |
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
2 rows in set (0.00 sec)

mysql> INSERT INTO employee_payroll(Name,Basic_Pay, Deductions,Taxable_Pay,Income_Tax,Net_Pay,Start) values('Terisa',200000,100000,200000,50000,150000,2023-03-14);
ERROR 1292 (22007): Incorrect date value: '2006' for column 'Start' at row 1
mysql> INSERT INTO employee_payroll(Name,Basic_Pay, Deductions,Taxable_Pay,Income_Tax,Net_Pay,Start) values('Terisa',200000,100000,200000,50000,150000,'2023-03-14');
Query OK, 1 row affected (0.09 sec)

mysql> select * from employee_payroll;
+----+---------+-----------+------------+-------------+------------+---------+------------+
| ID | Name    | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      |
+----+---------+-----------+------------+-------------+------------+---------+------------+
|  1 | Bill    |    100000 |          0 |           0 |          0 |   80000 | 2023-03-11 |
|  2 | Terisa  |    200000 |          0 |           0 |          0 |  150000 | 2023-03-14 |
|  3 | Charlie |    300000 |          0 |           0 |          0 |       0 | 2023-03-17 |
|  5 | Terisa  |    200000 |     100000 |      200000 |      50000 |  150000 | 2023-03-14 |
+----+---------+-----------+------------+-------------+------------+---------+------------+
4 rows in set (0.00 sec)

mysql>  SELECT * FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
| ID | Name   | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | EMP_ID | Name   | Gender | Mobile | Address  | Email            |
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
|  1 | Bill   |    100000 |          0 |           0 |          0 |   80000 | 2023-03-11 |      1 | Bill   | M      | 987654 | New York | killbill@xyz.com |
|  2 | Terisa |    200000 |          0 |           0 |          0 |  150000 | 2023-03-14 |      2 | Terisa | F      |  45673 | Boston   | terisa@xyz.com   |
+----+--------+-----------+------------+-------------+------------+---------+------------+--------+--------+--------+--------+----------+------------------+
2 rows in set (0.00 sec)

mysql> SELECT SUM(Net_Pay) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+--------------+
| SUM(Net_Pay) |
+--------------+
|       230000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Net_Pay) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+--------------+
| AVG(Net_Pay) |
+--------------+
|       115000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(Net_Pay) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+--------------+
| MAX(Net_Pay) |
+--------------+
|       150000 |
+--------------+
1 row in set (0.02 sec)

mysql> SELECT MIN(Net_Pay) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+--------------+
| MIN(Net_Pay) |
+--------------+
|        80000 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(Name) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
ERROR 1052 (23000): Column 'Name' in field list is ambiguous
mysql> SELECT COUNT(Name) FROM employee_payroll a, employee_department b WHERE a.ID = b.EmpId;
+-------------+
| COUNT(Name) |
+-------------+
|           2 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(ID) FROM employee_payroll a, employee_details b WHERE a.ID = b.EMP_ID;
+-----------+
| COUNT(ID) |
+-----------+
|         2 |
+-----------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(Dept_Id) FROM employee_department a, employee_details b WHERE a.EmpId = b.EMP_ID;
+----------------+
| COUNT(Dept_Id) |
+----------------+
|              2 |
+----------------+
1 row in set (0.00 sec)

mysql>
