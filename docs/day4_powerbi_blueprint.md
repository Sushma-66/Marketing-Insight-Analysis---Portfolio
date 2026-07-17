# Power BI Dashboard Documentation
**Marketing & Insight Analyst Portfolio | Building Materials Distributor (sample data)**

---

## Data Model

The dashboard is built on a star schema:

**Fact tables:**
- `order_lines` — core transaction data (14,098 rows)
- `campaign_sends` — campaign engagement data (516 rows)
- `nps_responses` — customer survey data (220 rows)

**Dimension tables:**
- `customers`, `products`, `orders`, `campaigns`
- A dedicated `DateTable`, built with `CALENDAR()`, to support time-intelligence
  calculations (YoY comparisons, trailing-12-month active customers)

**Relationships:** all fact tables connect to their relevant dimensions on a
many-to-one basis with single-direction cross-filtering — `order_lines` to
`orders` and `products`; `orders` to `customers` and `DateTable`;
`campaign_sends` to `campaigns` and `customers`; `nps_responses` to `customers`.

---

## Key DAX Measures

18 measures were built, grouped by area:

**Revenue & Margin:** Total Revenue, Total Cost, Gross Margin, Gross Margin %,
Order Count, Average Order Value

**Customer Metrics:** Active Customers (trailing 12 months), Revenue YoY %,
Repeat Purchase Rate

**Campaign Performance:** Campaign Sends, Opens, Conversions, Revenue,
Open Rate, Conversion Rate, Campaign ROI %

**Customer Experience:** Avg NPS Score, NPS (Net Score)

Measures are used throughout (rather than calculated columns) so every number
on the dashboard responds dynamically to whichever filter or slicer a viewer
applies — branch, date range, or customer segment.

---

## Dashboard Pages

**Executive Summary** — Total Revenue, Gross Margin %, Order Count, Active
Customers, and NPS as headline KPI cards; a monthly revenue trend line; and
revenue breakdowns by customer type and branch. Filterable by date, branch,
and customer type.

**Segmentation & Campaigns** — revenue and margin by customer segment
alongside campaign performance (sends, open rate, conversion rate, ROI),
with a cost-vs-revenue comparison across campaigns to make efficiency visible
at a glance.

**Customer Experience (NPS)** — overall NPS and average score, NPS by branch,
and a breakdown of Promoter/Passive/Detractor distribution by customer segment.

---

## Key Insight Highlighted on the Dashboard

Revenue is concentrated in a small "Champion" customer segment, and Direct
Mail is outperforming digital channels on campaign ROI for this audience —
both flagged directly on the Executive Summary page rather than left for the
viewer to infer from the underlying numbers.
