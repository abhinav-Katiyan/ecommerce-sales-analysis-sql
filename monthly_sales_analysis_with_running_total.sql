--"You are working as a data analyst for an e-commerce company. Your task is to analyze the company's monthly sales performance.
--Write a SQL query to:

--Calculate the total sales per month (based on order_date).
--Compute a running total of sales over time to see how cumulative revenue grows.
--Include the number of unique customers per month to analyze engagement trends.
--Optionally, also show the monthly percentage growth in total sales compared to the previous month."
--Return the result ordered by year and month."

WITH MONTHLY_ORDER AS (
    SELECT 
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month_number,
        DATENAME(MONTH, order_date) AS order_month_name,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT customer_key) AS unique_customers
    FROM gold.fact_sales
    WHERE YEAR(order_date) IS NOT NULL
    GROUP BY 
        YEAR(order_date), 
        MONTH(order_date), 
        DATENAME(MONTH, order_date)
),

SALES_WITH_STATS AS (
    SELECT *,
        SUM(total_sales) OVER (ORDER BY order_year, order_month_number) AS running_total,
        LAG(total_sales) OVER (ORDER BY order_year, order_month_number) AS prev_month_sales
    FROM MONTHLY_ORDER
)

SELECT 
    order_year,
    order_month_number AS month_number,
    order_month_name,
    total_sales,
    running_total,
    prev_month_sales,
    unique_customers,
    ROUND(
        CASE 
            WHEN prev_month_sales IS NULL THEN NULL
            ELSE ((total_sales - prev_month_sales) * 100.0 / prev_month_sales)
        END, 2
    ) AS sales_growth_percent
FROM SALES_WITH_STATS
WHERE order_year = 2011  -- You can change the year for other analysis
ORDER BY order_year, month_number;
