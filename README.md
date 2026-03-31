# Behavioral Risk & Anomaly Detection Pipeline

## Project Objective
This project engineers a Medallion Architecture (Bronze, Silver, Gold) data pipeline in SQL Server to detect coordinated anomalous behavior within a high-volume application. By establishing rolling statistical baselines, the system automatically flags irregular spikes in user registration and engagement, acting as a foundational model for bot network detection, fraud rings, or coordinated application manipulation.

## Technical Stack
* **Database:** Microsoft SQL Server (T-SQL)
* **Data Generation:** Python (Pandas, NumPy)
* **Key Techniques:** Medallion Architecture, ETL, Window Functions, Statistical Baselines, Referential Integrity.

## Architecture & Logic Flow

### 1. Bronze Layer (Raw Ingestion)
* Simulated ingestion of 55,000+ raw application events and user profiles. 
* Data is loaded "as-is" utilizing highly optimized `BULK INSERT` operations to handle scale without choking database memory.

### 2. Silver Layer (ETL & Standardization)
* **Deduplication:** Implemented `ROW_NUMBER()` window functions partitioned by user IDs to permanently filter redundant registrations.
* **Type Casting & Cleansing:** Converted unstructured string data into strict `DATETIME` and `BIT` boolean structures. Handled missing categorical data via `ISNULL` fallbacks.
* **Referential Integrity:** Enforced strict `INNER JOIN` conditions to drop orphaned event logs belonging to users who failed the initial deduplication and validation checks.

### 3. Gold Layer (Risk Analytics)
* Deployed a `CREATE VIEW` structure to serve actionable intelligence to downstream BI tools.
* Utilized `AVG(...) OVER(...)` window functions to establish a rolling 14-day historical baseline for specific geographic nodes.
* Applied conditional logic (`CASE` statements) to flag behavioral spikes that deviate mathematically from the baseline (e.g., volume spikes > 10x the regional norm combined with absolute volume thresholds to eliminate statistical noise).

## Execution Instructions
To reproduce this environment locally:
1. Run the Python script in `/01_Data_Generation` to generate the raw datasets. 
2. Execute the SQL scripts sequentially from `/02_Bronze_Layer` through `/04_Gold_Layer` within SQL Server Management Studio (SSMS).
3. Query the `gold_risk_bot_detection` view to isolate the injected bot networks.