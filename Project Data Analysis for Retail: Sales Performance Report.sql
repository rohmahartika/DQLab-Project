-- Overall Performance by Year
SELECT year(order_date) as years, ROUND(SUM(sales),2) as sales, COUNT(distinct order_id) as number_of_order 
FROM dqlab_sales_store 
WHERE order_status = 'Order Finished' 
GROUP BY year(order_date);
 
-- Overall Performance by Product Sub Category
SELECT year(order_date) AS years, product_sub_category, SUM(sales) AS sales
FROM dqlab_sales_store
WHERE order_status = 'Order Finished' AND year(order_date) in (2011,2012)
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;
 
-- Promotion Effectiveness and Efficiency by Years
SELECT year(order_date) as years, SUM(sales) as sales, SUM(discount_value) as promotion_value, ROUND(SUM(discount_value)/SUM(sales)*100,2) as burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY year(order_date);
 
-- Promotion Effectiveness and Efficiency by Product Sub Category
SELECT year(order_date) as years, product_sub_category, product_category, sum(sales) as sales, sum(discount_value) as promotion_value, round(sum(discount_value)/sum(sales)*100,2) as burn_rate_percentage
FROM dqlab_sales_store
WHERE year(order_date) = '2012' AND order_status = 'Order Finished'
GROUP BY year (order_date), product_sub_category, product_category
ORDER BY sales DESC;

-- Customers Transactions per Year
SELECT year(order_date) as years, count(distinct customer) as number_of_customer
FROM dqlab_sales_store 
WHERE order_status = 'Order Finished' 
GROUP BY year(order_date);

 
