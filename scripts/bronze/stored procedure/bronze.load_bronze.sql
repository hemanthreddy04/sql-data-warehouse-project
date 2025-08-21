-- ===================================================
--  Create Stored Procedure for Automation
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
