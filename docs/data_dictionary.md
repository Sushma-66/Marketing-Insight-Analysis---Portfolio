# Data Dictionary & Assumptions
**Project:** Marketing & Insight Analyst Portfolio — Building Materials Distributor (sample data)
**Author:** [Your Name] | **Date:** July 2026

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

---

## Key Definitions & Business Logic

- **NPS Score (branch-level)** = % Promoters − % Detractors, based on standard 0–10 scale
  (9–10 = Promoter, 7–8 = Passive, 0–6 = Detractor).
- **Campaign ROI** = (Revenue Generated − Campaign Cost) / Campaign Cost × 100.
- **Customer Segment (RFM-style)**:
  - *Champion* = ordered within last 90 days AND 10+ lifetime orders
  - *Loyal* = ordered within last 180 days AND 5+ lifetime orders
  - *At Risk / Dormant* = no order in 365+ days
  - *Developing* = everyone else
  - *Never purchased* = signed up but zero orders on record
  - Reference "today" for recency calculations: **2026-07-07**
- **Gross Margin %** = (Revenue − Cost of Goods) / Revenue × 100, calculated at the product level and rolled up.
- **Active Customer** (assumption, used in Excel/BI layer): placed at least 1 order in the trailing 12 months.

## Assumptions Made (would validate against source systems in a real role)
1. `order_total` is assumed to be a reliable header-level total; a reconciliation check
   against summed `order_lines` is included in `sql/01_data_quality_checks.sql` to confirm this.
2. Campaign attribution assumes a simple last-touch model (any order following a click/open
   is attributed to that campaign) — in reality this would need a defined attribution window
   agreed with stakeholders.
3. Direct Mail campaigns have no "opened" tracking (left blank) since physical mail can't be
   tracked the way digital channels can — only conversions are measurable.
4. Customer duplicates (same name + branch) were flagged in QA rather than silently removed,
   since in a real dataset this would need business confirmation before merging.

## Known Data Quality Findings (from `01_data_quality_checks.sql`)
- 54 potential duplicate customer name/branch combinations flagged for review.
- No orphaned orders or order lines found (referential integrity holds).
- Order header totals reconcile fully against line-level detail (0 variances).
