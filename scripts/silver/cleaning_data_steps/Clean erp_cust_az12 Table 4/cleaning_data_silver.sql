

SELECT * FROM silver.crm_cust_info;

SELECT * FROM bronze.erp_cust_az12;

SELECT cid
FROM bronze.erp_cust_az12


SELECT cid
FROM bronze.erp_cust_az12
WHERE cid ! = TRIM(cid)




SELECT DISTINCT
    CASE 
	  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
	  ELSE cid
	END AS cid
FROM bronze.erp_cust_az12
WHERE CASE 
	  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
	  ELSE cid
	END NOT IN (SELECT DISTINCT cst_key FROM silver.crm_cust_info)




SELECT DISTINCT
    CASE 
	  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
	  ELSE cid
	END AS cid
FROM bronze.erp_cust_az12


SELECT bdate 
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE()


SELECT 
    CASE 
	  WHEN bdate > GETDATE() THEN NULL
	  ELSE bdate 
	END AS bdate
FROM bronze.erp_cust_az12;


SELECT DISTINCT gen
FROM bronze.erp_cust_az12


SELECT CASE
	   WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
	   WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
	   ELSE 'n/a'
	END AS gen
FROM bronze.erp_cust_az12


SELECT
    CASE 
	  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
	  ELSE cid
	END AS cid,
	CASE 
	   WHEN bdate > GETDATE() THEN NULL 
	   ELSE bdate
	END AS bdate,
	CASE
	   WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
	   WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
	   ELSE 'n/a'
	END AS gen
FROM bronze.erp_cust_az12




INSERT INTO silver.erp_cust_az12
                               ( 
							    cid,
								bdate,
								gen
								)
SELECT
    CASE 
	  WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid)) 
	  ELSE cid
	END AS cid,
	CASE 
	   WHEN bdate > GETDATE() THEN NULL 
	   ELSE bdate
	END AS bdate,
	CASE
	   WHEN UPPER(TRIM(gen)) IN ('F','Female') THEN 'Female'
	   WHEN UPPER(TRIM(gen)) IN ('M','Male') THEN 'Male'
	   ELSE 'n/a'
	END AS gen
FROM bronze.erp_cust_az12




SELECT * FROM silver.erp_cust_az12