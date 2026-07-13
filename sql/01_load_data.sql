-- =====================================================================
-- Load CSV data into the PostgreSQL tables.
-- Run AFTER 00_create_schema.sql
--
-- IMPORTANT: Run this with psql from the folder containing the CSVs, e.g:
--   cd portfolio_project/data
--   psql -d stark_portfolio -f ../sql_postgres/01_load_data.sql
--
-- \copy (not COPY) is used so it works from the psql client without
-- needing server-side file permissions - it reads files from YOUR machine.
-- =====================================================================

\copy customers FROM 'customers.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy products FROM 'products.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy orders FROM 'orders.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy order_lines FROM 'order_lines.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy campaigns FROM 'campaigns.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy campaign_sends FROM 'campaign_sends.csv' WITH (FORMAT csv, HEADER true, NULL '')
\copy nps_responses FROM 'nps_responses.csv' WITH (FORMAT csv, HEADER true, NULL '')

-- Quick sanity check row counts after load
SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_lines', COUNT(*) FROM order_lines
UNION ALL SELECT 'campaigns', COUNT(*) FROM campaigns
UNION ALL SELECT 'campaign_sends', COUNT(*) FROM campaign_sends
UNION ALL SELECT 'nps_responses', COUNT(*) FROM nps_responses;
