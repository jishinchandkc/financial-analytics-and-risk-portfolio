# Data Engineering & Financial Intelligence Portfolio

This repository contains an end-to-end SQL-based analytics ecosystem. It leverages **Medallion Architecture** to solve two distinct industrial challenges: **Behavioral Risk Mitigation** (Bot Detection) and **Credit Card Transaction Intelligence** (Financial Growth & Lifecycle Modeling).

---

## 🚀 Core Technical Stack
* **Database:** Microsoft SQL Server (T-SQL)
* **Data Orchestration:** Python (Pandas, NumPy) for synthetic high-volume generation.
* **Advanced SQL:** Window Functions (`RANK`, `LAG`, `SUM OVER`), CTEs, Medallion ETL, and Statistical Baselines.

---

## 🛡️ Project 1: Behavioral Risk & Anomaly Pipeline
**Objective:** Detect coordinated bot networks and fraud rings within high-volume application logs.

### Architecture & Logic
1.  **Bronze (Raw):** Ingestion of 55,000+ raw events using optimized `BULK INSERT`.
2.  **Silver (Clean):** * **Deduplication:** Utilized `ROW_NUMBER()` to eliminate redundant registrations.
    * **Integrity:** Enforced `INNER JOIN` logic to purge orphaned event logs.
3.  **Gold (Analytics):** * **Risk Baselines:** Established 14-day rolling historical averages using `AVG(...) OVER(...)`.
    * **Bot Detection:** Applied `CASE` logic to flag regional spikes exceeding 10x the norm.

---

## 💳 Project 2: Credit Card Transaction Intelligence
[cite_start]**Objective:** Extract actionable business insights from credit card usage patterns, focusing on market share, growth, and customer milestones[cite: 1, 2].

### Key Business Use Cases
* [cite_start]**Market Share Analysis:** Identified top 5 cities by spend and calculated their percentage contribution to global revenue[cite: 10, 22].
* [cite_start]**Milestone Tracking:** Engineered a cumulative spend model using `SUM(...) OVER(...)` to trigger alerts when a card tier reaches a **1,000,000 unit threshold**[cite: 49, 51, 57].
* [cite_start]**Growth Analytics:** Implemented `LAG()` window functions to identify the highest **Month-over-Month (MoM) growth** segments[cite: 179, 180, 196, 203].
* [cite_start]**Customer Velocity:** Calculated "Acquisition Velocity" by measuring the `DATEDIFF` between a city's 1st and 500th transaction[cite: 223, 234].

---

## 📂 Repository Structure

```text
├── 01_Data_Generation          # Python scripts for synthetic data
├── 02_Bronze_Layer             # Raw table DDL and Bulk Load scripts
├── 03_Silver_Layer             # ETL, Cleansing, and Deduplication
├── 04_Gold_Layer               # Risk Views and Statistical Baselines
├── 05_Advanced_Analytics       # Bot velocity and "Burner Account" detection
└── 06_Credit_Card_Case_Study   # Financial growth & milestone queries
