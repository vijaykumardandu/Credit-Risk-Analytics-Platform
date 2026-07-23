-- =====================================================
-- CREDIT RISK ANALYTICS PLATFORM
-- Business Analytics Queries
-- =====================================================

USE credit_risk_db;

-- =====================================================
-- CUSTOMER ANALYTICS
-- =====================================================

-- Total Customers

SELECT COUNT(*) AS total_customers
FROM customers;

-- Customers by Gender

SELECT
    gender,
    COUNT(*) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;

-- Customers by Employment Status

SELECT
    employment_status,
    COUNT(*) AS total_customers
FROM customers
GROUP BY employment_status
ORDER BY total_customers DESC;

-- Customers by State

SELECT
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;

-- Average Credit Score

SELECT
    ROUND(AVG(credit_score),2) AS average_credit_score
FROM customers;

-- Credit Score Distribution

SELECT

CASE

WHEN credit_score >= 750 THEN 'Excellent'

WHEN credit_score >=700 THEN 'Good'

WHEN credit_score >=650 THEN 'Fair'

ELSE 'Poor'

END AS credit_category,

COUNT(*) AS customers

FROM customers

GROUP BY credit_category

ORDER BY customers DESC;


-- =====================================================
-- LOAN ANALYTICS
-- =====================================================

-- Total Loan Applications

SELECT COUNT(*) AS total_loan_applications
FROM loans;

-- Loan Approval Status

SELECT
    approval_status,
    COUNT(*) AS total_applications
FROM loans
GROUP BY approval_status
ORDER BY total_applications DESC;


-- Loan Approval Rate

SELECT

ROUND(

100 * SUM(
    CASE
        WHEN approval_status = 'Approved' THEN 1
        ELSE 0
    END
) / COUNT(*),

2

) AS approval_rate_percentage

FROM loans;

-- Loan Status Distribution

SELECT

    loan_status,

    COUNT(*) AS total_loans

FROM loans

GROUP BY loan_status

ORDER BY total_loans DESC;

-- Total Loan Portfolio

SELECT

ROUND(
    SUM(loan_amount),
    2
) AS total_portfolio_value

FROM loans;

-- Average Loan Amount

SELECT

ROUND(
    AVG(loan_amount),
    2
) AS average_loan_amount

FROM loans;

-- Loan Type Distribution

SELECT

    loan_type,

    COUNT(*) AS total_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_amount

FROM loans

GROUP BY loan_type

ORDER BY total_amount DESC;

-- Loan Purpose Analysis

SELECT

    loan_purpose,

    COUNT(*) AS applications

FROM loans

GROUP BY loan_purpose

ORDER BY applications DESC;

-- Average Interest Rate by Loan Type

SELECT

    loan_type,

    ROUND(
        AVG(interest_rate),
        2
    ) AS average_interest_rate

FROM loans

GROUP BY loan_type

ORDER BY average_interest_rate DESC;

-- Loan Portfolio by Status

SELECT

    loan_status,

    COUNT(*) AS total_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS portfolio_value

FROM loans

GROUP BY loan_status

ORDER BY portfolio_value DESC;

-- Top 10 Largest Loans

SELECT

    loan_id,

    customer_id,

    loan_amount,

    loan_type,

    loan_status

FROM loans

ORDER BY loan_amount DESC

LIMIT 10;

-- Monthly Loan Applications

SELECT

    YEAR(application_date) AS year,

    MONTH(application_date) AS month,

    COUNT(*) AS total_applications

FROM loans

GROUP BY

    YEAR(application_date),

    MONTH(application_date)

ORDER BY

    year,

    month;



    -- =====================================================
-- REPAYMENT ANALYTICS
-- =====================================================

-- Total Repayments

SELECT COUNT(*) AS total_repayments
FROM repayments;

-- Payment Status Distribution

SELECT

    payment_status,

    COUNT(*) AS total_payments

FROM repayments

GROUP BY payment_status

ORDER BY total_payments DESC;

-- Total Amount Collected

SELECT

