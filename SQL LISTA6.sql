
DELETE CUSTOMER FROM CUSTOMER LEFT JOIN REQUEST 
ON REQUEST.CDCUSTOMER=CUSTOMER.CDCUSTOMER
WHERE CUSTOMER.CDCUSTOMER IS NULL;

DELETE FROM CUSTOMER WHERE NOT EXISTS(SELECT * FROM REQUEST WHERE CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER);

DELETE SUPPLIER FROM SUPPLIER LEFT JOIN PRODUCT 
ON PRODUCT.CDSUPPLIER=SUPPLIER.CDSUPPLIER
WHERE PRODUCT.CDPRODUCT IS NULL;

DELETE FROM SUPPLIER WHERE NOT EXISTS(SELECT * FROM PRODUCT WHERE SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER);

UPDATE PRODUCTREQUEST SET VLUNITARY = PRODUCT.VLPRICE
FROM PRODUCTREQUEST JOIN PRODUCT ON PRODUCT.CDPRODUCT = PRODUCTREQUEST.CDPRODUCT;

UPDATE SUPPLIER SET DSSTATUS = 'INATIVO'
FROM SUPPLIER WHERE NOT EXISTS(SELECT * FROM PRODUCT WHERE SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER);

UPDATE SUPPLIER SET DSSTATUS = 'ATIVO'
FROM SUPPLIER WHERE EXISTS(SELECT * FROM PRODUCT WHERE SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER);

UPDATE CUSTOMER SET NMADRESS = 'desconhecido' FROM CUSTOMER WHERE NMADRESS IS NULL;

INSERT INTO PRODUCTREQUEST (CDREQUEST, CDPRODUCT, QTAMOUNT, VLUNITARY)
SELECT CDREQUEST, PRODUCT.CDPRODUCT, 10, VLPRICE FROM PRODUCT
CROSS JOIN PRODUCTREQUEST;

SELECT CUSTOMER.NMCUSTOMER, PRODUCT.NMPRODUCT, COUNT(PRODUCT.CDPRODUCT) AS AMNTBOUGHT, SUM(PRODUCT.VLPRICE) AS TOTALPRICE
FROM PRODUCTREQUEST
INNER JOIN PRODUCT ON PRODUCT.CDPRODUCT = PRODUCTREQUEST.CDPRODUCT
INNER JOIN REQUEST ON REQUEST.CDREQUEST = PRODUCTREQUEST.CDREQUEST
INNER JOIN CUSTOMER ON CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER
GROUP BY NMCUSTOMER, NMPRODUCT
ORDER BY NMCUSTOMER;

SELECT CUSTOMER.NMCUSTOMER, SUM(VLTOTAL) AS TOTALBOUGHT FROM REQUEST
INNER JOIN CUSTOMER ON CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER
WHERE DTREQUEST >= '20030101' AND DTREQUEST <= '20031231'
GROUP BY NMCUSTOMER;

SELECT SUPPLIER.CDSUPPLIER, NMSUPPLIER, IDFONE, NMPRODUCT, QTSTOCK FROM PRODUCT
RIGHT JOIN SUPPLIER ON SUPPLIER.CDSUPPLIER = PRODUCT.CDSUPPLIER;

SELECT CUSTOMER.NMCUSTOMER, REQUEST.DTREQUEST, REQUEST.VLTOTAL FROM REQUEST
RIGHT JOIN CUSTOMER ON CUSTOMER.CDCUSTOMER = REQUEST.CDCUSTOMER

