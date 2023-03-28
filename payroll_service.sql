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

mysql> CREATE TABLE employeePayroll(ID INT AUTO_INCREMENT NOT NULL,Name VARCHAR(50) NOT NULL, Salary DOUBLE NOT NULL, Start DATE NOT NULL, PRIMARY KEY (id));
Query OK, 0 rows affected (0.81 sec)

mysql> DESCRIBE employeePayroll;
+--------+-------------+------+-----+---------+----------------+
| Field  | Type        | Null | Key | Default | Extra          |
+--------+-------------+------+-----+---------+----------------+
| ID     | int         | NO   | PRI | NULL    | auto_increment |
| Name   | varchar(50) | NO   |     | NULL    |                |
| Salary | double      | NO   |     | NULL    |                |
| Start  | date        | NO   |     | NULL    |                |
+--------+-------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

/****************************************************************************************************************/


/*UC3: Insert employee payroll data in table*/

mysql> INSERT INTO employeePayroll(name,salary,start) VALUES ('Bill',200000,'2023-01-11');
Query OK, 1 row affected (0.21 sec)

mysql> INSERT INTO employeePayroll(name,salary,start) VALUES ('Terisa',300000,'2023-01-14');
Query OK, 1 row affected (0.09 sec)

mysql> INSERT INTO employeePayroll(name,salary,start) VALUES ('Charlie',400000,'2023-01-16');
Query OK, 1 row affected (0.07 sec)


/****************************************************************************************************************/

/*UC4: Retrieve employee payroll data*/


mysql> select * from employeePayroll;
+----+---------+--------+------------+
| ID | Name    | Salary | Start      |
+----+---------+--------+------------+
|  1 | Bill    | 200000 | 2023-01-11 |
|  2 | Terisa  | 300000 | 2023-01-14 |
|  3 | Charlie | 400000 | 2023-01-16 |
+----+---------+--------+------------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC5: Retrieve salary data*/


mysql> SELECT Salary FROM employeePayroll where Name = "Charlie";
+--------+
| Salary |
+--------+
| 400000 |
+--------+
1 row in set (0.00 sec)

mysql> SELECT * FROM employeePayroll WHERE Start BETWEEN CAST('2023-01-12' AS DATE)AND DATE(NOW());
+----+---------+--------+------------+
| ID | Name    | Salary | Start      |
+----+---------+--------+------------+
|  2 | Terisa  | 300000 | 2023-01-14 |
|  3 | Charlie | 400000 | 2023-01-16 |
+----+---------+--------+------------+
2 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC6: Add new column Gender and setting the respective genders*/


mysql> ALTER TABLE employeePayroll ADD COLUMN Gender char(1) AFTER Name;
Query OK, 0 rows affected (0.12 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SELECT * from employeePayroll;
+----+---------+--------+--------+------------+
| ID | Name    | Gender | Salary | Start      |
+----+---------+--------+--------+------------+
|  1 | Bill    | NULL   | 200000 | 2023-01-11 |
|  2 | Terisa  | NULL   | 300000 | 2023-01-14 |
|  3 | Charlie | NULL   | 400000 | 2023-01-16 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)

