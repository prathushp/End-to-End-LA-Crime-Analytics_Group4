# End-to-End-LA-Crime-Analytics_Group4

# LA Crime Analytics - End-to-End Data Warehouse Project


## Project Overview

End-to-end analytics solution analyzing 1 million+ LA crime incidents from 2020-2024 using Medallion Architecture (Bronze-Silver-Gold) with dimensional modeling and business intelligence dashboards.

## Architecture

Raw CSV → Bronze (Databricks) → Silver (Databricks) → Gold Star Schema (Databricks) → PowerBI/Tableau Dashboards

## Technologies

- Data Profiling: Alteryx
- ETL Pipeline: Databricks (PySpark, Delta Live Tables)
- Data Warehouse: Databricks Delta Lake
- Visualization: PowerBI/Tableau Desktop

## Data Model

Star Schema with 8 dimensions and 1 fact table:
- Fact: FACT_CRIME_INCIDENTS (1,004,991 rows)
- Dimensions: Date, Time, Location, Crime Type, Victim, Premise, Weapon, Status

## Key Findings

- Crime peaked in 2022 (235K), now declining
- Friday has 11% more crime than Tuesday
- Central LA has 2x more crime than Foothill area
- 67% of crimes involve no weapon
- Adults aged 30-44 most victimized
- Only 9% arrest rate overall

## Business Questions Answered

1. Crime trends over time (yearly, monthly, quarterly)
2. Day of week and time of day patterns
3. Geographic crime hotspots in LA
4. Most commonly used weapons
5. Victim age and gender patterns
6. Adult vs juvenile arrest ratios

## Deliverables

- Visualization dashboards
- Complete star schema in Databricks
- Data quality profiling documentation
- ETL pipeline code (Bronze/Silver/Gold)

## How to Run

1. Upload CSV to Databricks Volume
2. Run Bronze/Silver notebook to clean data
3. Run Gold Layer notebook to create star schema
4. Connect PowerBI/Tableau to Databricks and build dashboards

## Data Quality

- Total Records: 1,004,991
- Data Quality Score: 73.2%
- Invalid ages corrected: 269K records
- Invalid coordinates corrected: 2.2K records

