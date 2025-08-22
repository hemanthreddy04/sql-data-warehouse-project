
SELECT * FROM bronze.crm_prd_info;

SELECT prd_id,
       COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)



SELECT prd_cost 
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

SELECT * FROM 
bronze.crm_prd_info
WHERE prd_end_dt<prd_start_dt;


SELECT * FROM 
bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509')



SELECT prd_id,
       prd_key,
	   REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	   SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
	   prd_nm,
	   ISNULL(prd_cost, 0) AS prd_cost,
	   CASE
	     WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'n/a'
	   END AS prd_line,
	   CAST(prd_start_dt AS DATE) AS prd_start_dt,
	   CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info



SELECT prd_id,
	   REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	   SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
	   prd_nm,
	   ISNULL(prd_cost, 0) AS prd_cost,
	   CASE
	     WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'n/a'
	   END AS prd_line,
	   CAST(prd_start_dt AS DATE) AS prd_start_dt,
	   CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info



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




INSERT INTO silver.crm_prd_info
         (
            prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
           )
SELECT prd_id,
	   REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
	   SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
	   prd_nm,
	   ISNULL(prd_cost, 0) AS prd_cost,
	   CASE
	     WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		 ELSE 'n/a'
	   END AS prd_line,
	   CAST(prd_start_dt AS DATE) AS prd_start_dt,
	   CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info




/* to check the quality*/

SELECT prd_id,
       COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)



SELECT prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

SELECT * FROM 
silver.crm_prd_info
WHERE prd_end_dt<prd_start_dt;