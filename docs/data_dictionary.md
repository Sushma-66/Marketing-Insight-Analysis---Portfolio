# Data Dictionary & Assumptions
**Project:** Marketing & Insight Analyst Portfolio — Building Materials Distributor (sample data)
**Author:** Sushma Bilidale | **Date:** 15 July 2026

> All data below is synthetic, generated for the purpose of this portfolio project.
> It is designed to resemble the structure and scale of a multi-branch building
> materials distributor, in line with the Marketing & Insight Analyst job description.

---

## Tables

### `customers`
| Field | Type | Description |
|---|---|---|
| customer_id | text (PK) | Unique customer identifier |
| customer_name | text | Individual or company name |
| customer_type | text | One of: Trade Account, Retail, Contractor, Housebuilder |
| branch | text | Home branch (6 branches modelled, incl. Binley/Coventry) |
| signup_date | date | Date customer record was created |
| email_opt_in | boolean (0/1) | Marketing email consent |
| sms_opt_in | boolean (0/1) | Marketing SMS consent |

### `products`
| Field | Type | Description |
|---|---|---|
| product_id | text (PK) | Unique product identifier |
| product_name | text | Product description |
| category | text | Timber, Cement & Aggregates, Insulation, Tools & Fixings, Roofing, Plumbing & Drainage, Landscaping |
| unit_cost | decimal | Cost price to business |
| unit_price | decimal | Sale price to customer |

### `orders` (order header)
| Field | Type | Description |
|---|---|---|
| order_id | text (PK) | Unique order identifier |
| customer_id | text (FK) | Links to `customers` |
| order_date | date | Date order placed |
| branch | text | Branch fulfilling the order |
| order_total | decimal | Total order value (should reconcile to sum of order_lines) |

### `order_lines`
| Field | Type | Description |
|---|---|---|
| order_line_id | text (PK) | Unique line identifier |
| order_id | text (FK) | Links to `orders` |
| product_id | text (FK) | Links to `products` |
| quantity | integer | Units ordered |
| unit_price | decimal | Price at time of order |
| line_total | decimal | quantity × unit_price |

### `campaigns`
| Field | Type | Description |
|---|---|---|
| campaign_id | text (PK) | Unique campaign identifier |
| campaign_name | text | Campaign name |
| channel | text | Email, SMS, or Direct Mail |
| target_segment | text | Customer type targeted |
| send_date | date | Date campaign launched |
| campaign_cost | decimal | Total cost to run campaign |

### `campaign_sends`
| Field | Type | Description |
|---|---|---|
| send_id | text (PK) | Unique send identifier |
| campaign_id | text (FK) | Links to `campaigns` |
| customer_id | text (FK) | Links to `customers` |
| opened | boolean (0/1/blank) | Blank for Direct Mail (opens aren't trackable) |
| clicked | boolean (0/1) | Click-through on email/SMS link |
| converted | boolean (0/1) | Resulted in a purchase within attribution window |
| revenue_generated | decimal | Revenue attributed to this send, if converted |

### `nps_responses`
| Field | Type | Description |
|---|---|---|
| response_id | text (PK) | Unique response identifier |
| customer_id | text (FK) | Links to `customers` |
| response_date | date | Date survey completed |
| nps_score | integer (0–10) | Raw NPS rating |
| category | text | Promoter (9–10), Passive (7–8), Detractor (0–6) |
| branch | text | Customer's branch |
