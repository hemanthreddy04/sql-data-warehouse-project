IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info (
    prd_id INT,  
	cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),     
    prd_nm NVARCHAR(50),      
    prd_cost INT,             
    prd_line NVARCHAR(50),  
    prd_start_dt DATE,   
    prd_end_dt DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
