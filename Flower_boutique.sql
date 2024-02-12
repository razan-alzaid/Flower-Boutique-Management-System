--Flower_boutique_Management_system project
--CREATION
--Employee
DROP TABLE Employee CASCADE CONSTRAINTS;
CREATE TABLE Employee(
SSN varchar2(9) CONSTRAINT emp_SSN PRIMARY KEY,
DOB DATE DEFAULT '26-may-01',
Name varchar2(10)NOT NULL,
eMobile_number number(10)NOT NULL,
e_Email varchar2(25),
Address char(5)NOT NULL,
number_branches number(8),
UNIQUE(e_Email,eMobile_number)
);

--Alter Employee
ALTER TABLE Employee
ADD CONSTRAINT number_branchesFK FOREIGN KEY (number_branches) REFERENCES Branch(number_branches);
--Buyer
DROP TABLE Buyer CASCADE CONSTRAINTS;
CREATE TABLE Buyer(
User_num char(9) PRIMARY KEY,
buyer_address varchar2(15),
Card number(10) NOT NULL,
buyer_MobileNum number(10)NOT NULL,
UNIQUE(Card,buyer_MobileNum)
);
--Branch
DROP TABLE Branch CASCADE CONSTRAINTS;
CREATE TABLE Branch(
number_branches number(8)CONSTRAINT branch_pk PRIMARY KEY,
brunLocation varchar2(15) ,
number_employees number(10) 
);
--Supplier
DROP TABLE Supplier CASCADE CONSTRAINTS;
CREATE TABLE Supplier(
supID char(9) PRIMARY KEY,
status varchar2(12) ,
sMobile_number number(12)NOT NULL,
sAddress varchar2(20)NOT NULL,
s_Email varchar2(25),
CHECK (s_Email LIKE '%.com'),
UNIQUE(s_Email,sMobile_number)
);
--Flower_arrangement 
DROP TABLE Flower_arrangement CASCADE CONSTRAINTS;
CREATE TABLE Flower_arrangement(
ID char(5)PRIMARY KEY,
supID char(9), 
Price number(6) NOT NULL,
F_Size number(4) NOT NULL CHECK(F_Size >= 100),
FOREIGN KEY (supID) REFERENCES Supplier(supID)
);
--FlowerType
DROP TABLE FlowerType CASCADE CONSTRAINTS;
CREATE TABLE FlowerType(
F_Type varchar2(20) PRIMARY KEY ,
ID char(5),
--PRIMARY KEY(F_Type,ID),
FOREIGN KEY(ID) REFERENCES Flower_arrangement(ID)
);
--FlowerColor
DROP TABLE FlowerColor CASCADE CONSTRAINTS;
CREATE TABLE FlowerColor(
F_Color varchar2(10) PRIMARY KEY,
ID char(5),
--PRIMARY KEY(F_Color,ID),
FOREIGN KEY(ID) REFERENCES Flower_arrangement(ID)
);
--Choose
DROP TABLE Choose CASCADE CONSTRAINTS;
CREATE TABLE Choose (
ID char (9),
User_num char(9),
CONSTRAINT fkey_Choose_id FOREIGN KEY(ID) REFERENCES Flower_arrangement(ID),
CONSTRAINT fkey_Choose_user FOREIGN KEY(User_num)REFERENCES Buyer(User_num)
);
--Coordinates
DROP TABLE Coordinates CASCADE CONSTRAINTS;
CREATE TABLE Coordinates(
SSN varchar2(9),
ID char(9),
CONSTRAINT Coord_fk1 FOREIGN KEY(SSN) REFERENCES Employee (SSN),
CONSTRAINT Coord_fk2 FOREIGN KEY(ID)REFERENCES Flower_arrangement (ID)
);
--Serve
DROP TABLE Serve CASCADE CONSTRAINTS;
CREATE TABLE Serve(
SSN varchar2(9),
User_num char(9),
CONSTRAINT Serve_fk1 FOREIGN KEY(SSN) REFERENCES Employee(SSN),
CONSTRAINT Serve_fk2 FOREIGN KEY(User_num) REFERENCES Buyer(User_num)
);
--INSERTION
--Branch values
INSERT INTO Branch VALUES(3,'Makkah',6);
INSERT INTO Branch VALUES(1,'Riyadh',4);
INSERT INTO Branch VALUES(2,'Dammam',8);
INSERT INTO Branch VALUES(4,'Dammam',9);
INSERT INTO Branch VALUES(5,'Riyadh',5);
INSERT INTO Branch VALUES(6,'Tabuk',7);

