-- =====================================================
-- CREDIT RISK ANALYTICS PLATFORM
-- Business Views
-- =====================================================

USE credit_risk_db;

-- Customer Risk Summary

DROP VIEW IF EXISTS customer_risk_summary;

CREATE VIEW customer_risk_summary AS

SELECT

    c.customer_id,

    CONCAT(c.first_name,' ',c.last_name) AS customer_name,

    c.city,

    c.state,

    c.employment_status,

    c.annual_income,

    c.existing_debt,

    c.credit_score,

    ROUND(
        (c.existing_debt / c.annual_income) * 100,
        2
    ) AS debt_to_income_ratio,

    COUNT(l.loan_id) AS total_loans,

    ROUND(
        SUM(l.loan_amount),
        2
    ) AS total_loan_amount

FROM customers c

LEFT JOIN loans l
ON c.customer_id = l.customer_id

GROUP BY

    c.customer_id;


SELECT *
FROM customer_risk_summary
LIMIT 10;

-- Loan Portfolio Summary

DROP VIEW IF EXISTS loan_portfolio_summary;

CREATE VIEW loan_portfolio_summary AS

SELECT

    loan_type,

    loan_status,

    COUNT(*) AS total_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_portfolio,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount,

    ROUND(
        AVG(interest_rate),
        2
    ) AS average_interest_rate

FROM loans

GROUP BY

    loan_type,

    loan_status;

SELECT *
FROM loan_portfolio_summary;

-- Branch Performance Summary

DROP VIEW IF EXISTS branch_performance_summary;

CREATE VIEW branch_performance_summary AS

SELECT

    b.branch_name,

    b.city,

    COUNT(DISTINCT c.customer_id) AS total_customers,

    COUNT(l.loan_id) AS total_loans,

    ROUND(
        SUM(l.loan_amount),
        2
    ) AS portfolio_value,

    ROUND(
        AVG(c.credit_score),
        2
    ) AS average_credit_score

FROM branches b

LEFT JOIN customers c
ON b.branch_id = c.branch_id

LEFT JOIN loans l
ON c.customer_id = l.customer_id

GROUP BY

    b.branch_id;

SELECT *
FROM branch_performance_summary;

-- Repayment Summary

DROP VIEW IF EXISTS repayment_summary;

CREATE VIEW repayment_summary AS

SELECT

    loan_id,

    COUNT(*) AS total_payments,

    SUM(
        CASE
            WHEN payment_status='Paid'
            THEN 1
            ELSE 0
        END
    ) AS successful_payments,

    SUM(
        CASE
            WHEN payment_status='Missed'
            THEN 1
            ELSE 0
        END
    ) AS missed_payments,

    ROUND(
        SUM(amount_paid),
        2
    ) AS total_amount_paid,

    ROUND(
        AVG(remaining_balance),
        2
    ) AS average_remaining_balance

FROM repayments

GROUP BY loan_id;

SELECT *
FROM repayment_summary;



-- =====================================================
-- CREDIT RISK DASHBOARD VIEW
-- =====================================================

DROP VIEW IF EXISTS credit_risk_dashboard;

CREATE VIEW credit_risk_dashboard AS

SELECT

    c.customer_id,

    CONCAT(c.first_name,' ',c.last_name) AS customer_name,

    b.branch_name,

    b.city AS branch_city,

    b.state AS branch_state,

    c.gender,

    c.employment_status,

    c.annual_income,

    c.existing_debt,

    c.credit_score,

    ROUND(
        (c.existing_debt/c.annual_income)*100,
        2
    ) AS debt_to_income_ratio,

    l.loan_id,

    l.loan_type,

    l.loan_purpose,

    l.loan_amount,

    l.interest_rate,

    l.loan_status,

    l.approval_status,

    l.application_date

FROM customers c

JOIN branches b
ON c.branch_id = b.branch_id

LEFT JOIN loans l
ON c.customer_id = l.customer_id;

SELECT *
FROM credit_risk_dashboard
LIMIT 20;