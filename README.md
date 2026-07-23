# Credit Risk Analytics Platform

Dashboard Link: https://app.powerbi.com/groups/me/reports/8365c7fd-9903-45ca-b16a-cbba0e95f692/740747ffcb02818030dc?experience=power-bi

A data analytics project that simulates a lending environment and provides an interactive Power BI dashboard for monitoring loan portfolios, customer credit profiles, repayment status, and approval trends.

The project follows a complete workflow starting from synthetic data generation in Python, loading the data into MySQL, creating SQL views for reporting, and building interactive dashboards in Power BI using DAX measures.

---

## Project Overview

Banks and lending institutions rely on historical loan and customer information to monitor portfolio performance and identify potential credit risks. Instead of analyzing thousands of records manually, dashboards allow business users to quickly understand lending activity, approval rates, repayment behaviour, and customer risk.

This project demonstrates that workflow using a simulated banking dataset.

The project includes:

- Synthetic data generation using Python
- Relational database design in MySQL
- SQL views for reporting
- Data modelling in Power BI
- DAX measures for business metrics
- Interactive dashboards with slicers and drill-down capability

---

## Technology Stack

| Tool | Purpose |
|------|---------|
| Python | Data generation |
| Pandas | Data processing |
| Faker | Synthetic customer data |
| MySQL | Database |
| SQL | Views and reporting queries |
| Power BI | Dashboard development |
| DAX | Business calculations |

---

## Project Workflow

```
Python Scripts
        │
        ▼
CSV Files
        │
        ▼
MySQL Database
        │
        ▼
SQL Views
        │
        ▼
Power BI
        │
        ▼
Interactive Dashboard
```

---

## Database

The database contains four main tables.

### Customers

Stores customer demographic and financial information.

Important fields

- Customer ID
- Credit Score
- Annual Income
- Existing Debt
- Employment Status
- Branch

---

### Loans

Stores loan applications and loan details.

Important fields

- Loan Amount
- Loan Type
- Interest Rate
- Loan Term
- Approval Status
- Loan Status
- Application Date

---

### Repayments

Contains repayment history for issued loans.

Important fields

- Payment Date
- Amount Paid
- Remaining Balance
- Payment Status

---

### Branches

Contains branch information.

- Branch Name
- City
- State

---

## SQL Layer

The project uses SQL for:

- Creating database schema
- Loading generated data
- Creating reporting views
- Business queries

Example business questions answered using SQL:

- Total loan portfolio
- Number of approved loans
- Defaulted loans
- Portfolio by state
- Customer risk summary
- Repayment summary

---

## Power BI Dashboard

The dashboard is divided into multiple report pages.

### Executive Overview

Provides a summary of overall lending activity.

Includes

- Total Customers
- Total Loans
- Portfolio Value
- Approval Rate
- Default Rate
- Average Credit Score
- Monthly Loan Applications
- Loan Status Distribution
- Portfolio by State
- Loan Type Distribution

---

### Risk Analysis

Focuses on customer credit quality.

Includes

- Credit Score Distribution
- Customer Risk Segments
- Default Analysis
- Credit Score Bands

---

### Loan Portfolio Analysis

Provides insights into the loan book.

Includes

- Portfolio by Loan Type
- Loan Status
- Repayment Performance
- Portfolio Distribution

---

## Power BI Features

The report includes

- Data Model
- Relationships
- Power Query transformations
- DAX Measures
- Interactive slicers
- Cross filtering
- Drill-down visuals

---

## DAX Measures

Some of the measures used in the dashboard include:

- Total Customers
- Total Loans
- Approved Loans
- Defaulted Loans
- Approval Rate
- Default Rate
- Average Credit Score
- Average Interest Rate
- Average Loan Amount
- Portfolio Value

---

## Folder Structure

```
credit-risk-analytics-platform/

│

├── data/
│   └── raw/
│       ├── branches.csv
│       ├── customers.csv
│       ├── loans.csv
│       └── repayments.csv
│
├── powerbi/
│   └── credit-risk-analytics-platform.pbix
│
├── scripts/
│   ├── generate_data.py
│   └── load_data.py
│
├── sql/
│   ├── schema.sql
│   ├── views.sql
│   └── queries.sql
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## Running the Project

### 1. Clone the repository

```bash
git clone https://github.com/vijaykumardandu/credit-risk-analytics-platform.git
```

---

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

---

### 3. Generate the dataset

```bash
python scripts/generate_data.py
```

---

### 4. Create the MySQL database

Run

```
sql/schema.sql
```

using MySQL Workbench.

---

### 5. Load the generated CSV files

```bash
python scripts/load_data.py
```

---

### 6. Execute SQL views

Run

```
sql/views.sql
```

in MySQL Workbench.

---

### 7. Open Power BI

Open

```
powerbi/credit-risk-analytics-platform.pbix
```

Refresh the data source and explore the dashboard.

---

## Screenshots

### Executive Dashboard

<img width="2192" height="1244" alt="Screenshot 2026-07-23 170326" src="https://github.com/user-attachments/assets/e96dbfb9-5e40-46af-b548-2067680b7620" />



### Risk Analysis

<img width="1708" height="662" alt="Screenshot 2026-07-23 170339" src="https://github.com/user-attachments/assets/a27ea6cf-1eca-434f-b0bf-f90d3c23ea89" />


---

### Branch Performance

<img width="1112" height="584" alt="Screenshot 2026-07-23 170348" src="https://github.com/user-attachments/assets/75e67c71-1dd4-437a-aac1-fbb28913f53b" />



## Repository Contents

- Python scripts for data generation
- MySQL schema and reporting views
- Raw datasets
- Power BI report
- Project documentation

---

## Future Improvements

Some possible extensions for the project include:

- Adding incremental data refresh
- Including branch-level security
- Building a default prediction model
- Automating data loading using scheduled jobs
- Publishing the report to Power BI Service

---

## Author

**Vijay Kumar Dandu**

GitHub

https://github.com/vijaykumardandu
