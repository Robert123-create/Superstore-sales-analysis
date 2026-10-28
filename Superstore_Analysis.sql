-- ===================================================
-- PROJECT:SUPERSTORE SALES PERFORMANCE ANALYSIS
-- Database:money
-- Table:superstore
-- Tools:postgreSQL and pgAdmin 4
--
-- OBJECTIVES:
-- 1.Validate data quality.
-- 2.Analyse sales and profitability.
-- 3.Compare product categories and regions.
-- 4.Identify top customers and products.
-- 5.Analyse monthly sales trends.
-- 6.Apply advanced SQL techniques.
-- ====================================================

-- SECTION 1:DATA PREVIEW
SELECT *
FROM superstore
LIMIT 10;

-- SECTION 2: BASIC DATA VALIDATION
SELECT
    COUNT(*) AS total_records,
	COUNT(DISTINCT row_id) AS unique_row_ids,
	COUNT(DISTINCT order_id) AS unique_orders,
	COUNT(DISTINCT customer_id) AS unique_customers
	FROM superstore;

	--SECTION 3: DUPLICATE ROW ID CHECK
	SELECT
	row_id,
	COUNT(*) AS occurences
	FROM superstore
	GROUP BY row_id
	HAVING COUNT(*)>1
	ORDER BY occurences DESC;
	--FINDING:
	-- No duplicate row_id values were found.
	-- All 10,194 row IDs are unique.

	-- SECTION 4: MISSING VALUE CHECK
	SELECT
	COUNT(*) FILTER (WHERE row_id IS NULL) AS missing_row_ids,
	COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_ids,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_row_ids,
	COUNT(*) FILTER (WHERE order_date_clean IS NULL) AS missing_order_dates,
	COUNT(*) FILTER (WHERE ship_date_clean IS NULL) AS missing_ship_dates,
	COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
	COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
	FROM superstore;

	-- SECTION 5: ORDER AND SHIPPING DATE VALIDATION
	SELECT
	COUNT(*) AS total_records,
	COUNT(*) FILTER (
      WHERE order_date_clean > ship_date_clean
	) AS shipping_before_order,
	COUNT(*) FILTER (
      WHERE shipping_delays < 0
	) AS negative_shipping_delays
	FROM superstore;
	-- FINDINGS:
	-- A total of 10,194 records were checked.
	-- No orders had shipping dates earlier than their order dates.
	-- No negative shipping delays were found.

	-- ===========================================================
	-- SECTION 6: OVERALL BUSINESS KPIs
	-- ===========================================================
	SELECT
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit,
	COUNT(DISTINCT order_id) AS total_orders,
	COUNT(DISTINCT customer_id) AS total_customers
	FROM superstore;
	-- FINDINGS:
	-- Total sales: 2,326,534.52
    -- Total profit: 292,297.57
	-- Total orders: 5,111
	-- Total customers: 804
	-- These results match the Power BI dashboard.

	-- ===================================================
	-- SECTION 7: SALES AND PROFIT BY PRODUCT CATEGORY
	-- ===================================================
	SELECT
	category,
	SUM(sales) AS total_sales,
	SUM(profit) AS toatl_profit,
	ROUND(
(SUM(profit)/NULLIF(SUM(sales),0))*100,2
	) AS profit_margin_percentage
	FROM superstore
	GROUP BY category
	ORDER BY total_sales DESC;
	-- FINDINDINGS:
	-- Technology generated the highest sales at 839,893.35.
	-- Ofiice Supplies generated sales of 731,893.23.
	-- Furniture generated sales of 754,747.94.
	-- Technology had the highest profit at 146,544.09.
	-- Furniture had the lowest profit at 19,729.94.
	-- Technology had the highest profit margin at 17.45%.
	-- Furniture had the lowest profit margin at 2.61%

	--===================================================
	-- SECTION 8: SALES AND PROFIT  BY BREGION
	-- ==================================================
	SELECT
	region,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY region
	ORDER BY total_sales DESC;
	-- FINDINGS:
	-- West generated the highest sales.
	-- East ranked second in total sales.
	-- Centtral ranked third in total sales.
	-- South recorded the lowest sales.
	-- South generated more profit than Central despite having lower sales.

	-- ==================================================================
	-- SECTION 9: MONTHLY SALES ANALYSIS
	-- ==================================================================
	SELECT
	EXTRACT(MONTH FROM order_date_clean) AS month_number,
	TO_CHAR(order_date_clean,'Month') AS month_name,
	SUM(sales) AS total_sales
	FROM superstore
	GROUP BY
	EXTRACT(MONTH FROM order_date_clean),
	TO_CHAR(order_date_clean,'Month')
	ORDER BY month_number;
	-- FINDINGS:
	-- Monthly sales were calculated for January through December.
	-- November recorded the highest monthly sales at 352,666.01.
	-- February recorded the lowest monthly sales at 59,751.26
	-- Monthly sales were ordered chronologically.

	-- =================================================================
	-- SECTION 10: TOP 10 PRODUCTS BY SALES
	-- =================================================================
	SELECT
	product_name,
	SUM(sales) AS total_sales
	FROM superstore
	GROUP BY product_name
	ORDER BY total_sales DESC
	LIMIT 10;
	-- FINDINGS:
	-- Canon imageCLASS 2200 Advanced Copier ranked first
	-- in total_sales generating 61,599.83
	-- The query identifies the 10 highest-selling products. 

	-- =================================================================
	-- SECTION 11: TOP 10 PRODUCTS BY PROFIT
	-- =================================================================
	SELECT
	product_name,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY product_name
	ORDER BY total_profit DESC
	LIMIT 10;
	-- FINDINGS:
	-- Canon imageCLASS 2200 Advanced Copier ranked first
	-- in total_profit generating 25,199.94
	-- The query identifies the 10 most profitable products.

	-- =================================================================
	-- SECTION 11: TOP 10 PRODUCTS BY PROFIT
	-- =================================================================
	SELECT
	product_name,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY product_name
	ORDER BY total_profit DESC
	LIMIT 10;
	-- FINDINGS:
	-- Canon imageCLASS 2200 Advanced Copier ranked first
	-- in total_profit generating 25,199.94
	-- The query identifies the 10 most profitable products.

	-- =================================================================
	-- SECTION 12: SALES AND PROFIT BY CUSTOMER SEGMENT
	-- =================================================================
	SELECT
	segment,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY segment
	ORDER BY total_sales DESC;
	-- FINDINGS:
	-- Consumer generated the highest sales at 1,170,659.75.
	-- Corporate ranked second in sales at 715,806.20.
    -- Home Office recorded the lowest sales at 440,068.57.
	-- Consumer generated the highest profit at 136,371.58.
	-- Home Office generated the lowest profit at 61,676.08.
	-- Consumer was the largest segment by both sales and profit.

	-- =================================================================
	-- SECTION 13: TOP 10 CUSTOMERS BY SALES
	-- =================================================================
	SELECT
	 customer_id,
	 customer_name,
	 SUM(sales) AS total_sales,
	 SUM(profit) AS total_profit
	 FROM superstore
	 GROUP BY
	 customer_id,
	 customer_name
	 ORDER BY total_sales DESC 
	 LIMIT 10;
	-- FINDINGS:
	-- Sean Miller ranked first by total customer sales.
	-- Total sales associated with this customer were 25,043.07.
	-- The customer generated a total loss of 1,980.75.
	-- High customer sales do not necessarily guarantee profitability.

	-- =================================================================
	-- SECTION 14: TOP 10 CUSTOMERS BY PROFIT
	-- =================================================================
	SELECT
	 customer_id,
	 customer_name,
	 SUM(sales) AS total_sales,
	 SUM(profit) AS total_profit
	 FROM superstore
	 GROUP BY
	 customer_id,
	 customer_name
	 ORDER BY total_profit DESC 
	 LIMIT 10;
	 -- FINDINGS:
	-- Tamara Chand ranked first by total profit.
	-- Total profit associated with this customer was 8981.32.
	-- The query identifies the 10 most profitable customers.

	-- =================================================================
	-- SECTION 15: SALES AND PROFIT BY SHIP MODE
	-- =================================================================
	SELECT
	ship_mode,
	COUNT(DISTINCT order_id) AS total_orders,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY ship_mode
	ORDER BY total_sales DESC;
	-- FINDINGS:
	-- Standard Class ranked first by total sales.
	-- It accounted for 3,068 distinct orders.
	-- Total sales were 1,378,840.86.
	-- Total profit was 168,161.84

	-- =================================================================
	-- SECTION 16: RANK PRODUCT CATEGORIES BY PROFIT MARGIN.
	-- =================================================================
    SELECT
	category,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit,
	ROUND(
   SUM(profit)/NULLIF(SUM(sales),0)*100,2
	) AS profit_margin_percentage
	FROM superstore
	GROUP BY category
	ORDER BY profit_margin_percentage DESC;
	-- FINDINGS:
	-- Technology ranked first by profit margin at approximately 17.45%.
	-- Office Supplies ranked second at approximately 17.22%.
	-- Furniture ranked last at approximately 2.61%.
	-- Furniture requires further investigation because of its low profit margin.

	-- =================================================================
	-- SECTION 17: ORDERS AND SALES BY YEAR
	-- =================================================================
	SELECT 
	EXTRACT(YEAR FROM order_date_clean) AS order_year,
	COUNT(DISTINCT order_id) AS total_orders,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY EXTRACT(YEAR FROM order_date_clean)
	ORDER BY order_year;
	-- FINDINGS:
	--2023: 995 orders,sales of 494,040.27,
    -- and profit of 51,684.38
	-- 2024: 1,053 orders,sales of 472,992.98,
	-- and profit of 62,021.03
	--2025: 1,340 orders,sales of 613,933.83,
	-- and profit of 82,665.31
	--2026: 1,723 orders,sales of 745,567.44,
	-- and profit of 95,926.85
	-- The totals reconcile with the overall project KPIs.

	-- =================================================================
	-- SECTION 18: SALES AND PROFIT BY STATE
	-- =================================================================
	SELECT
	state,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY state
	ORDER BY total_sales DESC
	LIMIT 10;
	-- FINDINGS:
	-- California ranked first among the states by total sales.
	-- Total sales in California were 457,687.68
	-- The query identifies the 10 highest selling states.

	-- =================================================================
	-- SECTION 19: SALES AND PROFIT BY CITY
	-- =================================================================
	SELECT
	city,
	SUM(sales) AS total_sales,
	SUM(profit) AS total_profit
	FROM superstore
	GROUP BY city
	ORDER BY total_sales DESC
	LIMIT 10;
	-- FINDINGS:
	-- New York City ranked first among cities by total sales.
	-- Total sales in New York City were 256,368.12
	-- The query identifies the 10 highest selling cities.

	-- =================================================================
	-- SECTION 20: SHIPPING DELAY ANALYSIS
	-- =================================================================
	SELECT
	ROUND(AVG(shipping_delays),2) AS average_shipping_delay,
	MIN(shipping_delays) AS minimum_shipping_delay,
	MAX(shipping_delays) AS maximum_shipping_delay,
	COUNT(*) FILTER(
      WHERE shipping_delays IS NULL
	) AS missing_shipping_delays
	FROM superstore;
	-- FINDINGS:
	-- Average shipping delay was 3.96 days.
	-- Minimum recorded shipping delay was 0 days.
	-- Maximum recorded sipping delay was 11 days.
	-- No shipping delay values were missing.
	 

	

	

	

	
	

	
	



	


	

	
	
	
	
	
	
	
	
	