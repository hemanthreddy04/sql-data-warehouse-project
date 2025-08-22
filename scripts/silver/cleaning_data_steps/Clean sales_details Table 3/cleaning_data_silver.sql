SELECT * FROM bronze.crm_sales_details

SELECT sls_ord_num,
       COUNT(*)
FROM bronze.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1;



SELECT sls_ord_num
FROM bronze.crm_sales_details
WHERE sls_ord_num != TRIM(sls_ord_num)
OR sls_ord_num IS NULL;




SELECT sls_prd_key
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);

SELECT sls_cust_id
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);


SELECT 
   sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0
OR LEN(sls_order_dt) != 8
OR sls_order_dt < 19900101
OR sls_order_dt > 20500101


SELECT 
    NULLIF(sls_order_dt,0) AS sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0
OR LEN(sls_order_dt) != 8
OR sls_order_dt < 19900101
OR sls_order_dt > 20500101


SELECT * 
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR
sls_order_dt > sls_due_dt OR
sls_ship_dt > sls_due_dt



SELECT sls_sales,sls_quantity,sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL 
OR sls_sales < = 0 OR sls_quantity < = 0 OR sls_price < = 0


SELECT DISTINCT
   CASE
     WHEN sls_sales IS NULL OR sls_sales < = 0 OR sls_sales ! = sls_quantity * ABS(sls_price) 
	 THEN sls_quantity * ABS(sls_price)
	 ELSE sls_price
	END AS sls_sales,
	sls_quantity,
   CASE 
    WHEN sls_price IS NULL OR sls_price < = 0
	THEN sls_sales/NULLIF(sls_quantity,0)
	ELSE sls_price
   END AS sls_price
FROM bronze.crm_sales_details





SELECT sls_ord_num,
       sls_prd_key,
	   sls_cust_id,
	   CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
		END AS sls_order_dt,
		CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
	   END AS sls_ship_dt,
	   CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
	   END AS sls_due_dt,
	   CASE
         WHEN sls_sales IS NULL OR sls_sales < = 0 OR sls_sales ! = sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
	     ELSE sls_price
	   END AS sls_sales,
	   sls_quantity,
       CASE 
         WHEN sls_price IS NULL OR sls_price < = 0 THEN sls_sales/NULLIF(sls_quantity,0)
	     ELSE sls_price
       END AS sls_price
FROM bronze.crm_sales_details





INSERT INTO silver.crm_sales_details 
                              (
							  sls_ord_num,
							  sls_prd_key,
							  sls_cust_id,
							  sls_order_dt,
							  sls_ship_dt,
							  sls_due_dt,
							  sls_sales,
							  sls_quantity,
							  sls_price
							  )

SELECT sls_ord_num,
       sls_prd_key,
	   sls_cust_id,
	   CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
		END AS sls_order_dt,
		CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
	   END AS sls_ship_dt,
	   CASE 
	     WHEN sls_order_dt < = 0 THEN NULL
		 WHEN LEN(sls_order_dt) !=8 THEN NULL
		 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE) 
	   END AS sls_due_dt,
	   CASE
         WHEN sls_sales IS NULL OR sls_sales < = 0 OR sls_sales ! = sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price)
	     ELSE sls_price
	   END AS sls_sales,
	   sls_quantity,
       CASE 
         WHEN sls_price IS NULL OR sls_price < = 0 THEN sls_sales/NULLIF(sls_quantity,0)
	     ELSE sls_price
       END AS sls_price
FROM bronze.crm_sales_details