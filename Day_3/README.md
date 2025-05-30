# 🎬 Movie & Sales SQL Analysis

## 📁 Project Overview

This project contains SQL queries used to perform detailed analysis on two datasets:

1. **Movie Dataset**  
2. **Sales Dataset (fact_sales_monthly)**

The queries cover everything from basic filtering to advanced joins, calculations, and subqueries. Ideal for learning and demonstrating SQL skills through practical, real-world-style scenarios.

---

## 🧩 Datasets Used

### 🎥 `movies`
Contains metadata for various films, including:
- `movie_id`
- `title`
- `release_year`
- `industry` (e.g., Bollywood, Hollywood)
- `imdb_rating`
- `studio`
- `language_id`

### 💰 `financials`
Holds budget and revenue information for movies:
- `movie_id`
- `budget`
- `revenue`
- `currency`
- `unit` (e.g., thousands, billions)

### 🎭 `actors`, `movie_actor`
Relational tables to map actors to movies:
- `actor_id`, `name`
- `movie_id`, `actor_id`

### 🌐 `languages`
Language information:
- `language_id`, `name`

### 🛒 `fact_sales_monthly`, `dim_product`, `fact_gross_price`
Used for monthly product sales data analysis:
- `customer_code`
- `date`
- `product_code`, `product`, `variant`
- `sold_quantity`, `gross_price`
- `fiscal_year`

---

## 📚 SQL Topics Covered

| Section                       | Description                                                                 |
|------------------------------|-----------------------------------------------------------------------------|
| Basic Filtering               | Using `WHERE`, `LIKE`, and handling NULLs                                  |
| Sorting & Range Queries       | Sorting data with `ORDER BY`, filtering with `IN`, `AND`, and comparisons  |
| Aggregation                  | Using `COUNT()`, `AVG()`, `MAX()`, `MIN()`, and `GROUP BY`                  |
| Calculated Fields            | Performing math operations, using `IF` and `CASE` for unit adjustments      |
| Joins                        | Implementing `INNER`, `LEFT`, `RIGHT` joins for multi-table analysis        |
| Advanced Aggregation         | Grouping with calculated columns, `GROUP_CONCAT()` for listing actors      |
| Subqueries & Nesting         | Subqueries inside `WHERE`, calculating from derived values                  |

---

## 🚀 How to Use

1. **Open a SQL client** (like MySQL Workbench, PostgreSQL, DBeaver, etc.)
2. **Connect to your database** and load the dataset tables.
3. Copy the SQL queries from `queries.sql` (you can save the cleaned code as this file).
4. Run them step by step to explore and understand the data.

---

## 📝 Sample Use Cases

- Find the highest-grossing Hindi movie after adjusting for currency/unit.
- Identify actors who starred together in movies.
- Track customer-level gross sales over time.
- Calculate profit percentages for films based on budgets and revenues.

---

## 🧠 Skills Practiced

- SQL Filtering and Sorting  
- Joins & Aggregations  
- CASE Statements & Conditional Logic  
- Subqueries  
- Grouping and Reporting
