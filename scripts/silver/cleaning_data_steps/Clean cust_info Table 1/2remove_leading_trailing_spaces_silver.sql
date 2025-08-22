SELECT * FROM bronze.crm_cust_info;



SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname !=TRIM(cst_firstname) 

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname !=TRIM(cst_lastname) 

SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr !=TRIM(cst_gndr) 



SELECT cst_id,
       cst_key, 
	   TRIM(cst_firstname) AS cst_firstname,
	   TRIM( cst_lastname) AS cst_lastname,
	   cst_material_status,
	   cst_gndr,
	   cst_create_date
FROM(
		SELECT *,
		   ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info
)t 
WHERE flag_last = 1 AND cst_id IS NOT NULL;