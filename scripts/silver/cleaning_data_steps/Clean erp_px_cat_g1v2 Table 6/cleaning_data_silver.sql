SELECT * FROM silver.crm_prd_info

SELECT * FROM bronze.erp_px_cat_g1v2;


SELECT * FROM bronze.erp_px_cat_g1v2
WHERE id ! = TRIM(id)

SELECT id,
       COUNT(id)
FROM bronze.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(id) > 1 OR id IS NULL;

SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2;


SELECT cat
FROM bronze.erp_px_cat_g1v2
WHERE cat != trim(cat)

SELECT cat
FROM bronze.erp_px_cat_g1v2
WHERE cat = '' OR cat IS NULL



SELECT id FROM 
bronze.erp_px_cat_g1v2
WHERE id NOT IN (select cat_id FROM silver.crm_prd_info)


SELECT cat_id FROM silver.crm_prd_info
WHERE cat_id NOT IN(SELECT id FROM  bronze.erp_px_cat_g1v2)

SELECT * FROM bronze.erp_px_cat_g1v2
WHERE id = 'CO_PE'


SELECT * FROM silver.crm_prd_info
WHERE cat_id = 'CO_PE'



INSERT INTO silver.erp_px_cat_g1v2
                          (
						  id,
						  cat,
						  subcat,
						  maintenance
						  )
SELECT id,
       cat,
	   subcat,
	   maintenance
FROM bronze.erp_px_cat_g1v2

SELECT * FROM silver.erp_px_cat_g1v2