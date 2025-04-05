--"Write a query to find the average number of days between orders for each customer,
--but only include customers who have placed at least 5 orders. 
--Exclude consecutive orders that occurred on the same day (i.e., where the gap in days is zero).
--Return the customer details and their average days between orders, sorted in descending order."

WITH NEXT_ORDES AS (SELECT S.customer_key,
	first_name,
	last_name,
	country,
	product_key,
	sales_amount,
	order_date,
	LEAD(order_date)OVER(PARTITION BY S.customer_key ORDER BY ORDER_DATE)AS NEXT_ORDER,
	DATEDIFF(DAY,order_date,LEAD(order_date)OVER(PARTITION BY S.customer_key ORDER BY ORDER_DATE))AS DIFF
FROM gold.fact_sales S
JOIN gold.dim_customers C
ON S.customer_key=C.customer_key)

SELECT DISTINCT CUSTOMER_KEY,
	FIRST_NAME,
	last_name,
	country,
	AVG_DAYS
FROM (SELECT  *,
		AVG(DIFF)OVER(PARTITION BY CUSTOMER_KEY) AS AVG_DAYS,
		ROW_NUMBER()OVER(PARTITION BY CUSTOMER_KEY ORDER BY CUSTOMER_KEY) AS RNKK
	FROM NEXT_ORDES
	WHERE DIFF IS NOT NULL AND DIFF !=0 )T
WHERE RNKK>=5
ORDER BY AVG_DAYS DESC
