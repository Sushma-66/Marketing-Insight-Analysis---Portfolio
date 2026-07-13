/* =====================================================================
   BUSINESS ANALYSIS QUERIES (PostgreSQL version)
   Same logic as the SQLite version. Key differences:
   - No text-to-number CAST needed (columns are NUMERIC/INTEGER natively)
   - Date math uses native DATE subtraction instead of JULIANDAY()
   - Month trend uses TO_CHAR() instead of STRFTIME()
   ===================================================================== */

-- 1. Revenue and margin by customer type
SELECT
    c.customer_type,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(ol.quantity * ol.unit_price), 2) AS revenue,
    ROUND(SUM(ol.quantity * (ol.unit_price - p.unit_cost)), 2) AS gross_margin,
    ROUND(100.0 * SUM(ol.quantity * (ol.unit_price - p.unit_cost))
          / NULLIF(SUM(ol.quantity * ol.unit_price), 0), 1) AS margin_pct
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_lines ol ON o.order_id = ol.order_id
JOIN products p ON ol.product_id = p.product_id
GROUP BY c.customer_type
ORDER BY revenue DESC;

-- 2. Revenue by branch and product category
SELECT
    o.branch,
    p.category,
    ROUND(SUM(ol.quantity * ol.unit_price), 2) AS revenue
FROM orders o
JOIN order_lines ol ON o.order_id = ol.order_id
JOIN products p ON ol.product_id = p.product_id
GROUP BY o.branch, p.category
ORDER BY o.branch, revenue DESC;

-- 3. RFM-style customer segmentation
--    Reference date = 2026-07-07 ("today" for this project)
WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_type,
        MAX(o.order_date) AS last_order_date,
        COUNT(o.order_id) AS frequency,
        ROUND(SUM(o.order_total), 2) AS monetary
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.customer_type
)
SELECT
    customer_id,
    customer_name,
    customer_type,
    frequency,
    monetary,
    (DATE '2026-07-07' - last_order_date) AS recency_days,
    CASE
        WHEN last_order_date IS NULL THEN 'Never purchased'
        WHEN (DATE '2026-07-07' - last_order_date) <= 90 AND frequency >= 10 THEN 'Champion'
        WHEN (DATE '2026-07-07' - last_order_date) <= 180 AND frequency >= 5 THEN 'Loyal'
        WHEN (DATE '2026-07-07' - last_order_date) > 365 THEN 'At Risk / Dormant'
        ELSE 'Developing'
    END AS segment
FROM customer_orders
ORDER BY monetary DESC;

-- 4. Campaign performance: open rate, click rate, conversion rate, ROI
SELECT
    camp.campaign_name,
    camp.channel,
    camp.target_segment,
    camp.campaign_cost,
    COUNT(cs.send_id) AS sends,
    SUM(CASE WHEN cs.opened THEN 1 ELSE 0 END) AS opens,
    SUM(CASE WHEN cs.clicked THEN 1 ELSE 0 END) AS clicks,
    SUM(CASE WHEN cs.converted THEN 1 ELSE 0 END) AS conversions,
    ROUND(SUM(cs.revenue_generated), 2) AS revenue_generated,
    ROUND(100.0 * SUM(CASE WHEN cs.opened THEN 1 ELSE 0 END) / COUNT(cs.send_id), 1) AS open_rate_pct,
    ROUND(100.0 * SUM(CASE WHEN cs.converted THEN 1 ELSE 0 END) / COUNT(cs.send_id), 1) AS conversion_rate_pct,
    ROUND((SUM(cs.revenue_generated) - camp.campaign_cost) / camp.campaign_cost * 100, 1) AS roi_pct
FROM campaigns camp
JOIN campaign_sends cs ON camp.campaign_id = cs.campaign_id
GROUP BY camp.campaign_id, camp.campaign_name, camp.channel, camp.target_segment, camp.campaign_cost
ORDER BY roi_pct DESC;

-- 5. NPS score by branch
SELECT
    branch,
    COUNT(*) AS responses,
    ROUND(AVG(nps_score), 1) AS avg_score,
    SUM(CASE WHEN category = 'Promoter' THEN 1 ELSE 0 END) AS promoters,
    SUM(CASE WHEN category = 'Detractor' THEN 1 ELSE 0 END) AS detractors,
    ROUND(100.0 * SUM(CASE WHEN category = 'Promoter' THEN 1 ELSE 0 END) / COUNT(*)
        - 100.0 * SUM(CASE WHEN category = 'Detractor' THEN 1 ELSE 0 END) / COUNT(*), 1) AS nps_score_net
FROM nps_responses
GROUP BY branch
ORDER BY nps_score_net DESC;

-- 6. Monthly revenue trend
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS order_month,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(order_total), 2) AS revenue
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY order_month;
