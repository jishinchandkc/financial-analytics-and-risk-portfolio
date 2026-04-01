-- 1. Top 5 cities with highest spends and their percentage contribution [cite: 10]
SELECT 
    city, 
    SUM(amount) AS total_spend,
    ROUND(100.0 * SUM(amount) / (SELECT SUM(amount) FROM credit_card_transcations), 2) AS pct_of_total_spend
FROM credit_card_transcations
GROUP BY city
ORDER BY total_spend DESC
LIMIT 5; -- [cite: 13, 20]

-- 2. Finding the 1,000,000 spend milestone for each card type [cite: 51]
WITH CumulativeSpend AS (
    SELECT *,
        SUM(amount) OVER(PARTITION BY card_type ORDER BY transaction_date, transaction_id) AS running_total -- [cite: 57]
    FROM credit_card_transcations
)
SELECT * FROM CumulativeSpend 
WHERE running_total >= 1000000; -- [cite: 68]
