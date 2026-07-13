# PostgreSQL Setup Guide (Mac)

## 1. Install PostgreSQL
```bash
brew install postgresql@16
brew services start postgresql@16
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Check it worked:
```bash
psql --version
```

## 2. Create the database
```bash
createdb stark_portfolio
```

## 3. Create the tables
From the `sql_postgres` folder:
```bash
psql -d stark_portfolio -f 00_create_schema.sql
```

## 4. Load the data
Navigate to the folder containing the CSVs first (the \copy paths in the
script are relative to where you run psql from):
```bash
cd ../data
psql -d stark_portfolio -f ../sql_postgres/01_load_data.sql
```
You should see row counts printed at the end (600 customers, 4725 orders, etc.)
matching the CSV files — confirms the load worked.

## 5. Run the analysis queries
```bash
psql -d stark_portfolio -f ../sql_postgres/02_data_quality_checks.sql
psql -d stark_portfolio -f ../sql_postgres/03_business_analysis.sql
```

Or open `stark_portfolio` in a GUI tool like **TablePlus**, **DBeaver**, or
**Postico** (all free/freemium, all Mac-friendly) and run queries interactively —
this is generally nicer for building up analysis step by step and is what
you'd demo to a recruiter.

## Why both SQLite and PostgreSQL are in this project
- **SQLite** (`data/stark_portfolio.db`) — the portable version. Anyone can open
  it instantly with no setup, useful for sharing the project or quick checks.
- **PostgreSQL** (`sql_postgres/`) — the "real world" version, since most
  companies run Postgres, MySQL, or SQL Server in production, not SQLite.
  Practicing here means you're comfortable with proper data types (DATE,
  NUMERIC, BOOLEAN), constraints (foreign keys, CHECK constraints), and
  server-based querying — all of which come up in technical interviews.

The SQL logic (joins, aggregations, CTEs, window-style segmentation) is
nearly identical between the two — the differences are mostly in date
functions and type casting, which is a good thing to be able to speak to
if asked "have you used Postgres?"
