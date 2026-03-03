SELECT * 
FROM `bigquery-public-data.iowa_liquor_sales.sales` LIMIT 1000;

--Yearly Revenue Ranking by Product Category
WITH yearly_category_sales AS (
  SELECT
    EXTRACT(YEAR FROM date) AS sales_year,
    category_name,
    SUM(sale_dollars) AS total_revenue,
    SUM(bottles_sold) AS total_bottles_sold
  FROM `bigquery-public-data.iowa_liquor_sales.sales`
  WHERE date >= '2018-01-01'
  GROUP BY sales_year, category_name
),

ranked_categories AS (
  SELECT
    sales_year,
    category_name,
    total_revenue,
    total_bottles_sold,
    RANK() OVER (
      PARTITION BY sales_year
      ORDER BY total_revenue DESC
    ) AS revenue_rank
  FROM yearly_category_sales
)

SELECT *
FROM ranked_categories
WHERE revenue_rank <= 10
ORDER BY sales_year DESC, revenue_rank;