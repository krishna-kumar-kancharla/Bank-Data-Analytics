-- ============================================
-- Create and Use Database
-- ============================================
CREATE DATABASE IF NOT EXISTS CREDIT_DEBIT;
USE CREDIT_DEBIT;

-- ============================================
-- View all records in the table
-- ============================================
SELECT * FROM credit_debit;

-- ============================================
-- Count total number of transactions
-- ============================================
SELECT concat( round(count(*)/1000,2),' K' ) AS Total_Transactions FROM credit_debit;

-- ============================================
-- Sum of credit transactions
-- ============================================
SELECT concat(round(sum(amount)/1000000 ,2),' M')AS Credit_Amount
FROM credit_debit  
WHERE `transaction type` = 'credit';

-- ============================================
-- Sum of debit transactions
-- ============================================
SELECT concat(round(sum(amount)/1000000 ,2),' M') AS Debit_Amount 
FROM credit_debit
WHERE `transaction type` = 'debit';

-- ============================================
-- Total transaction amount (credit + debit)
-- ============================================
SELECT concat(round(sum(amount)/1000000 ,2),' M') AS Total_transaction_Amount 
FROM credit_debit;

-- ============================================
-- Credit to Debit ratio
-- ============================================
SELECT 
    round((SELECT SUM(amount) FROM credit_debit WHERE `transaction type`='credit')
    /
    (SELECT SUM(amount) FROM credit_debit WHERE `transaction type`='debit') ,1)
AS Credit_to_Debit_Ratio;

-- ============================================
-- Net transaction amount (Credit - Debit)
-- ============================================
SELECT 
   concat( round(((SELECT SUM(amount) FROM credit_debit WHERE `transaction type`='credit') -
    (SELECT SUM(amount) FROM credit_debit WHERE `transaction type`='debit') )/1000,2),' K')
AS Net_Transaction_Amount;

-- ============================================
-- Account Activity Ratio (Number of transactions / Avg balance)
-- ============================================
SELECT 
   concat( round( COUNT(`transaction date`) / AVG(balance) ,1),' %') AS Account_Activity_Ratio
FROM credit_debit;

-- ============================================
-- Number of transactions per day of the month
-- ============================================
SELECT 
    DAYOFMONTH(`transaction date`) AS Day,
    concat( round(count(*)/1000,2),' K' ) AS Num_Transactions
FROM credit_debit
GROUP BY DAYOFMONTH(`transaction date`)
ORDER BY Day;

-- ============================================
-- Number of transactions per weekday
-- 0 = Monday, 6 = Sunday
-- ============================================
SELECT 
    WEEKDAY(`transaction date`) AS Week_Num,
    ANY_VALUE(
        CASE WEEKDAY(`transaction date`)
            WHEN 0 THEN 'Monday'
            WHEN 1 THEN 'Tuesday'
            WHEN 2 THEN 'Wednesday'
            WHEN 3 THEN 'Thursday'
            WHEN 4 THEN 'Friday'
            WHEN 5 THEN 'Saturday'
            WHEN 6 THEN 'Sunday'
        END
    ) AS Week_Day,
    concat( round(count(*)/1000,2),' K' ) AS Num_Transactions
FROM credit_debit
GROUP BY WEEKDAY(`transaction date`)
ORDER BY Week_Num;

-- ============================================
-- Number of transactions per month
-- ============================================
SELECT 
    MONTH(`transaction date`) AS Month_Num,
    ANY_VALUE(MONTHNAME(`transaction date`)) AS Month,
   concat( round(count(*)/1000,2),' K' ) AS Num_Transactions
FROM credit_debit
GROUP BY MONTH(`transaction date`)
ORDER BY Month_Num;

-- ============================================
-- Transaction amount by branch
-- ============================================
SELECT 
    branch, 
    concat(round(sum(amount)/1000000 ,2),' M') AS Transaction_Amount
FROM credit_debit
GROUP BY branch
ORDER BY Transaction_Amount;
