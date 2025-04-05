WITH CUM_SUM AS (SELECT YEAR,
	MONTH,
	EMONTH,
	SUM(Total_sales) AS TOTA_SALES

FROM (SELECT customer_key,
		year(order_date)as year,
		datename(month,order_date)as month,
		MONTH(order_date)AS EMONTH,
		price*quantity AS Total_sales
	  FROM gold.fact_sales
	  WHERE order_date IS NOT NULL)T
GROUP BY YEAR,MONTH ,EMONTH
)

SELECT * ,
	SUM(TOTA_SALES)OVER(PARTITION BY YEAR ORDER BY YEAR,EMONTH) AS CUM_SUM
FROM CUM_SUM
WHERE YEAR = 2013
ORDER BY YEAR,  EMONTH


