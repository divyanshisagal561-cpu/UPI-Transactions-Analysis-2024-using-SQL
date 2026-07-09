#  UPI Transactions Analysis using SQL

<p align="center">

</p>

---

##  About the Project

This project is a comprehensive SQL analysis of a **UPI Transactions 2024** dataset using **MySQL**. It demonstrates practical SQL skills required for Data Analyst and SQL Developer roles by covering the complete data analysis workflow—from database creation and data cleaning to advanced SQL queries and business insights.

The project is designed to simulate real-world financial transaction analysis and showcases SQL techniques commonly used in the banking and digital payments industry.

---

#  Project Objectives

* Design and create a relational database
* Import and validate transaction data
* Clean and preprocess raw data
* Perform exploratory data analysis (EDA)
* Answer business-related questions using SQL
* Practice advanced SQL concepts
* Generate meaningful business insights
* Build a portfolio-ready SQL project

---

#  Technologies Used

| Tool                | Purpose                               |
| ------------------- | ------------------------------------- |
| **MySQL**           | Database Management System            |
| **MySQL Workbench** | Query Execution & Database Management |
| **SQL**             | Data Analysis & Reporting             |

---

#  Dataset Information


## UPI Transactions Table

| Column                | Data Type | Description           |
| --------------------- | --------- | --------------------- |
| transaction_id        | INT       | Primary Key           |
| transaction_date      | DATE      | Transaction Date      |
| transaction_timestamp | DATETIME  | Transaction Timestamp |
| sender_bank           | VARCHAR   | Sender Bank           |
| receiver_bank         | VARCHAR   | Receiver Bank         |
| amount                | DECIMAL   | Transaction Amount    |
| transaction_type      | VARCHAR   | Debit / Credit        |
| transaction_status    | VARCHAR   | Success / Failed      |
| payment_method        | VARCHAR   | Payment Method        |
| merchant_category     | VARCHAR   | Merchant Category     |
| state                 | VARCHAR   | State                 |
| device_type           | VARCHAR   | Device Used           |
| network_type          | VARCHAR   | Network Type          |
| fraud_flag            | INT       | Fraud Indicator       |

---

#  Project Workflow

```
Database Creation
        │
        ▼
Data Import
        │
        ▼
Data Cleaning
        │
        ▼
Exploratory Data Analysis
        │
        ▼
Basic SQL Queries
        │
        ▼
Intermediate SQL Queries
        │
        ▼
Advanced SQL
        │
        ▼
Views & Indexes
        │
        ▼
Window Functions
        │
        ▼
Business Insights
        │
        ▼
Executive Summary
```

---

#  SQL Topics Covered

## 1️⃣ Database & Table Creation (DDL)

* CREATE DATABASE
* CREATE TABLE
* Data Types
* Constraints

---

## 2️⃣ Data Import

* CSV Import
* Data Validation

---

## 3️⃣ Data Cleaning

* Duplicate Detection
* Missing Value Checks
* Blank Value Checks
* Data Validation
* Date Validation
* Month & Quarter Validation
* Data Quality Checks

---

## 4️⃣ Exploratory Data Analysis (EDA)

* Total Transactions
* Total Revenue
* Average Transaction Amount
* Minimum & Maximum Amount
* Successful vs Failed Transactions
* Transaction Distribution
* Merchant Analysis

---

## 5️⃣ Basic SQL

* SELECT
* WHERE
* DISTINCT
* ORDER BY
* LIMIT
* BETWEEN
* IN
* LIKE
* IS NULL

---

## 6️⃣ Intermediate SQL

* GROUP BY
* HAVING
* Aggregate Functions
* CASE Statements
* String Functions
* Date Functions

---

## 7️⃣ Advanced SQL

* Subqueries
* Correlated Subqueries
* EXISTS
* NOT EXISTS
* Common Table Expressions (CTEs)

---

## 8️⃣ Views

Created reusable SQL views for reporting purposes.

Examples include:

* Successful Transactions
* Monthly Revenue
* Bank Summary

---

## 9️⃣ Indexes

Created indexes to improve query performance on frequently searched columns.

---

## 🔟 Window Functions

Implemented advanced analytical functions:

* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* LAG()
* LEAD()
* NTILE()
* FIRST_VALUE()
* LAST_VALUE()

---

# Business Insights Generated

This project answers several real-world business questions, including:

* Total Revenue Generated
* Total Successful Transactions
* Total Failed Transactions
* Fraud Analysis
* Top Sender Banks
* Top Receiver Banks
* Monthly Revenue Trend
* Month-over-Month Growth
* Revenue Contribution by Banks
* Merchant Category Performance
* State-wise Transaction Analysis
* Success Rate by State
* Fraud Rate by State
* Peak Transaction Hours
* Most Preferred Bank by State
* Quarterly Revenue Comparison
* Executive Summary Dashboard

---

#  SQL Skills Demonstrated

* Database Design
* Data Cleaning
* Data Validation
* Aggregate Functions
* CASE Statements
* GROUP BY & HAVING
* String Functions
* Date Functions
* Subqueries
* Correlated Subqueries
* EXISTS / NOT EXISTS
* Common Table Expressions (CTEs)
* Views
* Indexes
* Window Functions
* Business Analytics
* Report Generation

---

#  Repository Structure

```
UPI-Transactions-SQL-Project/
│
├── README.md
├── upi_transactions_2024.sql
├── upi_transactions_2024.csv
├── screenshots.png
```

---

# Sample Queries

### Find Total Revenue

```sql
SELECT SUM(amount) AS Total_Revenue
FROM upi_transactions;
```

---

### Top 5 Sender Banks by Transaction Amount

```sql
SELECT
    sender_bank,
    SUM(amount) AS Total_Amount
FROM upi_transactions
GROUP BY sender_bank
ORDER BY Total_Amount DESC
LIMIT 5;
```

---

### Monthly Revenue

```sql
SELECT
    YEAR(transaction_date) AS Year,
    MONTH(transaction_date) AS Month,
    SUM(amount) AS Total_Revenue
FROM upi_transactions
GROUP BY Year, Month
ORDER BY Year, Month;
```

---


#  Skills Demonstrated

* SQL Programming
* Data Cleaning
* Data Analysis
* Financial Data Analysis
* Banking Analytics
* Query Optimization
* Business Intelligence
* Problem Solving
* Analytical Thinking

---

# Author

**Divyanshi Sagal**

---

#  Support

If you found this project helpful or interesting, please consider giving this repository a **⭐ Star**.

It helps others discover the project and motivates future improvements.

---

# Contributions

Suggestions and improvements are welcome.

---


## License

This project is created for **educational and portfolio purposes**.
