# Marketing & Insight Analysis — Portfolio Project

A sample analytics project built to demonstrate the skills required for a
Marketing & Insight Analyst role at a multi-branch building materials
distributor — covering SQL, Excel, Power BI, and marketing/customer insight.

All data in this project is **synthetic**, generated to resemble the scale
and structure of a real distributor (customers, orders, products, marketing
campaigns, and NPS survey responses), so it can be freely shared and explored.

---

## Business Scenario

A distributor selling timber, cement, tools, insulation, and related products
across 6 branches wants to understand:
- Which customer segments and branches drive the most revenue and margin
- How effective its marketing campaigns are (email, SMS, direct mail)
- How customer satisfaction (NPS) varies by branch and segment
- How to turn all of the above into a self-serve reporting layer for
  stakeholders, rather than one-off ad hoc reports

This project answers those questions end-to-end: from raw data, through SQL
and Excel analysis, to a Power BI dashboard and written business
recommendations.

---

## Repository Structure

```
├── data/           7 CSV files: customers, products, orders, order_lines,
│                   campaigns, campaign_sends, nps_responses (raw source data)
├── sql/            PostgreSQL schema, data loader, and 12 analysis queries
│                   (data quality checks + business analysis)
├── excel/          Excel workbook: INDEX/MATCH lookups, SUMIFS pivot-style
│                   summaries, KPI definitions, interactive customer lookup tool
├── docs/           Data dictionary, and written insight/recommendation docs
│                   for segmentation, campaigns, and NPS
└── powerbi/        Power BI dashboard (data model, DAX measures, 4-page report)
```

| Folder | What's inside |
|---|---|
| [`sql/`](./sql) | `00_create_schema.sql`, `01_load_data.sql`, `02_data_quality_checks.sql`, `03_business_analysis.sql` |
| [`excel/`](./excel) | `Marketing_Insight_Analyst_Portfolio.xlsx` — 12 tabs including lookups, pivot-style summaries, and a KPI definitions reference |
| [`docs/`](./docs) | `data_dictionary.md` (field definitions & assumptions), plus segmentation, campaign, and NPS insight write-ups |
| `powerbi/` | Dashboard build — data model, DAX measures, executive summary + segmentation + NPS pages |

---

## Key Findings

- **Revenue is concentrated in a small "Champion" customer segment** (RFM-based:
  recent + frequent + high-spend) — retention strategy for this group matters
  more than broad acquisition volume.
- **Direct Mail outperformed digital channels on campaign ROI** in this sample,
  challenging the assumption that digital is always the more efficient channel
  for a trade/contractor audience.
- **The first-order experience is the highest-risk moment** in the customer
  journey — a strong candidate for a low-cost, high-leverage quality check.
- **NPS should be read alongside revenue and segment, not ranked alone** — a
  high-volume branch with low NPS is a bigger commercial risk than a
  low-volume branch with a low score.

Full reasoning behind each of these is in [`docs/`](./docs).

---

## Skills Demonstrated

- **SQL**: joins, aggregation, CTEs, CASE-based segmentation, data quality/
  reconciliation checks, written for both SQLite (portability) and
  PostgreSQL (production-style)
- **Excel**: INDEX/MATCH lookups (chosen over XLOOKUP for backward
  compatibility), SUMIFS/COUNTIFS pivot-style reporting, margin calculations,
  an interactive lookup tool, and a standardised KPI definitions tab
- **Power BI**: star schema data model, DAX measures (including time
  intelligence), multi-page dashboard covering executive summary,
  segmentation/campaigns, and customer experience
- **Marketing & customer insight**: RFM segmentation, campaign ROI analysis,
  customer journey mapping, NPS interpretation, and business recommendations
  written for a non-technical stakeholder audience

---

## Status

SQL ✅ · Excel ✅ · Segmentation & Campaign Insight ✅ · NPS Insight ✅ · Power BI 🔧 in progress

---

## Author

[Sushma Bilidale](https://github.com/Sushma-66) — Data Analyst with experience
across inflight entertainment (Aviation Sector), telecommunications, and food service, currently
based in the UK.
