

-- Sample Data

INSERT INTO RAW.CUSTOMERS VALUES
(1,'John Smith','john@email.com','Toronto','2026-01-10'),
(2,'Jane Doe','jane@email.com','New York','2026-02-15'),
(3,'Mike Brown','mike@email.com','Chicago','2026-03-20'),
(4,'Sarah Wilson','sarah@email.com','Dallas','2026-04-12'),
(5,'David Lee','david@email.com','Seattle','2026-05-05');

INSERT INTO RAW.ORDERS VALUES
(1001,1,'2026-06-01',250.00),
(1002,2,'2026-06-03',420.50),
(1003,1,'2026-06-08',150.75),
(1004,3,'2026-06-10',890.00),
(1005,5,'2026-06-15',320.20);

-- =====================================================
-- CURATED SCHEMA TABLES
-- =====================================================

CREATE OR REPLACE TABLE CURATED.CUSTOMERS (
    CUSTOMER_ID NUMBER,
    CUSTOMER_NAME STRING,
    EMAIL STRING,
    CITY STRING
)
COMMENT = 'Validated customer master data';

CREATE OR REPLACE TABLE CURATED.ORDERS (
    ORDER_ID NUMBER,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    ORDER_AMOUNT NUMBER(10,2)
)
COMMENT = 'Validated order transactions';

-- Load Curated Layer

INSERT INTO CURATED.CUSTOMERS
SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    CITY
FROM RAW.CUSTOMERS;

INSERT INTO CURATED.ORDERS
SELECT *
FROM RAW.ORDERS;

-- =====================================================
-- ANALYTICS SCHEMA TABLES
-- =====================================================

CREATE OR REPLACE TABLE ANALYTICS.CUSTOMER_SALES (
    CUSTOMER_ID NUMBER,
    CUSTOMER_NAME STRING,
    TOTAL_ORDERS NUMBER,
    TOTAL_SALES NUMBER(12,2)
)
COMMENT = 'Aggregated customer sales metrics';

INSERT INTO ANALYTICS.CUSTOMER_SALES
SELECT
    C.CUSTOMER_ID,
    C.CUSTOMER_NAME,
    COUNT(O.ORDER_ID) AS TOTAL_ORDERS,
    SUM(O.ORDER_AMOUNT) AS TOTAL_SALES
FROM CURATED.CUSTOMERS C
JOIN CURATED.ORDERS O
    ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY
    C.CUSTOMER_ID,
    C.CUSTOMER_NAME;

-- =====================================================
-- VERIFY
-- =====================================================

SELECT * FROM RAW.CUSTOMERS;
SELECT * FROM RAW.ORDERS;

SELECT * FROM CURATED.CUSTOMERS;
SELECT * FROM CURATED.ORDERS;

SELECT * FROM ANALYTICS.CUSTOMER_SALES;