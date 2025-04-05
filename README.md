# 📊 E-commerce Sales Analysis (SQL)

This project contains a collection of SQL scripts aimed at analyzing **customer purchasing behavior** and **sales performance** using advanced SQL techniques such as CTEs, window functions, aggregations, and time-series calculations.

---

## 🎯 Project Objective

The goal of this repository is to perform **exploratory data analysis (EDA)** on an e-commerce sales dataset to uncover meaningful insights that can drive business decisions. The focus areas include:

- Understanding customer order frequency
- Classifying customers based on engagement
- Tracking monthly sales performance
- Calculating running totals and cumulative growth
- Measuring year-over-year (YOY) changes in revenue

---

## 🧠 Key Insights & Outcomes

### ✅ Customer Behavior Analysis:
- **Average Days Between Orders**: Measured for each customer to understand their purchase frequency.
- **Customer Segmentation**: Customers are categorized as `High`, `Medium`, or `Low Frequency` based on average time between orders.
- **Retention Strategy**: Identified potential churn segments and high-value customers.

### 📈 Sales Performance Analysis:
- **Monthly Sales Totals**: Analyzed sales volume and revenue trends month-by-month.
- **Running Totals**: Used to visualize growth over time.
- **YOY Analysis**: Compared sales across different years to track revenue growth and seasonality.
- **Cumulative Revenue**: Showed overall performance and business health per year.

---

---

## 🛠️ SQL Techniques Used

- **Common Table Expressions (CTEs)**
- **Window Functions**: `ROW_NUMBER`, `LEAD`, `LAG`, `SUM() OVER`, `AVG() OVER`
- **Aggregations & Grouping**
- **Date functions**: `DATEDIFF`, `MONTH`, `YEAR`, `DATENAME`
- **CASE statements for segmentation**

---

## 📌 Tools & Environment

- Microsoft SQL Server (T-SQL)
- Git & GitHub for version control
- Sample e-commerce data from a star-schema warehouse model

---
