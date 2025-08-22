SELECT * FROM bronze.crm_cust_info;


SELECT cst_id,
       COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


SELECT * FROM bronze.crm_cust_info WHERE cst_id = 29466;

SELECT *,
       ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info 
WHERE cst_id = 29466;



SELECT *,
       ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info




SELECT *,flag_last 
FROM (
	SELECT *,
		   ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info
)t
WHERE flag_last = 1 AND cst_id IS NOT NULL 




 