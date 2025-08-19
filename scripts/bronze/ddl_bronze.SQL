-- ===================================================
-- File: ddl_bronze.sql
-- Purpose: Create Bronze Layer Tables (Raw Data Ingestion)
-- Author: KAMBHAM HEMANTH REDDY
-- Date: 19/08/2025
-- ===================================================

-- Drop and create CRM Customer Info table
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,                        -- Customer ID
    cst_key NVARCHAR(50),              -- Customer Key
    cst_firstname NVARCHAR(50),        -- First Name
    cst_lastname NVARCHAR(50),         -- Last Name
    cst_material_status NVARCHAR(50),  -- Marital Status
    cst_gndr NVARCHAR(50),             -- Gender
    cst_create_date DATE               -- Customer Creation Date
);

-- Drop and create CRM Product Info table
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,               -- Product ID
    prd_key NVARCHAR(50),     -- Product Key
    prd_nm NVARCHAR(50),      -- Product Name
    prd_cost INT,             -- Product Cost
    prd_line NVARCHAR(50),    -- Product Line
    prd_start_dt DATETIME,    -- Product Start Date
    prd_end_dt DATETIME       -- Product End Date
);

-- Drop and create CRM Sales Details table
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),  -- Sales Order Number
    sls_prd_key NVARCHAR(50),  -- Product Key
    sls_cust_id INT,           -- Customer ID
    sls_order_dt INT,          -- Order Date (raw format)
    sls_ship_dt INT,           -- Shipping Date (raw format)
    sls_due_dt INT,            -- Due Date (raw format)
    sls_sales INT,             -- Sales Amount
    sls_quantity INT,          -- Quantity Ordered
    sls_price INT              -- Price per Unit
);

-- Drop and create ERP Location table
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),   -- Customer ID
    cntry NVARCHAR(50)  -- Country
);

-- Drop and create ERP Customer table
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),   -- Customer ID
    bdate DATE,         -- Birth Date
    gen NVARCHAR(50)    -- Gender
);

-- Drop and create ERP Product Category table
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),          -- Product ID
    cat NVARCHAR(50),         -- Category
    subcat NVARCHAR(50),      -- Sub-Category
    maintenance NVARCHAR(50)  -- Maintenance Info
);
