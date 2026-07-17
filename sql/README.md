# SQL — Setup & Structure

## Files
- `00_create_schema.sql` — creates all 7 tables with proper types, primary/foreign keys, and indexes
- `01_load_data.sql` — loads the CSVs from `/data` into the tables
- `02_data_quality_checks.sql` — 6 validation queries (referential integrity, reconciliation, duplicates, consent compliance)
- `03_business_analysis.sql` — 6 business analysis queries (revenue/margin by segment, RFM segmentation, campaign ROI, NPS, monthly trend)

## Setup (PostgreSQL)

```bash
createdb stark_portfolio
psql -d stark_portfolio -f 00_create_schema.sql
cd ../data
psql -d stark_portfolio -f ../sql/01_load_data.sql
```

Row counts print at the end of the load step as a load-verification check:

```
customers        600
products          31
orders          4725
order_lines     14098
campaigns          8
campaign_sends   516
nps_responses    220
```

## Running the analysis

```bash
psql -d stark_portfolio -f 02_data_quality_checks.sql
psql -d stark_portfolio -f 03_business_analysis.sql
```
