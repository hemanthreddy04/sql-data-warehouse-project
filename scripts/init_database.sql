-- ===================================================
-- Script: init_database.sql
-- Purpose: Initialize the Data Warehouse database and create schemas
-- WARNING: This script DROPS and RECREATES the 'DataWarehouse' database.
--          Any existing data inside this database will be permanently deleted.
-- Author: [Your Name/Team]
-- Date: [Current Date]
-- ===================================================

-- Step 0: Switch context to the master system database.
--         This is required because database-level operations (like creating or dropping
--         databases) cannot be performed from within the same database being modified.
USE master;
GO

-- Step 1: Check if the 'DataWarehouse' database already exists.
--         If it exists, the script will first forcefully disconnect all active connections
--         (by setting the database into SINGLE_USER mode and rolling back open transactions),
--         and then drop it. This ensures that the environment starts fresh with no conflicts.
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    -- Force disconnect all users and roll back incomplete transactions
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the database to allow recreation
    DROP DATABASE DataWarehouse;
END
GO

-- Step 2: Create a new clean 'DataWarehouse' database.
--         This acts as the central repository for all data warehouse layers (bronze, silver, gold).
CREATE DATABASE DataWarehouse;
GO

-- Step 3: Switch the current context to the newly created database.
--         From this point onwards, all operations will apply to 'DataWarehouse'.
USE DataWarehouse;
GO

-- Step 4: Create schemas to logically separate each data layer.
--         Schemas act like folders inside the database, providing structure and access control.
--         - Bronze schema: Stores raw, unprocessed data loaded directly from source systems.
--         - Silver schema: Stores cleansed, transformed, and standardized data, 
--                          but still closely aligned to the source structure.
--         - Gold schema:   Stores the final curated, business-ready data model (fact and dimension tables),
--                          optimized for analytics and reporting.
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

-- ===================================================
-- End of Script
-- Notes:
-- 1. After this initialization, ETL processes can load data into Bronze,
--    apply transformations into Silver, and model business facts/dimensions in Gold.
-- 2. Additional schemas (e.g., 'dw_metadata' for ETL logging and audit tables) can also be created.
-- ===================================================
