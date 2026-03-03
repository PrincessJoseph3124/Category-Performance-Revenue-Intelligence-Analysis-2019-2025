**Category Performance & Revenue Intelligence Dashboard (2019–2025)**

**Business Problem / Objective**

A beverage distribution business needs to understand long-term revenue performance, category contribution, and growth sustainability across multiple years.

The business requires clear visibility into:

- How total revenue and sales volume trend over time

- Which product categories drive the highest revenue

- How revenue is distributed across categories (market share)

- Whether growth is accelerating or slowing

- Where revenue concentration may introduce risk

This project answers the core strategic question:

How sustainable is revenue growth, and how dependent is the business on a small group of top-performing categories?

**Dataset Overview**

Data Source: BigQuery Public Dataset (Iowa Liquor Sales)

Storage & Query Engine: Google BigQuery

Time Period Covered: 2019 – 2025

Geography: Iowa, United States

Grain Level: Transaction-level liquor sales

**Key Columns in the Dataset**

- invoice_and_item_number

- date

- store_number

- store_name

- city

- county

- category

- category_name

- vendor_name

- bottles_sold

- sale_dollars

- volume_sold_liters

**Tools Used**

Google BigQuery – Data extraction, aggregation, and transformation

![](Yearly_Revenue_Ranking_by_Product.sql)

![](Yearly_Revenue_Ranking_by_Product.sql)

![](Yearly_Revenue_Ranking_by_Product.sql)

SQL (CTEs, Aggregations, Window Functions) – Data modeling logic

![](Yearly_Revenue_Ranking_by_Product.sql)

Tableau Public – Dashboard design and visualization

Tableau Calculations – LOD Expressions and Table Calculations

Data Extraction & Transformation (BigQuery)

The raw transactional dataset was transformed using SQL CTEs to create structured analytical outputs.

**Key transformations included:**

- Extracting Sales Year from date

- Aggregating total revenue by category and year

- Calculating total bottles sold

- Computing average revenue per bottle

- Structuring yearly revenue for YoY analysis

**Example SQL logic structure:**

WITH yearly_sales AS (SELECT 
EXTRACT(YEAR FROM date) AS sales_year,
category_name,
SUM(sale_dollars) AS total_revenue,
SUM(bottles_sold) AS total_bottles
FROM `bigquery-public-data.iowa_liquor_sales.sales`
WHERE EXTRACT(YEAR FROM date) BETWEEN 2019 AND 2025
GROUP BY sales_year, category_name)

SELECT *
FROM yearly_sales
ORDER BY sales_year, total_revenue DESC;

**Data Modeling & Analytical Calculations (Tableau)**

After connecting Tableau directly to BigQuery, additional calculated fields were created:

- Core Metrics

- Total Revenue = SUM(sale_dollars)

- Total Bottles Sold = SUM(bottles_sold)

- Average Revenue per Bottle = SUM(sale_dollars) / SUM(bottles_sold)

- Revenue Contribution Percentage (Market Share)
SUM([sale_dollars]) / SUM({FIXED : SUM([sale_dollars])})

This Level of Detail (LOD) calculation ensures proper partitioning across categories.

- Year over Year Growth
(SUM([sale_dollars]) - LOOKUP(SUM([sale_dollars]), -1)) 
/ ABS(LOOKUP(SUM([sale_dollars]), -1))

This table calculation dynamically compares current year revenue to prior year revenue.

**Key Questions & Analysis**

- Which categories generate the highest revenue?

- How has revenue trended from 2019 to 2025?

- What is the Year over Year growth pattern?

- Is revenue concentrated among a small number of categories?

- Is growth accelerating, stabilizing, or contracting?

**Key Insights**

- Total revenue reached $2.12B across the analyzed period.

- Revenue peaked in 2024 before declining by approximately 4% in 2025.

- A small group of top-performing categories contributes a disproportionately large share of total revenue.

- High revenue concentration suggests potential category dependency risk.

- Growth momentum slowed after 2023, indicating possible market saturation or structural shifts.

**Dashboard Structure**

The Tableau dashboard includes:

**KPI Section**

- Total Revenue

- Total Bottles Sold

- Average Revenue per Bottle

- Category Analysis

- Top Categories by Revenue (Bar Chart)

- Revenue Contribution Percentage (Market Share Bar Chart)

- Time Series Analysis

- Revenue Trend by Year

- Dual Axis: Revenue Trend and Year over Year Growth

**Filters Included:**

- -Sales Year

- Category Name

**Dashboard Preview**

![](images/Category_Performance_&_Revenue_Intelligence_Dashboard_(2019-2025).png)

**Interactive Dashboard Link:**

https://public.tableau.com/views/CategoryPerformanceRevenueIntelligenceDashboard20192025/CategoryPerformanceRevenueIntelligenceDashboard2019-2025

**Strategic Recommendations**

- Diversify revenue streams to reduce category concentration risk

- Monitor post-2024 contraction for sustained decline

- Identify emerging categories with growth potential

- Investigate whether price optimization could improve revenue per bottle

- Conduct deeper regional or store-level analysis for granular insight

**Conclusion**

This project demonstrates how transactional data can be transformed into executive-level strategic insights using SQL and Tableau.

By combining:

- Structured SQL transformations

- Market share analysis

- Time-series trend modeling

- Growth rate calculations

The dashboard provides decision-makers with a comprehensive view of revenue sustainability and structural risk exposure.
