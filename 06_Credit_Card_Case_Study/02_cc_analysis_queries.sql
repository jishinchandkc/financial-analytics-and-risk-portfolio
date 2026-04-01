/* PROJECT: Credit Card Transaction Intelligence
   Objective: Analyze spend patterns, growth, and market milestones.
*/

-- 1. Top 5 cities by spend and their % contribution [cite: 10]
SELECT TOP 5
    city, 
    SUM(amount) AS total_spend,
    ROUND(100.0 * SUM(amount) / (SELECT SUM(amount) FROM credit_card_transcations), 2) AS pct_of_total_spend
FROM credit_card_transcations
GROUP BY city
ORDER BY total_spend DESC;

-- 2. Highest spend month and amount for each card type [cite: 23]
WITH MonthlyStats AS (
    SELECT card_type, MONTH(transaction_date) AS mnt, YEAR(transaction_date) AS yr, SUM(amount) AS monthly_spend
    FROM credit_card_transcations
    GROUP BY card_type, YEAR(transaction_date), MONTH(transaction_date)
),
RankedSpend AS (
    SELECT *, RANK() OVER(PARTITION BY card_type ORDER BY monthly_spend DESC) AS rk
    FROM MonthlyStats
)
SELECT card_type, mnt, yr, monthly_spend FROM RankedSpend WHERE rk = 1;

-- 3. Milestone: Transaction that pushes cumulative spend over 1,000,000 [cite: 49]
WITH Cumulative AS (
    SELECT *, SUM(amount) OVER(PARTITION BY card_type ORDER BY transaction_date, transaction_id) AS cumm_spend
    FROM credit_card_transcations
)
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY card_type ORDER BY cumm_spend) AS rk
    FROM Cumulative WHERE cumm_spend >= 1000000
) x WHERE rk = 1;
