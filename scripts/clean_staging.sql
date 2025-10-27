-- Convert columns to correct types, remove bad data
CREATE TABLE cleaned_sales AS
SELECT
    TRIM(InvoiceNo) AS invoice_no,
    TRIM(StockCode) AS product_code,
    INITCAP(TRIM(Description)) AS description,
    CAST(Quantity AS INT) AS quantity,
    TO_TIMESTAMP(InvoiceDate, 'MM/DD/YY HH24:MI')::DATE AS invoice_date,
    CAST(UnitPrice AS NUMERIC(10,2)) AS unit_price,
    CAST(CustomerID AS INT) AS customer_id,
    INITCAP(TRIM(Country)) AS country
FROM staging_sales
WHERE
    Quantity ~ '^[0-9]+$'
    AND UnitPrice ~ '^[0-9]+(\.[0-9]+)?$'
    AND CustomerID IS NOT NULL
    AND InvoiceNo IS NOT NULL;
