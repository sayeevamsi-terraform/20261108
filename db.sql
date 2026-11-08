-- =====================================================
-- DATABASE
-- =====================================================

CREATE DATABASE IF NOT EXISTS CLOUDOPS_DB
COMMENT = 'Training database for Snowflake learning';

USE DATABASE CLOUDOPS_DB;

-- =====================================================
-- SCHEMAS
-- =====================================================

CREATE SCHEMA IF NOT EXISTS RAW
COMMENT = 'Landing area for source data';

CREATE SCHEMA IF NOT EXISTS CURATED
COMMENT = 'Cleaned and transformed data';

CREATE SCHEMA IF NOT EXISTS ANALYTICS
COMMENT = 'Business reporting and analytics data';

-- =====================================================
-- RAW SCHEMA TABLES
-- =====================================================

CREATE OR REPLACE TABLE RAW.CUSTOMERS (
    CUSTOMER_ID NUMBER,
    CUSTOMER_NAME STRING,
    EMAIL STRING,
    CITY STRING,
    CREATED_DATE DATE
)
COMMENT = 'Raw customer data loaded from source systems';

CREATE OR REPLACE TABLE RAW.ORDERS (
    ORDER_ID NUMBER,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    ORDER_AMOUNT NUMBER(10,2)
)
COMMENT = 'Raw order data loaded from source systems';