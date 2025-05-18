-- Generar el script DDL para la creación de cada una de las tablas representadas en el DER -- 
-- Enviarlo con el nombre “create_tables.sql” -- 


CREATE SCHEMA `create_tables`  ; 

-- CREAR LA TABLA CUSTOMER -- 

USE `create_tables`  ; 

CREATE TABLE `CUSTOMER`
(
Customer_ID				VARCHAR (20) NOT NULL ,			
Customer_Name	     	TEXT (50) NOT NULL ,	
Customer_Surname     	TEXT (50) NOT NULL , 	
Date_Birth				DATE NOT NULL ,
Genre			  		TEXT (20) ,
Email			  		VARCHAR (100) NOT NULL ,
Adress			  		VARCHAR (100) NOT NULL ,
Phone_Number			VARCHAR (50) NOT NULL ,

PRIMARY KEY (CUSTOMER_ID)
) ; 


-- CREAR LA TABLA CATEGORIA -- 

CREATE TABLE `CATEGORIA`

(
Category_ID 			VARCHAR (50) NOT NULL , 
Category_Description	VARCHAR (50) NOT NULL ,
Category_Path			VARCHAR (100) NOT NULL ,

PRIMARY KEY (Category_ID)
) ; 


-- CREAR TABLA ITEM --  

CREATE TABLE `ITEM`

(
Item_ID					VARCHAR (20) NOT NULL, 		
Item_Description		VARCHAR (100) NOT NULL ,
Publication_Date		DATE NOT NULL ,
Item_Status				VARCHAR (50) NOT NULL ,
Quantity_available		INT, 
Price					DECIMAL (8,2) NOT NULL , 
Category_ID				VARCHAR (50) NOT NULL ,
 
PRIMARY KEY (Item_ID), 
FOREIGN KEY (Category_ID) REFERENCES CATEGORIA (Category_ID)
) ; 

-- CREAR TABLA ORDER --  

CREATE TABLE `ORDER`

(
Order_ID				VARCHAR (20) NOT NULL, 		
Invoice_ID				VARCHAR (20) NOT NULL ,
Customer_ID				VARCHAR (20) NOT NULL ,
Item_ID					VARCHAR (20) NOT NULL ,
Date_Order				DATE NOT NULL,
Quantity				INT NOT NULL , 
Total_Price				DECIMAL (8,2) NOT NULL , 
Ship_Date			 	DATE NOT NULL ,
 
PRIMARY KEY (Order_ID), 
FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER (Customer_ID),
FOREIGN KEY (Item_ID) REFERENCES ITEM (Item_ID)
) ; 
