--"You’ve been asked to analyze the monthly revenue performance of the business for the year 2013.
--Using the sales data from the fact_sales table:
--Calculate the total sales amount per month. (Note: sales_amount * quantity gives the true revenue.)
--Include the total quantity of items sold and the number of distinct customers each month.
--Compute the percentage change in total sales compared to the previous month.
--Return the results for each month in 2013, and make sure the output is ordered chronologically."


with Sales_FACT as (SELECT 
	year(order_date) as Year,
	datename(month,order_date)as Month,
	MONTH(order_date)AS EMONTH,
	customer_key,
	sales_amount,
	quantity,
	sales_amount*quantity AS Total_Amount
FROM gold.fact_sales),

YOY AS (

SELECT YEAR,
			MONTH,
			SUM(Total_Amount)AS TOTAL_SALES,
			COUNT(quantity)AS TOTAL_QUANTITY,
			COUNT(DISTINCT(customer_key))AS TOTAL_CUSTOMER,
			EMONTH
		FROM Sales_FACT
		WHERE YEAR IS NOT NULL
		GROUP BY YEAR,MONTH,EMONTH )

SELECT YEAR,
	MONTH,
	TOTAL_SALES,
	ROUND((TOTAL_SALES - LAG(TOTAL_SALES) OVER (ORDER BY year,eMONTH)) * 100.0 / (TOTAL_SALES), 2) AS PERCENTAGE_CHANGE
FROM YOY
WHERE YEAR =2013

