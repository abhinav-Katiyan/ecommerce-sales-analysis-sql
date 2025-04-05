--"Classify customers into 'High Frequency', 'Medium Frequency', and 'Low Frequency' segments based on their average days between orders. Assume:
---High: ≤ 7 days
--Medium: 8–30 days
--Low: > 30 days"

WITH NEXT_ORDERS AS (
    SELECT 
        S.customer_key,
        first_name,
        last_name,
        country,
        product_key,
        sales_amount,
        order_date,
        LEAD(order_date) OVER (PARTITION BY S.customer_key ORDER BY order_date) AS next_order,
        DATEDIFF(DAY, order_date, LEAD(order_date) OVER (PARTITION BY S.customer_key ORDER BY order_date)) AS diff
    FROM gold.fact_sales S
    JOIN gold.dim_customers C ON S.customer_key = C.customer_key
),

CUSTOMER_GAPS AS (
    SELECT 
        customer_key,
        first_name,
        last_name,
        country,
        AVG(diff) AS avg_days
    FROM NEXT_ORDERS
    WHERE diff IS NOT NULL AND diff != 0
    GROUP BY customer_key, first_name, last_name, country
),

CUSTOMER_SEGMENTED AS (
    SELECT *,
        CASE 
            WHEN avg_days <= 7 THEN 'High'
            WHEN avg_days <= 30 THEN 'Medium'
            ELSE 'Low'
        END AS customer_status
    FROM CUSTOMER_GAPS
)

SELECT 
    customer_status,
    COUNT(*) AS customer_count
FROM CUSTOMER_SEGMENTED
GROUP BY customer_status
ORDER BY customer_status;
