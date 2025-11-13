use excelr;
-- 1.Total loan amount funded

SELECT 
    SUM(`Funded Amount`)/1000000 AS total_loan_amount_funded
FROM bank ;


-- 2. Total Loans
SELECT 
    COUNT(*) AS total_loans
FROM bank;

-- 3. Total Collection
SELECT 
    SUM(`Total Payment`)/1000000 AS total_collection
FROM bank;

-- 4. Total Interest
SELECT 
    SUM(`Total Interest`)/1000000 AS total_interest
FROM bank;

-- 5. Branch-Wise Performance (Interest, Fees, Total Revenue)
SELECT 
    Branch,
    SUM(`Total Interest`)/1000000 AS total_interest,
    SUM(`Total Fees`)/1000000 AS total_fees,
    SUM(`Total Interest` + `Total Fees`)/1000000 AS total_revenue,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount
FROM bank
GROUP BY Branch
ORDER BY total_revenue DESC;

-- 6. State-Wise Loan
SELECT 
    State,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount,
    SUM(`Loan Amount`)/1000000 AS total_loan_amount,
    AVG(`Int Rate`) AS avg_interest_rate,
    SUM(`Total Payment`)/1000000 AS total_collection
FROM bank
GROUP BY State
ORDER BY loan_count DESC;

-- 7. Religion-Wise Loan
SELECT 
    Religion,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount,
    AVG(`Int Rate`) AS avg_interest_rate,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank), 2) AS percentage
FROM bank
GROUP BY Religion
ORDER BY loan_count DESC;

-- 8. Product Group-Wise Loan
SELECT 
    Product,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount,
    SUM(`Loan Amount`)/1000000 AS total_loan_amount,
    SUM(`Total Payment`)/1000000 AS total_collection,
    SUM(`Total Interest`)/1000000 AS total_interest,
    AVG(`Int Rate`) AS avg_interest_rate
FROM bank
GROUP BY Product
ORDER BY loan_count DESC;

-- 9. Disbursement Trend (Monthly)
SELECT 
    Year,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_disbursed,
    AVG(`Funded Amount`)/1000000 AS avg_loan_amount
FROM bank
GROUP BY Year
ORDER BY Year;



-- 10. Count of Default Loan
SELECT 
    COUNT(*) AS default_loan_count,
    SUM(`Funded Amount`)/1000000 AS total_default_amount,
    SUM(`Total Principal`)/1000000 AS total_principal_at_risk,
    SUM(`Total Payment`)/1000000 AS amount_recovered
FROM bank
WHERE `Is Default Loan` = 'Y';

-- 11. Count of Delinquent Clients
SELECT 
    COUNT(DISTINCT `Account ID`) AS delinquent_client_count,
    SUM(`Funded Amount`)/1000000 AS total_delinquent_amount
FROM bank
WHERE `Is Delinquent Loan` = 'Y';

-- 12. Delinquent Loans Rate
SELECT 
    COUNT(CASE WHEN `Is Delinquent Loan` = 'Y' THEN 1 END) AS delinquent_loans,
    COUNT(*) AS total_loans,
    ROUND(COUNT(CASE WHEN `Is Delinquent Loan` = 'Y' THEN 1 END) * 100.0 / COUNT(*), 2) AS delinquent_loan_rate_percentage
FROM bank;

-- 14. Default Loan Rate
SELECT 
    COUNT(CASE WHEN `Is Default Loan` = 'Y' THEN 1 END) AS default_loans,
    COUNT(*) AS total_loans,
    ROUND(COUNT(CASE WHEN `Is Default Loan` = 'Y' THEN 1 END) * 100.0 / COUNT(*), 2) AS default_loan_rate_percentage
FROM bank;

-- 14. Loan Status-Wise Loan
SELECT 
    `Loan Status`,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount,
    SUM(`Total Payment`)/1000000 AS total_collection,
    SUM(`Total Interest`)/1000000 AS total_interest,
    AVG(`Int Rate`)/1000000 AS avg_interest_rate,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank), 2) AS percentage
FROM bank
GROUP BY `Loan Status`
ORDER BY loan_count DESC;

-- 15. Age Group-Wise Loan
SELECT 
    `Age Group`,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_funded_amount,
    SUM(`Loan Amount`)/1000000 AS total_loan_amount,
    AVG(`Int Rate`)/1000000 AS avg_interest_rate,
    SUM(`Total Payment`)/1000000 AS total_collection,
    SUM(`Total Interest`)/1000000 AS total_interest
FROM bank
GROUP BY `Age Group`
ORDER BY 
    CASE `Age Group`
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-55' THEN 4
        WHEN '56-65' THEN 5
        WHEN '65+' THEN 6
        ELSE 7
    END;
    
    -- 16. No Verified Loans
    SELECT 
    `Verification Status`,
    COUNT(*) AS loan_count,
    SUM(`Funded Amount`)/1000000 AS total_amount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bank), 2) AS percentage
FROM bank
GROUP BY `Verification Status`;


-- 17 Transaction Volume by Branch
SELECT 
    Branch,
    State,
    COUNT(*) AS transaction_count,
    SUM(`Funded Amount`)/1000000 AS total_transaction_volume,
    AVG(`Funded Amount`)/1000000 AS avg_transaction_amount,
    SUM(`Total Payment`)/1000000 AS total_collection
FROM bank
GROUP BY Branch, State
ORDER BY total_transaction_volume DESC;