ROUND(
    SUM(amount_paid),
    2
) AS total_collection

FROM repayments

WHERE payment_status='Paid';

-- Missed Payment Rate

SELECT

ROUND(

100 *

SUM(
CASE
WHEN payment_status='Missed'
THEN 1
ELSE 0
END
)

/

COUNT(*)

,2)

AS missed_payment_rate

FROM repayments;

-- Outstanding Portfolio

SELECT

ROUND(

SUM(remaining_balance),

2

)

AS outstanding_balance

FROM repayments;

-- Monthly Collections

SELECT

YEAR(payment_date) AS year,

MONTH(payment_date) AS month,

ROUND(
SUM(amount_paid),
2
)

AS collection_amount

FROM repayments

WHERE payment_status='Paid'

GROUP BY

YEAR(payment_date),

MONTH(payment_date)

ORDER BY

year,

month;

-- Top 10 Loans with Highest Outstanding Balance

SELECT

loan_id,

remaining_balance

FROM repayments

ORDER BY remaining_balance DESC

LIMIT 10;

-- Average Remaining Balance

SELECT

ROUND(

AVG(remaining_balance),

2

)

AS average_remaining_balance

FROM repayments;

-- =====================================================
-- CREDIT RISK ANALYTICS
-- =====================================================

-- High Risk Customers

SELECT

customer_id,

credit_score,

annual_income,

existing_debt

FROM customers

WHERE credit_score < 600

ORDER BY credit_score;

-- Average Credit Score by Employment Status

SELECT

employment_status,

ROUND(
AVG(credit_score),
2
)

AS average_credit_score

FROM customers

GROUP BY employment_status

ORDER BY average_credit_score DESC;

-- Debt-to-Income Ratio

SELECT

customer_id,

annual_income,

existing_debt,

ROUND(

(existing_debt / annual_income) * 100,

2

)

AS debt_to_income_ratio

FROM customers

ORDER BY debt_to_income_ratio DESC;

-- Customers with High Debt-to-Income Ratio

SELECT

customer_id,

annual_income,

existing_debt,

ROUND(
(existing_debt / annual_income) * 100,
2
)

AS debt_to_income_ratio

FROM customers

WHERE (existing_debt / annual_income) > 0.50

ORDER BY debt_to_income_ratio DESC;

-- Defaulted Loans

SELECT

loan_id,

customer_id,

loan_amount,

loan_type

FROM loans

WHERE loan_status = 'Default';

-- Default Rate

SELECT

ROUND(

100 *

SUM(
CASE
WHEN loan_status='Default'
THEN 1
ELSE 0
END
)

/

COUNT(*)

,2)

AS default_rate_percentage

FROM loans;

-- Average Credit Score by Loan Status

SELECT

l.loan_status,

ROUND(

AVG(c.credit_score),

2

)

AS average_credit_score

FROM customers c

JOIN loans l

ON c.customer_id = l.customer_id

GROUP BY l.loan_status;


-- Branch-wise Loan Portfolio

SELECT

b.branch_name,

COUNT(l.loan_id) AS total_loans,

ROUND(
SUM(l.loan_amount),
2
)

AS total_portfolio

FROM branches b

JOIN customers c
ON b.branch_id = c.branch_id

JOIN loans l
ON c.customer_id = l.customer_id

GROUP BY b.branch_name

ORDER BY total_portfolio DESC;

-- Branch-wise Average Credit Score

SELECT

b.branch_name,

ROUND(

AVG(c.credit_score),

2

)

AS average_credit_score

FROM branches b

JOIN customers c

ON b.branch_id = c.branch_id

GROUP BY b.branch_name

ORDER BY average_credit_score DESC;

-- Top 10 Highest Risk Customers

SELECT

customer_id,

credit_score,

annual_income,

existing_debt,

ROUND(
(existing_debt / annual_income) * 100,
2
)

AS debt_to_income_ratio

FROM customers

ORDER BY

credit_score ASC,

debt_to_income_ratio DESC

LIMIT 10;

