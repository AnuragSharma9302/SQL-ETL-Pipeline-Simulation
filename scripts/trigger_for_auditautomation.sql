-- Log inserts automatically
CREATE OR REPLACE FUNCTION log_insert() RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO audit_log (table_name, event, rows_affected, details)
  VALUES (TG_TABLE_NAME, 'ROW_INSERT', 1, 'Inserted into ' || TG_TABLE_NAME);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_customers_insert AFTER INSERT ON customers
FOR EACH ROW EXECUTE FUNCTION log_insert();

CREATE TRIGGER trg_orders_insert AFTER INSERT ON orders
FOR EACH ROW EXECUTE FUNCTION log_insert();

CREATE TRIGGER trg_products_insert AFTER INSERT ON products
FOR EACH ROW EXECUTE FUNCTION log_insert();
