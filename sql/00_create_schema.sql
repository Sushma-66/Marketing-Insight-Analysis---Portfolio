-- =====================================================================
-- PostgreSQL schema for the Marketing & Insight Analyst portfolio project
-- Creates properly-typed tables (DATE, NUMERIC, BOOLEAN) with primary and
-- foreign key constraints, plus indexes on the columns used most in joins.
-- =====================================================================

DROP TABLE IF EXISTS campaign_sends CASCADE;
DROP TABLE IF EXISTS nps_responses CASCADE;
DROP TABLE IF EXISTS campaigns CASCADE;
DROP TABLE IF EXISTS order_lines CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id     VARCHAR(10) PRIMARY KEY,
    customer_name   VARCHAR(150) NOT NULL,
    customer_type   VARCHAR(30) NOT NULL,
    branch          VARCHAR(50) NOT NULL,
    signup_date     DATE NOT NULL,
    email_opt_in    BOOLEAN NOT NULL,
    sms_opt_in      BOOLEAN NOT NULL
);

CREATE TABLE products (
    product_id      VARCHAR(10) PRIMARY KEY,
    product_name    VARCHAR(150) NOT NULL,
    category        VARCHAR(50) NOT NULL,
    unit_cost       NUMERIC(10,2) NOT NULL,
    unit_price      NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id        VARCHAR(10) PRIMARY KEY,
    customer_id     VARCHAR(10) REFERENCES customers(customer_id),
    order_date      DATE NOT NULL,
    branch          VARCHAR(50) NOT NULL,
    order_total     NUMERIC(12,2) NOT NULL
);

CREATE TABLE order_lines (
    order_line_id   VARCHAR(10) PRIMARY KEY,
    order_id        VARCHAR(10) REFERENCES orders(order_id),
    product_id      VARCHAR(10) REFERENCES products(product_id),
    quantity        INTEGER NOT NULL,
    unit_price      NUMERIC(10,2) NOT NULL,
    line_total      NUMERIC(12,2) NOT NULL
);

CREATE TABLE campaigns (
    campaign_id     VARCHAR(10) PRIMARY KEY,
    campaign_name   VARCHAR(150) NOT NULL,
    channel         VARCHAR(20) NOT NULL,
    target_segment  VARCHAR(30) NOT NULL,
    send_date       DATE NOT NULL,
    campaign_cost   NUMERIC(10,2) NOT NULL
);

CREATE TABLE campaign_sends (
    send_id             VARCHAR(10) PRIMARY KEY,
    campaign_id         VARCHAR(10) REFERENCES campaigns(campaign_id),
    customer_id         VARCHAR(10) REFERENCES customers(customer_id),
    opened              BOOLEAN,
    clicked             BOOLEAN NOT NULL,
    converted           BOOLEAN NOT NULL,
    revenue_generated   NUMERIC(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE nps_responses (
    response_id     VARCHAR(10) PRIMARY KEY,
    customer_id     VARCHAR(10) REFERENCES customers(customer_id),
    response_date   DATE NOT NULL,
    nps_score       INTEGER NOT NULL CHECK (nps_score BETWEEN 0 AND 10),
    category        VARCHAR(20) NOT NULL,
    branch          VARCHAR(50) NOT NULL
);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orderlines_order ON order_lines(order_id);
CREATE INDEX idx_orderlines_product ON order_lines(product_id);
CREATE INDEX idx_campsends_campaign ON campaign_sends(campaign_id);
CREATE INDEX idx_campsends_customer ON campaign_sends(customer_id);
