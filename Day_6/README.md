# 📊 SQL Sales Analysis Project

This project focuses on analyzing sales data using SQL. I worked with a sales dataset containing multiple fact and dimension tables. The goal was to generate insights related to revenue, customers, and products.

---

## 🗂️ Tables Used

### Fact Tables:
- `fact_sales_monthly` – Sales data per month
- `fact_gross_price` – Product prices by fiscal year
- `fact_forecast_monthly` – Forecasted sales
- `fact_freight_cost` – Freight cost
- `fact_manufacturing_cost` – Manufacturing cost
- `fact_post_invoice_deduction` – Deductions after invoice
- `fact_pre_invoice_deduction` – Deductions before invoice

### Dimension Tables:
- `dim_product` – Product details
- `dim_customer` – Customer details

---

## ✅ What I Did

- **Revenue Analysis**  
  - Calculated daily, monthly, and yearly revenue using sold quantity and product price.
  - Used fiscal year logic by adjusting the date with `DATE_ADD()`.

- **Top Products**  
  - Found the top 5 products with the highest revenue in 2021.

- **Customer Insights**  
  - Identified top 3 customers by revenue in 2022.
  - Analyzed yearly revenue for each customer.

- **Monthly Trends**  
  - Grouped revenue and volume by year and month using `EXTRACT()` and `GROUP BY`.

- **Order Volume**  
  - Counted distinct products sold each month.

---

## 🛠️ SQL Concepts Used

- `JOIN` (to combine data from multiple tables)
- `SUM()` and `COUNT()` (to calculate revenue and volume)
- `GROUP BY` and `ORDER BY` (to group and sort results)
- `DATE_ADD()` and `EXTRACT()` (to work with fiscal dates and monthly data)
- `LIMIT` (to find top results like products or customers)

---

## 📌 Purpose

This project helped me understand:
- How to work with relational datasets
- How to calculate key business metrics like revenue and volume
- How to extract insights using SQL

---

## 👨‍💻 Tools Used

- MySQL Workbench  
- SQL

---

## 🙋‍♂️ About Me

I'm learning SQL and working on real-world datasets to build my data analysis skills.  
Feel free to connect on [LinkedIn](https://www.linkedin.com/in/naveen-kumar-lebaka-868284267) or check out more projects on [GitHub](https://github.com/Naveen-lebaka).
