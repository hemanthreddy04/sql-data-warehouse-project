-- ===================================================
-- Script: bronze_layer.sql
-- Purpose: Create and Load Bronze Layer tables
-- Author: Kambham Hemanth Reddy
-- ===================================================

-- ===================================================
-- Step 1: Create Bronze Layer Tables
-- • Create staging tables for CRM and ERP data
-- • Drops existing tables if already present
-- • Acts as raw data storage (no transformation)
-- ===================================================

IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);


-- ===================================================
-- Step 2: Load Data into Bronze Tables
-- • Truncate old data
-- • Use BULK INSERT to load CSV files from source systems
-- • CRM and ERP datasets are staged as raw copies
-- ===================================================

TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )

TRUNCATE TABLE bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )

TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )

TRUNCATE TABLE bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )

TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )

TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
     FIRSTROW = 2,
     FIELDTERMINATOR = ',',
     TABLOCK
    )


-- ===================================================
-- Step 3: Validate Bronze Data
-- • Run simple SELECT queries to preview data
-- • Ensures CSV data is loaded successfully
-- ===================================================

SELECT * FROM bronze.crm_cust_info
SELECT * FROM bronze.crm_prd_info
SELECT * FROM bronze.crm_sales_details
SELECT * FROM bronze.erp_cust_az12
SELECT * FROM bronze.erp_loc_a101
SELECT * FROM bronze.erp_px_cat_g1v2


-- ===================================================
-- Step 4: Create Stored Procedure for Automation
-- • Procedure: bronze.load_bronze
-- • Automates the truncate + bulk insert process
-- • Adds logging for load duration
-- • Handles errors using TRY...CATCH
-- ===================================================

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN   
  DECLARE @start_time DATETIME
  DECLARE @end_time DATETIME
  BEGIN TRY
        PRINT '==========================================='
        PRINT 'Loading Bronze Layer'
        PRINT '==========================================='

        PRINT '-------------------------------------------'
        PRINT 'Loading CRM Tables'
        PRINT '-------------------------------------------'

        PRINT '>>Truncating Table : bronze.crm_cust_info>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.crm_cust_info
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)

        PRINT '>>Truncating Table : bronze.crm_prd_info>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.crm_prd_info
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)

        PRINT '>>Truncating Table : bronze.crm_sales_details>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.crm_sales_details
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)

        PRINT '-------------------------------------------'
        PRINT 'Loading ERP Tables'
        PRINT '-------------------------------------------'

        PRINT '>>Truncating Table : bronze.erp_loc_a101>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.erp_loc_a101
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)

        PRINT '>>Truncating Table : bronze.erp_cust_az12>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.erp_cust_az12
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)

        PRINT '>>Truncating Table : bronze.erp_px_cat_g1v2>>'
        SET @start_time = GETDATE()
        TRUNCATE TABLE bronze.erp_px_cat_g1v2
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Yeswanth Reddy\OneDrive\Desktop\SQL Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH(
             FIRSTROW = 2,
             FIELDTERMINATOR = ',',
             TABLOCK
            )
        SET @end_time = GETDATE()
        PRINT 'Load Duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR)
  END TRY

  BEGIN CATCH
       PRINT 'Error Occured during Loading Bronze Layer'
       PRINT 'Error Message :' + ERROR_MESSAGE()
       PRINT 'Error Number : ' + CAST(ERROR_NUMBER() AS VARCHAR)
       PRINT 'Error State : ' + CAST(ERROR_STATE() AS VARCHAR)
  END CATCH
END


-- ===================================================
-- Step 5: Execute Bronze Load Procedure
-- • Runs the stored procedure to load all CRM & ERP files
-- ===================================================

EXEC bronze.load_bronze;
