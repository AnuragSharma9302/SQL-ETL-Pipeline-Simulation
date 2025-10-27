-- 1. Load unique customers
INSERT INTO customers (customer_id, country)
SELECT DISTINCT customer_id, country
FROM cleaned_sales
WHERE customer_id IS NOT NULL
ON CONFLICT (customer_id) DO NOTHING;

-- 2. Load unique products
INSERT INTO products (product_code, description)
SELECT DISTINCT product_code, description
FROM cleaned_sales
WHERE product_code IS NOT NULL
ON CONFLICT (product_code) DO NOTHING;

-- 3. Load orders
INSERT INTO orders (invoice_no, customer_id, order_date, total_amount)
SELECT
    invoice_no,
    customer_id,
    invoice_date,
    SUM(quantity * unit_price) AS total_amount
FROM cleaned_sales
GROUP BY invoice_no, customer_id, invoice_date
ON CONFLICT (invoice_no) DO NOTHING;

-- 4. Load order items
INSERT INTO order_items (invoice_no, product_code, quantity, unit_price, line_total)
SELECT
    invoice_no,
    product_code,
    quantity,
    unit_price,
    quantity * unit_price AS line_total
FROM cleaned_sales
ON CONFLICT DO NOTHING;

-- 5. Log the inserts
INSERT INTO audit_log (table_name, event, rows_affected, details)
VALUES
('customers', 'INSERT', (SELECT COUNT(*) FROM customers), 'Loaded customers'),
('products', 'INSERT', (SELECT COUNT(*) FROM products), 'Loaded products'),
('orders', 'INSERT', (SELECT COUNT(*) FROM orders), 'Loaded orders'),
('order_items', 'INSERT', (SELECT COUNT(*) FROM order_items), 'Loaded order items');
