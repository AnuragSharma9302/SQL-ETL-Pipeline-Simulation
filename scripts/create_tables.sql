-- (A) Staging Tables — raw data

DROP TABLE IF EXISTS staging_sales CASCADE;

CREATE TABLE staging_sales (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity TEXT,
    InvoiceDate TEXT,
    UnitPrice TEXT,
    CustomerID TEXT,
    Country TEXT,
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- (B) Production Tables — cleaned and structured
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS audit_log CASCADE;

-- Customer table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    country TEXT
);

-- Product table
CREATE TABLE products (
    product_code TEXT PRIMARY KEY,
    description TEXT
);

-- Order table
CREATE TABLE orders (
    invoice_no TEXT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order items table
CREATE TABLE order_items (
    invoice_no TEXT,
    product_code TEXT,
    quantity INT,
    unit_price NUMERIC,
    line_total NUMERIC,
    FOREIGN KEY (invoice_no) REFERENCES orders(invoice_no)
);

-- Audit log
CREATE TABLE audit_log (
    audit_id SERIAL PRIMARY KEY,
    table_name TEXT,
    event TEXT,
    rows_affected INT,
    details TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