mysql> UPDATE employeePayroll SET Gender = 'M' WHERE name = 'Bill';
Query OK, 1 row affected (0.12 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employeePayroll SET Gender = 'M' WHERE name = 'Charlie';
Query OK, 1 row affected (0.05 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employeePayroll SET Gender = 'F' WHERE name = 'Terisa';
Query OK, 1 row affected (0.11 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from employeePayroll;
+----+---------+--------+--------+------------+
| ID | Name    | Gender | Salary | Start      |
+----+---------+--------+--------+------------+
|  1 | Bill    | M      | 200000 | 2023-01-11 |
|  2 | Terisa  | F      | 300000 | 2023-01-14 |
|  3 | Charlie | M      | 400000 | 2023-01-16 |
+----+---------+--------+--------+------------+
3 rows in set (0.00 sec)


/****************************************************************************************************************/

/*UC7: Find sum, avg, min, max and number of male and female employees*/


mysql> SELECT SUM(Salary) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| SUM(Salary) |
+-------------+
|      600000 |
+-------------+
1 row in set (0.03 sec)

mysql> SELECT SUM(Salary) FROM employeePayroll WHERE Gender = 'F' GROUP BY Gender;
+-------------+
| SUM(Salary) |
+-------------+
|      300000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Salary) FROM employeePayroll GROUP BY Gender;
+-------------+
| AVG(Salary) |
+-------------+
|      300000 |
|      300000 |
+-------------+
2 rows in set (0.02 sec)

mysql> SELECT AVG(Salary) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| AVG(Salary) |
+-------------+
|      300000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(Salary) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| MIN(Salary) |
+-------------+
|      200000 |
+-------------+
1 row in set (0.06 sec)

mysql> SELECT MAX(Salary) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+-------------+
| MAX(Salary) |
+-------------+
|      400000 |
+-------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(ID) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+-----------+
| COUNT(ID) |
+-----------+
|         2 |
+-----------+
1 row in set (0.00 sec)

/****************************************************************************************************************/

/*UC8: Add additional columns in employee_payroll table*/

mysql> ALTER TABLE employeePayroll ADD phone_number varchar(10);
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD Department varchar(100) NOT NULL;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD Address varchar(100) DEFAULT 'INDIA' NOT NULL;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employeePayroll;
+----+---------+--------+--------+------------+--------------+------------+---------+
| ID | Name    | Gender | Salary | Start      | phone_number | Department | Address |
+----+---------+--------+--------+------------+--------------+------------+---------+
|  1 | Bill    | M      | 200000 | 2023-01-11 | NULL         |            | INDIA   |
|  2 | Terisa  | F      | 300000 | 2023-01-14 | NULL         |            | INDIA   |
|  3 | Charlie | M      | 400000 | 2023-01-16 | NULL         |            | INDIA   |
+----+---------+--------+--------+------------+--------------+------------+---------+
3 rows in set (0.00 sec)

mysql> UPDATE employeePayroll SET phone_number='152909182' where Name='Charlie';
Query OK, 1 row affected (0.07 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employeePayroll SET phone_number='4589264009' where Name='Bill';
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> UPDATE employeePayroll SET phone_number='3467288720' where Name='Terisa';
Query OK, 1 row affected (0.08 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from employeePayroll;
+----+---------+--------+--------+------------+--------------+------------+---------+
| ID | Name    | Gender | Salary | Start      | phone_number | Department | Address |
+----+---------+--------+--------+------------+--------------+------------+---------+
|  1 | Bill    | M      | 200000 | 2023-01-11 | 4589264009   |            | INDIA   |
|  2 | Terisa  | F      | 300000 | 2023-01-14 | 3467288720   |            | INDIA   |
|  3 | Charlie | M      | 400000 | 2023-01-16 | 152909182    |            | INDIA   |
+----+---------+--------+--------+------------+--------------+------------+---------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC9: Adding more columns*/

mysql> ALTER TABLE employeePayroll RENAME COLUMN Salary TO Basic_Pay;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD COLUMN Deductions DOUBLE NOT NULL AFTER Basic_Pay;
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD COLUMN Taxable_Pay DOUBLE NOT NULL AFTER Deductions;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD COLUMN Income_Tax DOUBLE NOT NULL AFTER Taxable_Pay;
Query OK, 0 rows affected (0.07 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employeePayroll ADD COLUMN Net_Pay DOUBLE NOT NULL AFTER Income_Tax;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> select * from employeePayroll;
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+------------+---------+
| ID | Name    | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | phone_number | Department | Address |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+------------+---------+
|  1 | Bill    | M      |    200000 |          0 |           0 |          0 |       0 | 2023-01-11 | 4589264009   |            | INDIA   |
|  2 | Terisa  | F      |    300000 |          0 |           0 |          0 |       0 | 2023-01-14 | 3467288720   |            | INDIA   |
|  3 | Charlie | M      |    400000 |          0 |           0 |          0 |       0 | 2023-01-16 | 152909182    |            | INDIA   |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+------------+---------+
3 rows in set (0.00 sec)

/****************************************************************************************************************/

/*UC10: Making an employee as part of sales and marketing department*/

mysql> CREATE TABLE department (dept_ID INT PRIMARY KEY, Department VARCHAR(50));
Query OK, 0 rows affected (0.12 sec)

mysql> INSERT INTO department(dept_ID,Department) VALUES (1,'Sales'),(2,'Marketing');
Query OK, 2 rows affected (0.09 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM department;
+---------+------------+
| dept_ID | Department |
+---------+------------+
|       1 | Sales      |
|       2 | Marketing  |
+---------+------------+
2 rows in set (0.00 sec)


/****************************************************************************************************************/

/*UC11: Implement ER diagramm to payroll service diagram and create a new table Employee Department*/

mysql> CREATE TABLE employee_department(emp_ID INT NOT NULL, dept_id INT NOT NULL, FOREIGN KEY(emp_ID) REFERENCES employeePayroll(ID), FOREIGN KEY(dept_id) REFERENCES department(dept_ID));
Query OK, 0 rows affected (0.65 sec)

mysql> INSERT INTO employee_department(emp_ID,dept_id) values (2,1),(2,2);
Query OK, 2 rows affected (0.12 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM employee_department;
+--------+---------+
| emp_ID | dept_id |
+--------+---------+
|      2 |       1 |
|      2 |       2 |
+--------+---------+
2 rows in set (0.00 sec)

mysql> DESCRIBE employee_department;
+---------+------+------+-----+---------+-------+
| Field   | Type | Null | Key | Default | Extra |
+---------+------+------+-----+---------+-------+
| emp_ID  | int  | NO   | MUL | NULL    |       |
| dept_id | int  | NO   | MUL | NULL    |       |
+---------+------+------+-----+---------+-------+
2 rows in set (0.00 sec)


/****************************************************************************************************************/

/*UC12: Do the previous UC queries for newly linked tables*/

mysql> SELECT * FROM employeePayroll;
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
| ID | Name    | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | phone_number | Address |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
|  1 | Bill    | M      |    200000 |          0 |           0 |          0 |       0 | 2023-01-11 | 4589264009   | INDIA   |
|  2 | Terisa  | F      |    300000 |          0 |           0 |          0 |       0 | 2023-01-14 | 3467288720   | INDIA   |
|  3 | Charlie | M      |    400000 |          0 |           0 |          0 |       0 | 2023-01-16 | 152909182    | INDIA   |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM employeePayroll where Name = "Charlie";
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
| ID | Name    | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | phone_number | Address |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
|  3 | Charlie | M      |    400000 |          0 |           0 |          0 |       0 | 2023-01-16 | 152909182    | INDIA   |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
1 row in set (0.00 sec)

mysql> SELECT * FROM employeePayroll WHERE Start BETWEEN CAST('2023-01-12' AS DATE)AND DATE(NOW());
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
| ID | Name    | Gender | Basic_Pay | Deductions | Taxable_Pay | Income_Tax | Net_Pay | Start      | phone_number | Address |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
|  2 | Terisa  | F      |    300000 |          0 |           0 |          0 |       0 | 2023-01-14 | 3467288720   | INDIA   |
|  3 | Charlie | M      |    400000 |          0 |           0 |          0 |       0 | 2023-01-16 | 152909182    | INDIA   |
+----+---------+--------+-----------+------------+-------------+------------+---------+------------+--------------+---------+
2 rows in set (0.03 sec)

mysql> SELECT SUM(Basic_Pay) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+----------------+
| SUM(Basic_Pay) |
+----------------+
|         600000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Basic_Pay) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+----------------+
| AVG(Basic_Pay) |
+----------------+
|         300000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(Basic_Pay) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+----------------+
| MIN(Basic_Pay) |
+----------------+
|         200000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(Basic_Pay) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+----------------+
| MAX(Basic_Pay) |
+----------------+
|         400000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(Basic_Pay) FROM employeePayroll WHERE Gender = 'M' GROUP BY Gender;
+------------------+
| COUNT(Basic_Pay) |
+------------------+
|                2 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(Basic_Pay) FROM employeePayroll WHERE Gender = 'F' GROUP BY Gender;
+------------------+
| COUNT(Basic_Pay) |
+------------------+
|                1 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT SUM(Basic_Pay) FROM employeePayroll a, employee_department b WHERE a.ID = b.emp_Id;
+----------------+
| SUM(Basic_Pay) |
+----------------+
|         600000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(Basic_Pay) FROM employeePayroll a, employee_department b WHERE a.ID = b.emp_Id;
+----------------+
| AVG(Basic_Pay) |
+----------------+
|         300000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MIN(Basic_Pay) FROM employeePayroll a, employee_department b WHERE a.ID = b.emp_Id;
+----------------+
| MIN(Basic_Pay) |
+----------------+
|         300000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT MAX(Basic_Pay) FROM employeePayroll a, employee_department b WHERE a.ID = b.emp_Id;
+----------------+
| MAX(Basic_Pay) |
+----------------+
|         300000 |
+----------------+
1 row in set (0.00 sec)

mysql> SELECT COUNT(Basic_Pay) FROM employeePayroll a, employee_department b WHERE a.ID = b.emp_Id;
+------------------+
| COUNT(Basic_Pay) |
+------------------+
|                2 |
+------------------+
1 row in set (0.00 sec)

mysql>
