/* =====================================================================
   DATA QUALITY & VALIDATION CHECKS
   Before any analysis is trusted, the underlying data needs to be validated:
   referential integrity, header-to-detail reconciliation, duplicate
   detection, and compliance checks on marketing consent.
   ===================================================================== */

-- 1. Orphaned orders: orders referencing a customer_id that doesn't exist
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 2. Orphaned order lines: lines referencing a product_id that doesn't exist
SELECT ol.order_line_id, ol.product_id
FROM order_lines ol
LEFT JOIN products p ON ol.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 3. Reconciliation: does order_total match the sum of its order_lines?
SELECT
    o.order_id,
    o.order_total AS header_total,
    ROUND(SUM(ol.line_total), 2) AS calculated_total,
    ROUND(o.order_total - SUM(ol.line_total), 2) AS variance
FROM orders o
JOIN order_lines ol ON o.order_id = ol.order_id
GROUP BY o.order_id, o.order_total
HAVING ABS(o.order_total - SUM(ol.line_total)) > 0.01;

-- 4. Duplicate customers by name + branch (potential duplicate accounts)
SELECT customer_name, branch, COUNT(*) AS cnt
FROM customers
GROUP BY customer_name, branch
HAVING COUNT(*) > 1;

-- 5. Campaign sends to customers who did not opt in (consent/compliance check)
SELECT cs.send_id, cs.campaign_id, c.customer_id, c.email_opt_in, c.sms_opt_in, camp.channel
FROM campaign_sends cs
JOIN customers c ON cs.customer_id = c.customer_id
JOIN campaigns camp ON cs.campaign_id = camp.campaign_id
WHERE (camp.channel = 'Email' AND c.email_opt_in = false)
   OR (camp.channel = 'SMS' AND c.sms_opt_in = false);

-- 6. Null / blank checks across key fields
SELECT
    SUM(CASE WHEN customer_name IS NULL OR TRIM(customer_name) = '' THEN 1 ELSE 0 END) AS blank_names,
    SUM(CASE WHEN branch IS NULL OR TRIM(branch) = '' THEN 1 ELSE 0 END) AS blank_branch,
    SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS blank_signup
FROM customers;
