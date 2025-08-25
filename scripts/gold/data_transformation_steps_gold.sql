SELECT * FROM silver.crm_cust_info;

SELECT * FROM silver.erp_cust_az12;

SELECT * FROM silver.erp_loc_a101;



SELECT ci.cst_id,
       ci.cst_key,
	   ci.cst_firstname,
	   ci.cst_lastname,
	   ci.cst_material_status,
	   ci.cst_gndr,
	   ci.cst_create_date,
	   ca.bdate,
	   la.cntry
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid




SELECT cst_id,
       COUNT(*) 
FROM 
	(
	SELECT ci.cst_id,
		   ci.cst_key,
		   ci.cst_firstname,
		   ci.cst_lastname,
		   ci.cst_material_status,
		   ci.cst_gndr,
		   ci.cst_create_date,
		   ca.bdate,
		   la.cntry
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca 
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_key = la.cid
	)t
GROUP BY cst_id
HAVING COUNT(*) > 1;





	SELECT DISTINCT ci.cst_gndr,
		   ca.gen
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca 
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_key = la.cid


	SELECT DISTINCT ci.cst_gndr,
		   ca.gen,
		   CASE
		     WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
			 ELSE COALESCE(ca.gen,'n/a')
		   END AS new_gen
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca 
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_key = la.cid




SELECT ci.cst_id AS customer_id,
       ci.cst_key AS customer_number,
	   ci.cst_firstname AS first_name,
	   ci.cst_lastname AS last_name,
	   ci.cst_material_status AS material_status,
	   CASE
		     WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr     --CRM is the master for gender 
			 ELSE COALESCE(ca.gen,'n/a')
		   END AS gender,
	   ci.cst_create_date AS create_status,
	   ca.bdate AS birthdate,
	   la.cntry AS country
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid








SELECT 
       ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
       ci.cst_id AS customer_id,
       ci.cst_key AS customer_number,
	   ci.cst_firstname AS first_name,
	   ci.cst_lastname AS last_name,
	   la.cntry AS country,
	   ci.cst_material_status AS material_status,
	   CASE
		     WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr     --CRM is the master for gender 
			 ELSE COALESCE(ca.gen,'n/a')
		   END AS gender,
	   ca.bdate AS birthdate,
	   ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid;



CREATE VIEW gold.dim_customers AS(
		SELECT 
			   ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
			   ci.cst_id AS customer_id,
			   ci.cst_key AS customer_number,
			   ci.cst_firstname AS first_name,
			   ci.cst_lastname AS last_name,
			   la.cntry AS country,
			   ci.cst_material_status AS material_status,
			   CASE
					 WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr     --CRM is the master for gender 
					 ELSE COALESCE(ca.gen,'n/a')
				   END AS gender,
			   ca.bdate AS birthdate,
			   ci.cst_create_date AS create_date
		FROM silver.crm_cust_info AS ci
		LEFT JOIN silver.erp_cust_az12 AS ca 
		ON ci.cst_key = ca.cid
		LEFT JOIN silver.erp_loc_a101 AS la
		ON ci.cst_key = la.cid
)


SELECT * FROM gold.dim_customers;


SELECT pn.prd_id,
       pn.cat_id,
	   pn.prd_key,
	   pn.prd_nm,
	   pn.prd_cost,
	   pn.prd_line,
	   pn.prd_start_dt
FROM silver.crm_prd_info AS pn




SELECT pn.prd_id,
       pn.cat_id,
	   pn.prd_key,
	   pn.prd_nm,
	   pn.prd_cost,
	   pn.prd_line,
	   pn.prd_start_dt
FROM silver.crm_prd_info AS pn
WHERE prd_end_dt IS NULL;




SELECT pn.prd_id,
       pn.cat_id,
	   pn.prd_key,
	   pn.prd_nm,
	   pn.prd_cost,
	   pn.prd_line,
	   pn.prd_start_dt,
	   pc.cat,
	   pc.subcat,
	   pc.maintenance
FROM silver.crm_prd_info AS pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL;


SELECT prd_key,
       COUNT(*)
FROM(
		SELECT pn.prd_id,
			   pn.cat_id,
			   pn.prd_key,
			   pn.prd_nm,
			   pn.prd_cost,
			   pn.prd_line,
			   pn.prd_start_dt,
			   pc.cat,
			   pc.subcat,
			   pc.maintenance
		FROM silver.crm_prd_info AS pn
		LEFT JOIN silver.erp_px_cat_g1v2 AS pc
		ON pn.cat_id = pc.id
		WHERE prd_end_dt IS NULL
    )t GROUP BY prd_key
HAVING COUNT(*) > 1;




SELECT
               pn.prd_id,
			   pn.cat_id,
			   pn.prd_key,
			   pn.prd_nm,
			   pn.prd_cost,
			   pn.prd_line,
			   pn.prd_start_dt,
			   pc.cat,
			   pc.subcat,
			   pc.maintenance
FROM silver.crm_prd_info AS pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL





SELECT         
               ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key)AS product_key,
               pn.prd_id AS product_id,
			   pn.prd_key AS product_number,
			   pn.prd_nm AS product_name,
			   pn.cat_id AS category_id,
			   pc.cat AS catrgory,
			   pc.subcat AS subcategory,
			   pc.maintenance,
			   pn.prd_cost AS cost,
			   pn.prd_line AS product_line,
			   pn.prd_start_dt AS start_date		   
FROM silver.crm_prd_info AS pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL




CREATE VIEW gold.dim_products AS (
		SELECT         ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt,pn.prd_key)AS product_key,
					   pn.prd_id AS product_id,
					   pn.prd_key AS product_number,
					   pn.prd_nm AS product_name,
					   pn.cat_id AS category_id,
					   pc.cat AS catrgory,
					   pc.subcat AS subcategory,
					   pc.maintenance,
					   pn.prd_cost AS cost,
					   pn.prd_line AS product_line,
					   pn.prd_start_dt AS start_date		   
		FROM silver.crm_prd_info AS pn
		LEFT JOIN silver.erp_px_cat_g1v2 AS pc
		ON pn.cat_id = pc.id
		WHERE prd_end_dt IS NULL
)

SELECT * FROM gold.dim_products;




SELECT * FROM silver.crm_sales_details;



SELECT sd.sls_ord_num,
       sd.sls_prd_key,
	   sd.sls_cust_id,
	   sd.sls_order_dt,
	   sd.sls_ship_dt,
	   sd.sls_due_dt,
	   sd.sls_sales,
	   sd.sls_quantity,
	   sd.sls_price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers AS cu
ON sd.sls_cust_id = cu.customer_id;




CREATE VIEW gold.fact_sales AS(
						SELECT sd.sls_ord_num,
							   pr.product_key,
							   cu.customer_key,
							   sd.sls_order_dt,
							   sd.sls_ship_dt,
							   sd.sls_due_dt,
							   sd.sls_sales,
							   sd.sls_quantity,
							   sd.sls_price
						FROM silver.crm_sales_details AS sd
						LEFT JOIN gold.dim_products AS pr
						ON sd.sls_prd_key = pr.product_number
						LEFT JOIN gold.dim_customers AS cu
						ON sd.sls_cust_id = cu.customer_id
					)

SELECT * FROM gold.fact_sales;



SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
WHERE c.customer_key IS NULL 



SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p
ON P.product_key = f.product_key
WHERE p.product_key IS NULL;



SELECT * FROM gold.dim_customers;
SELECT * FROM gold.dim_products;
SELECT * FROM gold.fact_sales;



SELECT * FROM INFORMATION_SCHEMA.COLUMNS;







