-- =====================================================
-- 🧮 ETL Validation Queries - PostgreSQL
-- =====================================================

-- 1️⃣ ROW COUNT & DATA VOLUME CHECKS
-----------------------------------------------------
SELECT (SELECT COUNT(*) FROM staging_sales) AS staging_count,
       (SELECT COUNT(*) FROM orders) AS orders_count,
       (SELECT COUNT(*) FROM order_items) AS order_items_count;

SELECT (SELECT COUNT(DISTINCT customer_id) FROM customers) AS unique_customers,
       (SELECT COUNT(DISTINCT product_code) FROM products) AS unique_products;


-- 2️⃣ DATA COMPLETENESS & NULL CHECKS
-----------------------------------------------------
SELECT * FROM orders WHERE customer_id IS NULL;
SELECT oi.* FROM order_items oi
LEFT JOIN orders o ON oi.invoice_no = o.invoice_no
WHERE o.invoice_no IS NULL;

SELECT COUNT(*) AS null_total_amount
FROM orders
WHERE total_amount IS NULL OR total_amount = 0;

SELECT COUNT(*) AS null_products
FROM products
WHERE description IS NULL OR description = '';


-- 3️⃣ REFERENTIAL INTEGRITY VERIFICATION
-----------------------------------------------------
SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o ON oi.invoice_no = o.invoice_no
WHERE o.invoice_no IS NULL;

SELECT COUNT(*) AS inactive_customers
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT COUNT(*) AS empty_orders
FROM orders o
LEFT JOIN order_items oi ON o.invoice_no = oi.invoice_no
WHERE oi.invoice_no IS NULL;


-- 4️⃣ DATA ACCURACY & TRANSFORMATION VALIDATION
-----------------------------------------------------
SELECT o.invoice_no, 
       o.total_amount, 
       SUM(oi.line_total) AS computed_total,
       o.total_amount - SUM(oi.line_total) AS difference
FROM orders o
JOIN order_items oi ON o.invoice_no = oi.invoice_no
GROUP BY o.invoice_no, o.total_amount
HAVING o.total_amount <> SUM(oi.line_total);

SELECT * FROM order_items WHERE quantity <= 0;
SELECT * FROM orders WHERE order_date > CURRENT_DATE;


-- 5️⃣ DISTRIBUTION & STATISTICAL CHECKS
-----------------------------------------------------
SELECT c.customer_id, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

SELECT p.description, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_code = p.product_code
GROUP BY p.description
ORDER BY total_sold DESC
LIMIT 10;

SELECT DATE_TRUNC('month', order_date) AS month, 
       SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

SELECT c.country, SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 10;


-- 6️⃣ AUDIT & ETL LOGGING CHECKS
-----------------------------------------------------
SELECT status, COUNT(*) 
FROM audit_log 
GROUP BY status;

SELECT DATE(created_at) AS load_date, COUNT(*) AS records_processed
FROM audit_log
GROUP BY DATE(created_at)
ORDER BY load_date DESC;

SELECT * 
FROM audit_log 
ORDER BY created_at DESC 
LIMIT 1;


-- 7️⃣ PERFORMANCE & OPTIMIZATION CHECKS
-----------------------------------------------------
SELECT table_name, 
       (xpath('/row/c/text()', query_to_xml(format('SELECT COUNT(*) AS c FROM %I', table_name), false, true, '')))[1]::text::int AS row_count
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY row_count DESC;

SELECT relname AS table, 
       idx_scan AS index_scans, 
       seq_scan AS sequential_scans
FROM pg_stat_user_tables
ORDER BY seq_scan DESC;


-- 8️⃣ DATA UNIQUENESS CHECKS
-----------------------------------------------------
SELECT invoice_no, COUNT(*) 
FROM orders 
GROUP BY invoice_no 
HAVING COUNT(*) > 1;

SELECT product_code, COUNT(*) 
FROM products 
GROUP BY product_code 
HAVING COUNT(*) > 1;


-- 9️⃣ ETL QUALITY SUMMARY REPORT
-----------------------------------------------------
SELECT
    (SELECT COUNT(*) FROM staging_sales) AS staging_records,
    (SELECT COUNT(*) FROM orders) AS orders_records,
    (SELECT COUNT(*) FROM order_items) AS order_items_records,
    (SELECT COUNT(DISTINCT customer_id) FROM customers) AS unique_customers,
    (SELECT COUNT(DISTINCT product_code) FROM products) AS unique_products,
    (SELECT COUNT(*) FROM order_items WHERE quantity <= 0) AS invalid_quantities,
    (SELECT COUNT(*) FROM orders WHERE total_amount IS NULL OR total_amount <= 0) AS invalid_amounts;
