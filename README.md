# Financial Analytics & Risk Portfolio

Two independent SQL analytics modules built to learn T-SQL properly rather than
course by course. Both run on **synthetic data generated for the project** — no
real user or transaction data is involved.

---

## Project 1: Behavioral Risk & Anomaly Detection

**Objective:** detect coordinated bot networks and irregular activity in a
high-volume application.

### Analytical logic

* **Integrity validation** — standardised **55,000+ synthetic activity events**,
  deduplicating with `ROW_NUMBER()` partitioned by user and enforcing referential
  integrity so orphaned events are dropped.
* **Behavioral baselines** — established 14-day rolling historical averages with
  `AVG(...) OVER(...)` to define normal activity per region.
* **Anomaly detection** — flagged regional spikes exceeding **10x** the rolling
  baseline, combined with absolute volume thresholds to filter statistical noise.
* **Velocity tracking** — isolated rapid-fire actions and burner accounts that
  performed high-value tasks within 60 seconds of registration.

Built on a three layer medallion architecture: bronze for raw ingestion, silver
for cleaning and type casting, gold as a view serving the risk flags.

---

## Project 2: Credit Card Transaction Intelligence

**Objective:** extract business insights from card usage patterns — market share,
growth and customer milestones.

### Key use cases

* **Market share** — top 5 cities by spend and each city's share of total revenue.
* **Milestone tracking** — cumulative spend model using `SUM(...) OVER(...)` to
  find the exact transaction at which a cardholder crosses a 1,000,000 unit threshold.
* **Growth analytics** — month-over-month growth by card tier and expense category
  using `LAG()`.
* **Acquisition velocity** — time for a new market to reach 500 transactions,
  using `DATEDIFF` and `ROW_NUMBER()`.

---

## Stack and scope

* **SQL Server (T-SQL)** — all analysis, ETL and views. This is the work.
* **Python** — a single script that generates the synthetic dataset. It was written
  with AI assistance and exists only to produce input data; it is not part of the
  analysis.

## Running it

1. Run the generator in `/01_Behavioral_Risk_Module/01_Data_Generation`
   to produce the raw datasets.
2. Execute the SQL scripts in `/01_Behavioral_Risk_Module`, folders
   `02_Bronze_Layer` through `04_Gold_Layer`, in order.
3. Query the `gold_risk_bot_detection` view to see the flagged networks.
4. Card spend analysis is standalone in `/02_Credit_Card_Analytics_Module`.