--Employee values
INSERT INTO Employee VALUES('112233441','05-Nov-01','Razan',0555555511,'Razan1stemp@gmail.com','St1',4);
INSERT INTO Employee VALUES('112233442','22-Sep-01','Noor',0555555522,'Noorf2edemp@gmail.com','St2',7);
INSERT INTO Employee VALUES('112233443',DEFAULT,'Shahad',0555555533,'Shahad3rdemp@gmail.com','St3',3);
INSERT INTO Employee VALUES('112233444','14-Feb-01','Haya',0555555544,'Haya4themp@gmail.com','St2',5);
--Buyer values
INSERT INTO Buyer VALUES('A000','St11',9988776654,0555555515);
INSERT INTO Buyer VALUES('A100','St22',9988776655,0555555556);
INSERT INTO Buyer VALUES('A200','St33',9988776656,0555555557);
INSERT INTO Buyer VALUES('A300','St44',9988776657,0555555558);
INSERT INTO Buyer VALUES('A400','St22',9988776658,0555555559);
INSERT INTO Buyer VALUES('A500','St22',9988776659,0555555510);
--Supplier values
INSERT INTO Supplier VALUES('110011789','Available',966543782334,'Taif','fahad@gmail.com');
INSERT INTO Supplier VALUES('110011567','Available',203889006543,'Egypt','ali@gmail.com');
INSERT INTO Supplier VALUES('110011998','Unavailable',966348762094,'Taif','Mohammed@gmail.com');
--Flower_arrangement values
INSERT INTO Flower_arrangement VALUES('FA627','110011789',3750,250);
INSERT INTO Flower_arrangement VALUES('FA628','110011567',2700,180);
INSERT INTO Flower_arrangement VALUES('FA629','110011998',11340,765);
INSERT INTO Flower_arrangement VALUES('FA630','110011789',6600,440);
INSERT INTO Flower_arrangement VALUES('FA631','110011567',14835,989);
--FlowerType values
INSERT INTO FlowerType VALUES('Jasmine','FA627');
INSERT INTO FlowerType VALUES('Mister Lincoln','FA628');
INSERT INTO FlowerType VALUES('Eden','FA629');
INSERT INTO FlowerType VALUES('Golden Celebration','FA630');
INSERT INTO FlowerType VALUES('Violet','FA631');
--FlowerColor values
INSERT INTO FlowerColor VALUES('White','FA627');
INSERT INTO FlowerColor VALUES('red','FA628');
INSERT INTO FlowerColor VALUES('pink','FA629');
INSERT INTO FlowerColor VALUES('yellow','FA630');
INSERT INTO FlowerColor VALUES('Purple','FA631');
--DDL QUEIRIES
SELECT COUNT(User_num) AS "COUNT" FROM Buyer WHERE buyer_address='St22';
SELECT* FROM Employee WHERE DOB >'30-Jul-01';
SELECT supID ,status FROM Supplier WHERE status='Available';
UPDATE Buyer SET User_num = 'A700' WHERE buyer_address ='St44';
SELECT* FROM Buyer;
SELECT COUNT(brunLocation) FROM Branch WHERE brunLocation='Riyadh'; 
SELECT MIN(Price),MAX(Price),AVG(Price) FROM Flower_arrangement;
--DML QUEIRIES
SELECT MAX(DOB)FROM Employee GROUP BY Address;
SELECT brunLocation,COUNT(number_employees)FROM Branch GROUP BY brunLocation HAVING SUM(number_employees)>5;
SELECT brunLocation,MAX(number_employees)FROM Branch GROUP BY brunLocation ;
SELECT buyer_address,COUNT(Card) FROM Buyer GROUP BY buyer_address;
