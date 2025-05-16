Default schema set to `mydb`.
 MySQL  localhost:33060+ ssl  mydb  SQL > CREATE DATABASE clinic;
Query OK, 1 row affected (0.0090 sec)
 MySQL  localhost:33060+ ssl  mydb  SQL > USE HospitalDB;clinicclinic^C
 MySQL  localhost:33060+ ssl  mydb  SQL > USE clinic;
Default schema set to `clinic`.
Fetching global names, object names from `clinic` for auto-completion... Press ^C to stop.
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE TABLE Hospital (number INT PRIMARY KEY, Name VARCHAR(100), location VARCHAR(100));
Query OK, 0 rows affected (0.0397 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > INSERT INTO Hospital (number, Name, location) VALUES (1, 'City Hospital', 'Downtown'), (2, 'Rural Clinic', 'Countryside'), (3, 'General Medical', 'Eastside');
Query OK, 3 rows affected (0.0086 sec)

Records: 3  Duplicates: 0  Warnings: 0
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE TABLE Department (deptnumber INT PRIMARY KEY, deptname VARCHAR(100), deplocation VARCHAR(100));
Query OK, 0 rows affected (0.0362 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > INSERT INTO Department (deptnumber, deptname, deplocation) VALUES (101, 'Cardiology', 'Building A'), (102, 'Neurology', 'Building B'), (103, 'Pediatrics', 'Building C'), (104, 'Orthopedics', 'Building A'), (105, 'Oncology', 'Building B'), (106, 'Emergency', 'Building C'), (107, 'Radiology', 'Building A'), (108, 'Surgery', 'Building B'), (109, 'Dermatology', 'Building C'), (110, 'ENT', 'Building A');
Query OK, 10 rows affected (0.0097 sec)

Records: 10  Duplicates: 0  Warnings: 0
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE TABLE Doctor (SSN INT PRIMARY KEY, Name VARCHAR(100), Age INT, specialization VARCHAR(100), deptnumber INT, FOREIGN KEY (deptnumber) REFERENCES Department(deptnumber));
Query OK, 0 rows affected (0.0499 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > INSERT INTO Doctor (SSN, Name, Age, specialization, deptnumber) VALUES (1001, 'Dr. John Smith', 45, 'Cardiologist', 101), (1002, 'Dr. Maria Lopez', 38, 'Neurologist', 102), (1003, 'Dr. Ahmed Khan', 50, 'Pediatrician', 103), (1004, 'Dr. Laura Brown', 42, 'Orthopedist', 104), (1005, 'Dr. Chen Wei', 39, 'Oncologist', 105), (1006, 'Dr. Elena Garcia', 47, 'Emergency', 106), (1007, 'Dr. Raj Patel', 44, 'Radiologist', 107), (1008, 'Dr. Sophie Martin', 41, 'Surgeon', 108), (1009, 'Dr. Omar Hassan', 36, 'Dermatologist', 109), (1010, 'Dr. Priya Sharma', 43, 'ENT Specialist', 110);
Query OK, 10 rows affected (0.0093 sec)

Records: 10  Duplicates: 0  Warnings: 0
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE TABLE Patient (SSN INT PRIMARY KEY, Name VARCHAR(100), Age INT, diagnosis VARCHAR(100));
Query OK, 0 rows affected (0.0389 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > INSERT INTO Patient (SSN, Name, Age, diagnosis) VALUES (2001, 'Ali Ahmed', 30, 'Hypertension'), (2002, 'Fatima Khalid', 25, 'Migraine'), (2003, 'Mohammed Saeed', 15, 'Asthma'), (2004, 'Sara Nasser', 60, 'Arthritis'), (2005, 'Hassan Ibrahim', 45, 'Cancer'), (2006, 'Layla Osman', 28, 'Fracture'), (2007, 'Omar Youssef', 35, 'Stroke'), (2008, 'Nadia Salem', 12, 'Fever'), (2009, 'Khalid Reza', 50, 'Heart Disease'), (2010, 'Amina Jaber', 33, 'Skin Rash');
Query OK, 10 rows affected (0.0097 sec)

Records: 10  Duplicates: 0  Warnings: 0
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE USER 'hospital_admin'@'localhost' IDENTIFIED BY 'adminpass';
ERROR: 1396: Operation CREATE USER failed for 'hospital_admin'@'localhost'
 MySQL  localhost:33060+ ssl  clinic  SQL > GRANT ALL PRIVILEGES ON HospitalDB.* TO 'hospital_admin'@'localhost';
Query OK, 0 rows affected (0.0079 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'doctorpass';
ERROR: 1396: Operation CREATE USER failed for 'doctor_user'@'localhost'
 MySQL  localhost:33060+ ssl  clinic  SQL > GRANT SELECT, INSERT ON HospitalDB.* TO 'doctor_user'@'localhost';
Query OK, 0 rows affected (0.0078 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT Name, Age FROM Patient WHERE diagnosis LIKE '%Heart%';
+-------------+-----+
| Name        | Age |
+-------------+-----+
| Khalid Reza |  50 |
+-------------+-----+
1 row in set (0.0009 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT deptnumber, deptname, COUNT(*) as doctor_count FROM Doctor d JOIN Department dep ON d.deptnumber = dep.deptnumber GROUP BY deptnumber, deptname;
ERROR: 1052: Column 'deptnumber' in field list is ambiguous
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT deptnumber, deptname, COUNT(*) as doctor_count FROM Doctor d JOIN Department dep ON d.deptnumber = dep.deptnumber GROUP BY deptnumber, deptname;
ERROR: 1052: Column 'deptnumber' in field list is ambiguous
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT deptnumber, deptname, COUNT(*) as doctor_count FROM Doctor d JOIN Department dep ON d.deptnumber = dep.deptnumber GROUP BY deptnumber, deptname;
ERROR: 1052: Column 'deptnumber' in field list is ambiguous
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT dep.deptnumber, dep.deptname, COUNT(*) as doctor_count FROM Doctor d JOIN Department dep ON d.deptnumber = dep.deptnumber GROUP BY dep.deptnumber, dep.deptname;
+------------+-------------+--------------+
| deptnumber | deptname    | doctor_count |
+------------+-------------+--------------+
|        101 | Cardiology  |            1 |
|        102 | Neurology   |            1 |
|        103 | Pediatrics  |            1 |
|        104 | Orthopedics |            1 |
|        105 | Oncology    |            1 |
|        106 | Emergency   |            1 |
|        107 | Radiology   |            1 |
|        108 | Surgery     |            1 |
|        109 | Dermatology |            1 |
|        110 | ENT         |            1 |
+------------+-------------+--------------+
10 rows in set (0.0017 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT Name, Age, diagnosis FROM Patient ORDER BY Age ASC;
+----------------+-----+---------------+
| Name           | Age | diagnosis     |
+----------------+-----+---------------+
| Nadia Salem    |  12 | Fever         |
| Mohammed Saeed |  15 | Asthma        |
| Fatima Khalid  |  25 | Migraine      |
| Layla Osman    |  28 | Fracture      |
| Ali Ahmed      |  30 | Hypertension  |
| Amina Jaber    |  33 | Skin Rash     |
| Omar Youssef   |  35 | Stroke        |
| Hassan Ibrahim |  45 | Cancer        |
| Khalid Reza    |  50 | Heart Disease |
| Sara Nasser    |  60 | Arthritis     |
+----------------+-----+---------------+
10 rows in set (0.0012 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT d.Name, d.specialization, dep.deptname FROM Doctor d JOIN Department dep ON d.deptnumber = dep.deptnumber;
+-------------------+----------------+-------------+
| Name              | specialization | deptname    |
+-------------------+----------------+-------------+
| Dr. John Smith    | Cardiologist   | Cardiology  |
| Dr. Maria Lopez   | Neurologist    | Neurology   |
| Dr. Ahmed Khan    | Pediatrician   | Pediatrics  |
| Dr. Laura Brown   | Orthopedist    | Orthopedics |
| Dr. Chen Wei      | Oncologist     | Oncology    |
| Dr. Elena Garcia  | Emergency      | Emergency   |
| Dr. Raj Patel     | Radiologist    | Radiology   |
| Dr. Sophie Martin | Surgeon        | Surgery     |
| Dr. Omar Hassan   | Dermatologist  | Dermatology |
| Dr. Priya Sharma  | ENT Specialist | ENT         |
+-------------------+----------------+-------------+
10 rows in set (0.0013 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL > SELECT AVG(Age) as avg_patient_age FROM Patient WHERE Age > 30;
+-----------------+
| avg_patient_age |
+-----------------+
|         44.6000 |
+-----------------+
1 row in set (0.0043 sec)
 MySQL  localhost:33060+ ssl  clinic  SQL >