-- Get all movie data
SELECT * FROM movies;

-- Filter movies by industry
SELECT * FROM movies WHERE industry = 'bollywood';
SELECT * FROM movies WHERE industry = 'hollywood';

-- Search for specific words in the movie title
SELECT * FROM movies WHERE title LIKE "%thor%";
SELECT * FROM movies WHERE title LIKE "%america%";

-- Check for missing studio values
SELECT * FROM movies WHERE studio = "";

-- Order movies by release year (latest first)
SELECT title, release_year FROM movies ORDER BY release_year DESC;

-- Get movies released in specific years
SELECT * FROM movies WHERE release_year IN (2019, 2020, 2022);

-- Find movies released after 2020 with a rating greater than 8
SELECT * FROM movies WHERE release_year > 2020 AND imdb_rating > 8;

-- Filter movies with NULL IMDb rating
SELECT * FROM movies WHERE imdb_rating IS NULL;

-- Count the number of Bollywood movies
SELECT COUNT(*) FROM movies WHERE industry LIKE 'bollywood';

-- Find the maximum and minimum IMDb ratings
SELECT MAX(imdb_rating) AS max_rating, MIN(imdb_rating) AS min_rating FROM movies;

-- Average IMDb rating for movies by studio
SELECT ROUND(AVG(imdb_rating), 2) AS avg_rating FROM movies WHERE studio = "Hombale Films";

-- Count movies by studio and order by count
SELECT studio, COUNT(*) AS cnt FROM movies GROUP BY studio ORDER BY cnt DESC;

-- Number of movies released by industry, with average rating
SELECT industry, COUNT(industry) AS cnt, ROUND(AVG(imdb_rating), 2) AS avg_rating FROM movies GROUP BY industry;

-- Profit Percentage Calculation
SELECT m.title, f.budget, f.revenue, 
ROUND(((f.revenue - f.budget) / f.budget) * 100, 0) AS profit_Percentage
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id;

-- Revenue calculations in INR
SELECT *, IF(currency = 'usd', revenue * 86, revenue) AS revenue_inr 
FROM financials;

-- Case Statements for revenue calculations (millions)
SELECT *, CASE 
    WHEN unit = "billions" THEN revenue * 1000 
    WHEN unit = "thousands" THEN revenue / 1000 
    ELSE revenue 
END AS revenue_mln 
FROM financials;

-- INNER JOIN to get movie details with financial data
SELECT m.movie_id, m.title, f.budget, f.revenue, currency, unit
FROM movies m
INNER JOIN financials f ON m.movie_id = f.movie_id;

-- LEFT JOIN to include all movies even without financial data
SELECT m.movie_id, title, f.budget, f.revenue, currency, unit
FROM movies m
LEFT JOIN financials f ON m.movie_id = f.movie_id;

-- RIGHT JOIN to include all records from the financial table
SELECT f.movie_id, title, budget, revenue, currency, unit
FROM movies m
RIGHT JOIN financials f ON m.movie_id = f.movie_id;

-- Profit calculation considering units
SELECT m.movie_id, title, budget, revenue, currency, unit, 
CASE 
    WHEN unit = "thousands" THEN ROUND((revenue - budget) / 1000, 0)
    WHEN unit = "billions" THEN ROUND((revenue - budget) * 1000, 0)
    ELSE ROUND((revenue - budget), 0)
END AS Profit_mln
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id
ORDER BY Profit_mln DESC;

-- List of actors and the movies they have starred in
SELECT m.title, GROUP_CONCAT(a.name SEPARATOR " | ") AS actors
FROM movies m
JOIN movie_actor ma ON m.movie_id = ma.movie_id
JOIN actors a ON a.actor_id = ma.actor_id
GROUP BY m.movie_id;

-- Movies by language (Hindi), sorted by revenue
SELECT m.title, f.revenue, f.currency, f.unit,
CASE WHEN unit = "Thousands" THEN ROUND(revenue / 1000, 1) 
     WHEN unit = "billions" THEN ROUND(revenue * 1000, 1) 
     ELSE ROUND(revenue, 1) 
END AS Revenue_mln 
FROM movies m 
JOIN financials f ON f.movie_id = m.movie_id 
JOIN languages l ON l.language_id = m.language_id 
WHERE l.name = "hindi" 
ORDER BY Revenue_mln DESC;

-- Find the movie(s) with the highest and lowest IMDb ratings
SELECT * FROM movies WHERE imdb_rating = (SELECT MAX(imdb_rating) FROM movies);
SELECT * FROM movies WHERE imdb_rating = (SELECT MIN(imdb_rating) FROM movies);

-- Movies with higher IMDb ratings than average
SELECT * FROM movies WHERE imdb_rating > (SELECT AVG(imdb_rating) FROM movies);

-- Select all movies with minimum and maximum release_year
SELECT title FROM movies 
WHERE release_year = (SELECT MAX(release_year) FROM movies) 
   OR release_year = (SELECT MIN(release_year) FROM movies);

-- Sales data queries
SELECT * FROM fact_sales_monthly 
WHERE customer_code = '90002002' AND YEAR(DATE_ADD(date, INTERVAL 4 MONTH))
ORDER BY date DESC;

SELECT s.date, s.product_code, p.product, p.variant, s.sold_quantity, g.gross_price,
s.sold_quantity * g.gross_price AS Gross_price_total
FROM fact_sales_monthly s 
JOIN dim_product p ON s.product_code = p.product_code 
JOIN fact_gross_price g ON g.product_code = s.product_code 
  AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = '90002002' AND YEAR(DATE_ADD(date, INTERVAL 4 MONTH)) = 2021
ORDER BY date DESC;

SELECT s.date, SUM(s.sold_quantity * g.gross_price) AS Gross_price_total 
FROM fact_sales_monthly s 
JOIN fact_gross_price g ON g.product_code = s.product_code 
  AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002 
GROUP BY s.date
ORDER BY s.date ASC;

SELECT g.fiscal_year, SUM(s.sold_quantity * g.gross_price) AS Gross_price_total 
FROM fact_sales_monthly s 
JOIN fact_gross_price g ON g.product_code = s.product_code 
  AND g.fiscal_year = get_fiscal_year(s.date)
WHERE customer_code = 90002002 
GROUP BY g.fiscal_year
ORDER BY g.fiscal_year ASC;
