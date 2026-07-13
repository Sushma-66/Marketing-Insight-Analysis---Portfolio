# Day 4 — Power BI Dashboard Blueprint
**Marketing & Insight Analyst Portfolio | Building Materials Distributor (sample data)**

> Build this hands-on in Power BI Desktop once it's installed (see setup note
> at the bottom). Everything below — the model, every DAX measure, and the
> page layout — is ready to paste/type in directly.

---

## 1. Data Model — Star Schema

Import all 7 CSVs (or connect to `stark_portfolio.db` via ODBC if you set up
SQLite ODBC, or just re-export the SQL query outputs as CSVs — simplest option).

**Fact tables** (the "what happened" tables — these grow over time):
- `order_lines` (14,098 rows) — the core transaction fact table
- `campaign_sends` (516 rows) — the campaign engagement fact table
- `nps_responses` (220 rows) — the survey fact table

**Dimension tables** (the "who/what/when" descriptive tables):
- `customers` (600 rows)
- `products` (31 rows)
- `orders` (4,725 rows) — technically a bridge between order_lines and customers,
  acts as a dimension for order-level attributes (date, branch)
- `campaigns` (8 rows)
- A **Date table** (see below — you need to build this one yourself)

### Relationships to build (Model view)
| From | To | Cardinality | Direction |
|---|---|---|---|
| order_lines[order_id] | orders[order_id] | Many-to-1 | Single |
| order_lines[product_id] | products[product_id] | Many-to-1 | Single |
| orders[customer_id] | customers[customer_id] | Many-to-1 | Single |
| campaign_sends[campaign_id] | campaigns[campaign_id] | Many-to-1 | Single |
| campaign_sends[customer_id] | customers[customer_id] | Many-to-1 | Single |
| nps_responses[customer_id] | customers[customer_id] | Many-to-1 | Single |
| orders[order_date] | DateTable[Date] | Many-to-1 | Single |

### Build a Date table (do this first — needed for any time-intelligence DAX)
In Power BI: **Modeling → New Table**, then:
```dax
DateTable =
CALENDAR (
    DATE(2024,1,1),
    DATE(2026,12,31)
)
```
Then add calculated columns to it:
```dax
Year = YEAR(DateTable[Date])
Month = FORMAT(DateTable[Date], "MMM YYYY")
MonthNum = MONTH(DateTable[Date])
```
Mark it as a **Date Table** (Modeling ribbon → Mark as Date Table) once built.

---

## 2. DAX Measures — type these into a new "Measures" table (best practice:
keep measures in their own table, not scattered across data tables)

```dax
Total Revenue = SUMX(order_lines, order_lines[quantity] * order_lines[unit_price])

Total Cost = SUMX(
    order_lines,
    order_lines[quantity] * RELATED(products[unit_cost])
)

Gross Margin = [Total Revenue] - [Total Cost]

Gross Margin % = DIVIDE([Gross Margin], [Total Revenue], 0)

Order Count = DISTINCTCOUNT(order_lines[order_id])

Average Order Value = DIVIDE([Total Revenue], [Order Count], 0)

Active Customers =
CALCULATE(
    DISTINCTCOUNT(orders[customer_id]),
    DATESINPERIOD(DateTable[Date], MAX(DateTable[Date]), -12, MONTH)
)

Revenue YoY % =
VAR CurrentRevenue = [Total Revenue]
VAR PriorYearRevenue =
    CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(DateTable[Date]))
RETURN
    DIVIDE(CurrentRevenue - PriorYearRevenue, PriorYearRevenue, 0)

Campaign Sends = COUNTROWS(campaign_sends)

Campaign Opens = CALCULATE(COUNTROWS(campaign_sends), campaign_sends[opened] = 1)

Campaign Conversions = CALCULATE(COUNTROWS(campaign_sends), campaign_sends[converted] = 1)

Campaign Revenue = SUM(campaign_sends[revenue_generated])

Open Rate = DIVIDE([Campaign Opens], [Campaign Sends], 0)

Conversion Rate = DIVIDE([Campaign Conversions], [Campaign Sends], 0)

Campaign ROI % =
VAR CampCost = SUM(campaigns[campaign_cost])
RETURN DIVIDE([Campaign Revenue] - CampCost, CampCost, 0)

Avg NPS Score = AVERAGE(nps_responses[nps_score])

NPS (Net Score) =
VAR Promoters = CALCULATE(COUNTROWS(nps_responses), nps_responses[category] = "Promoter")
VAR Detractors = CALCULATE(COUNTROWS(nps_responses), nps_responses[category] = "Detractor")
VAR TotalResponses = COUNTROWS(nps_responses)
RETURN
    DIVIDE(Promoters, TotalResponses, 0) - DIVIDE(Detractors, TotalResponses, 0)

Repeat Purchase Rate =
VAR CustomersWithOrders = DISTINCTCOUNT(orders[customer_id])
VAR CustomersWith2Plus =
    COUNTROWS(
        FILTER(
            VALUES(orders[customer_id]),
            CALCULATE(COUNTROWS(orders)) >= 2
        )
    )
RETURN DIVIDE(CustomersWith2Plus, CustomersWithOrders, 0)
```

