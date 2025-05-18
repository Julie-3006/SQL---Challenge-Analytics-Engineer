
-- Insertar datos en las tablas para probar la consulta --

-- Tabla Categoria --
INSERT INTO CATEGORIA (Category_ID, Category_Description, Category_Path) VALUES ('2525', 'Celulares', '/Tecnología > Celulares y Teléfonos > Celulares y Smartphones') ; 
INSERT INTO CATEGORIA (Category_ID, Category_Description, Category_Path) VALUES ('2526', 'Celulares', '/Tecnología > Celulares y Teléfonos > Celulares y Smartphones') ;
INSERT INTO CATEGORIA (Category_ID, Category_Description, Category_Path) VALUES ('2527', 'Celulares', '/Tecnología > Celulares y Teléfonos > Celulares y Smartphones') ;
INSERT INTO CATEGORIA (Category_ID, Category_Description, Category_Path) VALUES ('2528', 'Celulares', '/Tecnología > Celulares y Teléfonos > Celulares y Smartphones') ;
INSERT INTO CATEGORIA (Category_ID, Category_Description, Category_Path) VALUES ('2529', 'Celulares', '/Tecnología > Celulares y Teléfonos > Celulares y Smartphones') ;

-- Tabla Customer --
INSERT INTO CUSTOMER (Customer_ID, Customer_Name, Customer_Surname, Date_Birth, Genre, Email, Adress, Phone_Number) VALUES ('37618809', 'Julieta', 'Gesurmino', '1993-06-30', 'Female', 'juligema6@gmail.com', 'Ansenusa', '3516631923');
INSERT INTO CUSTOMER (Customer_ID, Customer_Name, Customer_Surname, Date_Birth, Genre, Email, Adress, Phone_Number) VALUES ('8390439', 'Eduardo', 'Gesurmino', '1950-07-23', 'Male', 'gemacba@gmail.com', 'Ansenusa', '3516631923');
INSERT INTO CUSTOMER (Customer_ID, Customer_Name, Customer_Surname, Date_Birth, Genre, Email, Adress, Phone_Number) VALUES ('10904034', 'Pepa', 'Pig', '1993-05-16', 'Female', 'gemacba@gmail.com', 'Ansenusa', '3516631923');
INSERT INTO CUSTOMER (Customer_ID, Customer_Name, Customer_Surname, Date_Birth, Genre, Email, Adress, Phone_Number) VALUES ('28390439', 'Pepe', 'Perez', '1993-05-18', 'Male', 'gemacba@gmail.com', 'Ansenusa', '3516631923');
INSERT INTO CUSTOMER (Customer_ID, Customer_Name, Customer_Surname, Date_Birth, Genre, Email, Adress, Phone_Number) VALUES ('47554558', 'Cristina', 'Massaccesi', '1993-05-21', 'Female', 'gemacba@gmail.com', 'Ansenusa', '3516631923');
 
 -- Tabla Item -- 
INSERT INTO ITEM (Item_ID, Item_Description, Publication_Date, Item_Status, Quantity_available, Price, Category_ID) VALUES ('1111', 'Smartphone', '2019-11-02', 'Selled', '3', '2000.00', '2525');
INSERT INTO ITEM (Item_ID, Item_Description, Publication_Date, Item_Status, Quantity_available, Price, Category_ID) VALUES ('1112', 'Smartphone', '2019-11-02', 'Selled', '3', '1100.00', '2526');
INSERT INTO ITEM (Item_ID, Item_Description, Publication_Date, Item_Status, Quantity_available, Price, Category_ID) VALUES ('1113', 'Smartphone', '2019-11-02', 'Selled', '2', '2500.00', '2527');
INSERT INTO ITEM (Item_ID, Item_Description, Publication_Date, Item_Status, Quantity_available, Price, Category_ID) VALUES ('1114', 'Smartphone', '2019-11-02', 'Selled', '1', '5000.00', '2528');
INSERT INTO ITEM (Item_ID, Item_Description, Publication_Date, Item_Status, Quantity_available, Price, Category_ID) VALUES ('1115', 'Smartphone', '2019-11-02', 'Selled', '5', '10000.00', '2529');
 
 -- Tabla Order --
