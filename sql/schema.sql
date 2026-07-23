-- ==========================================
-- Credit Risk Analytics Platform Database
-- ==========================================

DROP DATABASE IF EXISTS credit_risk_db;

CREATE DATABASE credit_risk_db;

USE credit_risk_db;

-- ==========================================
-- BRANCHES TABLE
-- ==========================================

CREATE TABLE branches (

    branch_id INT PRIMARY KEY,

    branch_name VARCHAR(100) NOT NULL,

    city VARCHAR(50) NOT NULL,

    state VARCHAR(50) NOT NULL

);

-- ==========================================
-- CUSTOMERS TABLE
-- ==========================================

CREATE TABLE customers (

    customer_id INT PRIMARY KEY,

    branch_id INT NOT NULL,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    gender VARCHAR(10),

    date_of_birth DATE,

    phone VARCHAR(20),

    email VARCHAR(100),

    city VARCHAR(50),

    state VARCHAR(50),

    employment_status VARCHAR(30),

    annual_income DECIMAL(12,2),

    existing_debt DECIMAL(12,2),

    credit_score INT,

    created_at DATE,

    CONSTRAINT fk_customer_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)

);

-- ==========================================
-- LOANS TABLE
-- ==========================================

CREATE TABLE loans (

    loan_id INT PRIMARY KEY,

    customer_id INT NOT NULL,

    loan_amount DECIMAL(12,2),

    interest_rate DECIMAL(5,2),

    loan_term_months INT,

    loan_type VARCHAR(50),

    loan_purpose VARCHAR(100),

    application_date DATE,

    approval_status VARCHAR(20),

    loan_status VARCHAR(20),

    CONSTRAINT fk_loan_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)

);

-- ==========================================
-- REPAYMENTS TABLE
-- ==========================================

CREATE TABLE repayments (

    payment_id INT PRIMARY KEY,

    loan_id INT NOT NULL,

    payment_date DATE,

    amount_paid DECIMAL(12,2),

    remaining_balance DECIMAL(12,2),

    payment_status VARCHAR(20),

    CONSTRAINT fk_payment_loan
        FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)

);

-- ==========================================
-- INDEXES
-- ==========================================

CREATE INDEX idx_customer_credit
ON customers(credit_score);

CREATE INDEX idx_customer_income
ON customers(annual_income);

CREATE INDEX idx_customer_branch
ON customers(branch_id);

CREATE INDEX idx_loan_customer
ON loans(customer_id);

CREATE INDEX idx_loan_status
ON loans(loan_status);

CREATE INDEX idx_loan_type
ON loans(loan_type);

CREATE INDEX idx_loan_application_date
ON loans(application_date);

CREATE INDEX idx_payment_loan
ON repayments(loan_id);

CREATE INDEX idx_payment_status
ON repayments(payment_status);

CREATE INDEX idx_payment_date
ON repayments(payment_date);