**Note on why these are separate measures, not calculated columns:** measures
recalculate dynamically based on whatever filter/slicer is applied (branch,
date range, segment) — a calculated column would be frozen at one value. This
is the core DAX concept to be able to explain if asked: *"measures = dynamic,
calculated columns = static, computed at refresh time."*

---

## 3. Dashboard Pages — Layout

### Page 1: Executive Summary
- **Top row (KPI cards):** Total Revenue, Gross Margin %, Order Count, Active
  Customers, NPS (Net Score)
- **Middle:** Line chart — Total Revenue by Month, with Revenue YoY % as a
  secondary label
- **Bottom left:** Bar chart — Revenue by Customer Type
- **Bottom right:** Bar chart — Revenue by Branch
- **Slicers (top of page):** Date range, Branch, Customer Type

### Page 2: Customer Segmentation & Campaigns
- **Left:** Table or matrix — Customer Type x Revenue x Margin % x Order Count
- **Right:** Table — Campaign Name x Channel x Sends x Open Rate x Conversion
  Rate x ROI %, conditional formatting (red/green) on ROI %
- **Bottom:** Scatter chart — Campaign Cost (x-axis) vs Campaign Revenue
  (y-axis), bubble size = Sends — makes it immediately visible which campaigns
  are top-right (efficient) vs bottom-right (expensive, low return)

### Page 3: Customer Experience (NPS)
- **Top:** Card — Avg NPS Score, NPS (Net Score)
- **Middle:** Bar chart — NPS (Net Score) by Branch
- **Bottom:** Table — NPS category breakdown (Promoter/Passive/Detractor count)
  by Customer Type

### Page 4 (optional, self-serve): Product/Category Deep-Dive
- Table — Category x Revenue x Margin %, with a slicer for Branch
- This page is the "self-serve" one referenced in the JD — build it so a
  non-technical stakeholder could filter it themselves without needing you
  to re-run anything

---

## 4. Formatting & Polish (small things that make it look finished)
- Use a consistent colour theme (View → Themes) rather than default Power BI colours
- Rename all visuals with clear titles (not "Chart 1")
- Add a text box on Page 1 with 1-2 sentence "so what" callout — e.g. the
  Champions/Direct Mail insight from Day 3 — so the dashboard doesn't just
  show numbers, it leads with the takeaway

---

## 5. Setup Reminder (Mac users)
Power BI Desktop is Windows-only. Recommended free route: install VMware
Fusion (free for personal use) + a Windows 11 evaluation copy (90-day free
trial from Microsoft, plenty of time to complete and demo this project), then
install Power BI Desktop free from the Microsoft Store inside that VM.

---

## 6. What to practice saying about this page once built
- "I built a star schema with a dedicated date table so I could use proper
  time-intelligence DAX like YoY comparisons."
- "Measures are separate from calculated columns because they need to respond
  to whatever filter or slicer the viewer applies — that's the difference
  between a static number and a real self-serve dashboard."
- "The scatter chart on campaigns was a deliberate choice over a bar chart —
  it makes cost-vs-return visible in one glance instead of needing two
  separate charts."
