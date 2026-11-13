-- 1. Executive KPI Summary
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct
FROM sales;

-- 2. Revenue & Profit Margin by Category
SELECT 
    category,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS margin_pct
FROM sales
GROUP BY category
ORDER BY total_profit DESC;

-- 3. Regional Performance Breakdown
SELECT 
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS margin_pct
FROM sales
GROUP BY region
ORDER BY total_profit DESC;

-- 4. Bottom 5 Sub-Categories by Profit (Loss-Makers)
SELECT 
    category,
    sub_category,
    ROUND(AVG(discount) * 100, 1) AS avg_discount_pct,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales
GROUP BY category, sub_category
ORDER BY total_profit ASC
LIMIT 5;