INSERT INTO `ORDER` (Order_ID, Invoice_ID, Customer_ID, Item_ID, Date_Order, Quantity, Total_Price, Ship_Date) VALUES ('444444', 'FAC002-0005487', '37618809', '1111', '2020-01-02', '1', '2000.00', '2020-01-03'); 
INSERT INTO `ORDER` (Order_ID, Invoice_ID, Customer_ID, Item_ID, Date_Order, Quantity, Total_Price, Ship_Date) VALUES ('555555', 'FAC002-0005488', '8390439', '1112', '2020-01-03', '2', '2200.00', '2020-01-04');  
INSERT INTO `ORDER` (Order_ID, Invoice_ID, Customer_ID, Item_ID, Date_Order, Quantity, Total_Price, Ship_Date) VALUES ('666666', 'FAC002-0005489', '10904034', '1113', '2020-01-04', '1', '2500.00', '2020-01-05'); 
INSERT INTO `ORDER` (Order_ID, Invoice_ID, Customer_ID, Item_ID, Date_Order, Quantity, Total_Price, Ship_Date) VALUES ('777777', 'FAC002-0005490', '28390439', '1114', '2020-01-05', '2', '10000.00', '2020-01-06'); 
INSERT INTO `ORDER` (Order_ID, Invoice_ID, Customer_ID, Item_ID, Date_Order, Quantity, Total_Price, Ship_Date) VALUES ('888888', 'FAC002-0005491', '47554558', '1115', '2020-01-06', '1', '10000.00', '2020-01-08'); 


-- Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500 -- 

SELECT 
    C.Customer_ID,
    C.Customer_Name,
    C.Customer_Surname,
    SUM(O.Total_Price) AS Total_Income
    
FROM CUSTOMER C
LEFT JOIN `ORDER` O
ON C.Customer_ID = O.Customer_ID

WHERE DATE_FORMAT(C.Date_Birth, "%d-%m") = DATE_FORMAT(CURRENT_DATE, "%d-%m")
AND DATE_FORMAT(O.Date_Order, "%Y-%m") = '2020-01'
GROUP BY C.Customer_ID, C.Customer_Name, C.Customer_Surname
HAVING Total_Income > 1500.00 ; 


-- Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares --
-- Se requiere el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos --
-- y el monto total transaccionado -- 


SELECT 
    DATE_FORMAT(O.Date_Order, '%m-%y') AS Mes_Anio,
    C.Customer_Name,
    C.Customer_Surname,
    COUNT(O.Order_ID) AS Cantidad_Ventas,
    SUM(O.Quantity) AS Productos_Vendidos,
    SUM(O.Total_Price) AS Monto_Total
    
FROM `Order` O
LEFT JOIN Item I ON O.Item_ID = I.Item_ID
JOIN Categoria CAT ON I.Category_ID = CAT.Category_ID
JOIN Customer C ON O.Customer_ID = C.Customer_ID
	
WHERE CAT.Category_Description = 'Celulares'
AND YEAR (O.Date_Order) = 2020
GROUP BY DATE_FORMAT(O.Date_Order, '%m-%y'), C.Customer_ID
ORDER BY Mes_Anio, Monto_Total DESC
LIMIT 5 ;
 

-- Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día --
-- Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado --
-- informado por la PK definida. (Se puede resolver a través de StoredProcedure) --

-- CREAR TABLA --

CREATE TABLE `ITEM_STATUS_LATEST`  
(
    Item_ID 		VARCHAR (20) NOT NULL ,
    Date_status 	DATE NOT NULL ,
    Price 			DECIMAL (8, 2) NOT NULL ,
    Item_status 	VARCHAR (50) NOT NULL ,
    
    PRIMARY KEY (Item_ID)
);

-- CREAR STORED PROCEDURE --

-- OPCION 1 -- 

DELIMITER $$

CREATE PROCEDURE `ITEM_STATUS_PROCEDURE` (IN input_date DATE)
BEGIN

    -- Insertar solo registros que no estén aún con misma fecha y mismos valores
    INSERT INTO ITEM_STATUS_LATEST (Item_ID, Date_status, Price, Item_status)
    SELECT 
        A.Item_ID,
        input_date AS Date_status,
        A.Price,
        A.Item_status
    FROM ITEM A
    WHERE NOT EXISTS (
        SELECT 1 
        FROM ITEM_STATUS_LATEST B
        WHERE 
            B.Item_ID = A.Item_ID
            AND B.Date_status = input_date
            AND B.Price = A.Price
            AND B.Item_status = A.Item_status
    );

END $$

DELIMITER ;

CALL ITEM_STATUS_PROCEDURE('2020-02-02'); 
            



            



