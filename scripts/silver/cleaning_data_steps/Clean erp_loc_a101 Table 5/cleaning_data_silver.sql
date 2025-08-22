SELECT * FROM silver.crm_cust_info;

SELECT * FROM bronze.erp_loc_a101

SELECT 
    REPLACE(cid,'-','') AS cid
FROM bronze.erp_loc_a101




SELECT 
    REPLACE(cid,'-','') AS cid
FROM bronze.erp_loc_a101 
WHERE REPLACE(cid,'-','') NOT IN (SELECT cst_key from silver.crm_cust_info)

SELECT DISTINCT cntry
FROM bronze.erp_loc_a101

SELECT 
   CASE 
      WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	  WHEN TRIM(cntry) IN ('US','United States') THEN 'United States'
	  WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	  ELSE TRIM(cntry)
   END AS cntry
FROM bronze.erp_loc_a101


SELECT 
    REPLACE(cid,'-','') AS cid,
	CASE 
      WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	  WHEN TRIM(cntry) IN ('US','United States') THEN 'United States'
	  WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	  ELSE TRIM(cntry)
   END AS cntry
FROM bronze.erp_loc_a101




INSERT INTO silver.erp_loc_a101
                        (
						cid,
						cntry
						)
SELECT 
    REPLACE(cid,'-','') AS cid,
	CASE 
      WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	  WHEN TRIM(cntry) IN ('US','United States') THEN 'United States'
	  WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	  ELSE TRIM(cntry)
   END AS cntry
FROM bronze.erp_loc_a101