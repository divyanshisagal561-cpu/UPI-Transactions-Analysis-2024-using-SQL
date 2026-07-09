/*
====================================================================================================================================================================================
UPI TRANSACTIONS ANALYSIS USING SQL

Author      : Divyanshi Sagal
Database    : MySQL
Dataset     : UPI Transactions 2024
Project Type: SQL Portfolio Project

====================================================================================================================================================================================
*/
-- =================================================================================================================================================================================
-- Part 1: Database Creation (DDL)
-- =================================================================================================================================================================================
-- 1.1 : Create a database named upi.
CREATE DATABASE IF NOT EXISTS upi; 
-- 1.2 : Use created database. 
USE upi ;
-- 1.3 : Add a Primary Key on transaction_id.
ALTER TABLE upi_transactions ADD PRIMARY KEY(transaction_id) ;
-- 1.4 : Describe the table structure and verify all column data types.
DESCRIBE upi_transactions ;
-- ================================================================================================================================================================================= 
-- Part 2: Data Import
-- =================================================================================================================================================================================
-- 2.1 : Show entire data. 
SELECT *
FROM upi_transactions ;
-- 2.2 : Display the first 10 rows.
SELECT *
FROM upi_transactions 
ORDER BY transaction_id 
LIMIT 10 ;
-- 2.3 : Display the last 10 rows.
SELECT *
FROM upi_transactions 
ORDER BY transaction_id DESC
LIMIT 10 ;
-- 2.4 : Verify the total number of imported records.
SELECT COUNT(*) AS total_number_record
FROM upi_transactions ;
-- ================================================================================================================================================================================= 
-- Part 3: Data Cleaning
-- ================================================================================================================================================================================= 
-- 3.1 : Check Invalid Month Names.
SELECT *
FROM upi_transactions
WHERE MONTHNAME(transaction_date) <> month_name ;
-- 3.2 : Remove Leading and Trailing Spaces.
UPDATE upi_transactions
SET sender_bank = TRIM(sender_bank);
-- 3.3 : Check duplicate transaction IDs.
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM upi_transactions
GROUP BY transaction_id
HAVING duplicate_count > 1;
-- 3.4 : Find NULL values in every column.
SELECT *
FROM upi_transactions
WHERE transaction_id IS NULL OR  
transaction_timestamp IS NULL OR  
transaction_type IS NULL OR  
merchant_category IS NULL OR  
amount IS NULL OR  
transaction_status IS NULL OR  
sender_age_group  IS NULL OR  
receiver_age_group IS NULL OR   
sender_state IS NULL OR  
sender_bank IS NULL OR  
receiver_bank IS NULL OR   
device_type IS NULL OR   
network_type IS NULL OR      
fraud_flag IS NULL OR  
year IS NULL OR  
month IS NULL OR   
month_name IS NULL OR   
quarter IS NULL OR   
transaction_date IS NULL ;   
-- 3.5 : onvert sender bank names to uppercase.
SELECT UPPER(sender_bank) AS uppercase
FROM upi_transactions ;
-- 3.6 : Check unique sender banks.
SELECT DISTINCT sender_bank 
FROM upi_transactions ;
-- 3.7 : Check unique receiver banks.
SELECT DISTINCT receiver_bank 
FROM upi_transactions ;
-- 3.8 : Check unique merchant categories.
SELECT DISTINCT merchant_category 
FROM upi_transactions ;
-- 3.9 : Check unique transaction statuses.
SELECT DISTINCT transaction_status 
FROM upi_transactions ;
-- 3.10 : Find transactions with negative amounts.
SELECT amount
FROM upi_transactions 
WHERE amount < 0 ;
-- 3.11 : Find transactions having zero amount.
SELECT amount
FROM upi_transactions 
WHERE amount = 0 ;
-- 3.12 : Find unusually high-value transactions (> ₹1,00,000).
SELECT amount
FROM upi_transactions 
WHERE amount > 100000 ;
-- 3.13 : Verify fraud_flag contains only valid values.
SELECT fraud_flag
FROM upi_transactions 
WHERE fraud_flag NOT IN (1, 0) ;
--  3.14 : Validate month values using transaction date.
SELECT MONTH(transaction_date) AS months
FROM upi_transactions
WHERE MONTH(transaction_date) <> month;
-- ================================================================================================================================================================================= 
-- Part 4: Exploratory Data Analysis
-- ================================================================================================================================================================================= 
-- 4.1 : Calculate total transaction amount.
SELECT SUM(amount) AS total_transaction_amount
FROM upi_transactions ;
-- 4.2 : Calculate average transaction amount.
SELECT AVG(amount) AS average_transaction_amount
FROM upi_transactions ;
-- 4.3 : Find highest transaction amount.
SELECT MAX(amount) AS highest_transaction_amount
FROM upi_transactions ;
-- 4.4 : Find lowest transaction amount.
SELECT MIN(amount)  AS lowest_transaction_amount
FROM upi_transactions ;
-- 4.5 : Count successful and failed transactions.
SELECT transaction_status, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY transaction_status ;
-- 4.6 : Find total transactions by transaction type.
SELECT transaction_type, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY transaction_type ;
-- 4.7 : Find total transactions by merchant category.
SELECT merchant_category, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY merchant_category ;
-- 4.8 : Find total transactions by device type. 
SELECT device_type, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY device_type ;
-- 4.9 : Find total transactions by network type. 
SELECT network_type, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY network_type ;
-- ================================================================================================================================================================================= 
-- Part 5: Basic SQL
-- ================================================================================================================================================================================= 
-- 5.1 : Display all successful transactions. 
SELECT *
FROM upi_transactions
WHERE transaction_status = "SUCCESS" ;
-- 5.2 : Find transactions where amount > 5000.
SELECT *
FROM upi_transactions
WHERE amount > 5000 ;
-- 5.3 : Display transactions from Maharashtra.
SELECT *
FROM upi_transactions
WHERE sender_state = "Maharashtra" ;
-- 5.4 : Find all debit transactions.
SELECT *
FROM upi_transactions
WHERE transaction_type = "Debit" ;
-- 5.5 : Display only transaction ID, amount and sender bank.
SELECT transaction_id, amount, sender_bank
FROM upi_transactions ;
-- 5.6 : Sort transactions by amount descending.
SELECT *
FROM upi_transactions
ORDER BY amount DESC ;
-- 5.7 : Display the top 20 highest-value transactions.
SELECT *
FROM upi_transactions
ORDER BY amount DESC
LIMIT 20 ;
-- 5.8 : Find transactions between ₹1000 and ₹5000.
SELECT *
FROM upi_transactions
WHERE amount BETWEEN 1000 AND 5000 ;
-- 5.9 : Find transactions from SBI.
SELECT *
FROM upi_transactions
WHERE receiver_bank = "SBI" ;
-- 5.10 : Display all fraud transactions. 
SELECT *
FROM upi_transactions
WHERE fraud_flag = 1 ;
-- ================================================================================================================================================================================= 
-- Part 6: Intermediate SQL
-- ================================================================================================================================================================================= 
-- 6.1 : Calculate total amount by sender bank. 
SELECT SUM(amount) AS total_amount, sender_bank
FROM upi_transactions 
GROUP BY sender_bank ;
-- 6.2 : Calculate average amount by merchant category.
SELECT AVG(amount) AS avg_amount, merchant_category
FROM upi_transactions
GROUP BY merchant_category ;
-- 6.3 : Count transactions for each sender state.
SELECT COUNT(*) AS total_transactions, sender_state
FROM upi_transactions
GROUP BY sender_state ;   
-- 6.4 : Find banks having more than 100 transactions.
SELECT sender_bank, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY sender_bank 
HAVING  COUNT(*) > 100 ;
-- 6.5 : Find merchant categories having average transaction amount above ₹600. 
SELECT merchant_category, AVG(amount) AS amount_transactions
FROM upi_transactions
GROUP BY merchant_category
HAVING  AVG(amount) > 600 ;
-- 6.6 : Find monthly transaction count.
SELECT month, COUNT(*) AS total_transactions
FROM upi_transactions 
GROUP BY month ; 
-- 6.7 : Find quarterly revenue.
SELECT quarter, SUM(amount) AS revenue
FROM upi_transactions 
GROUP BY quarter
ORDER BY quarter ; 
-- 6.8 : Find total revenue by device type.
SELECT device_type, SUM(amount) AS total_revenue
FROM upi_transactions 
GROUP BY device_type 
ORDER BY device_type ;  
-- 6.9 : Find transaction status percentage. 
SELECT transaction_status, COUNT(*) AS total_transactions,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM upi_transactions 
GROUP BY transaction_status ;
-- 6.10 : Find the top 5 sender banks by total amount. 
SELECT SUM(amount) AS total_amount, sender_bank
FROM upi_transactions 
GROUP BY sender_bank 
ORDER BY SUM(amount) DESC
LIMIT 5 ;  
-- ================================================================================================================================================================================= 
-- Part 7: Advanced SQL
-- ================================================================================================================================================================================= 
-- 7.1 : Find transactions above overall average amount. 
SELECT *
FROM upi_transactions
WHERE amount > (SELECT AVG(amount) 
				FROM upi_transactions ) ; 
-- 7.2 : Find the highest transaction in every state. 
SELECT sender_state, MAX(amount) AS highest_transaction
FROM upi_transactions
GROUP BY sender_state 
ORDER BY sender_state ;
-- 7.3 : Find sender banks whose average amount is above the overall average. 
SELECT sender_bank, AVG(amount) AS average_transaction_amount
FROM upi_transactions
GROUP BY sender_bank
HAVING AVG(amount) > (SELECT AVG(amount) 
				FROM upi_transactions) ; 
-- 7.4 : Write a CASE statement to classify amounts:
-- Low
-- Medium
-- High 

SELECT *,
CASE
    WHEN amount < 5000 THEN "Low"
    WHEN amount BETWEEN 5000 AND 15000 THEN "Medium"
    ELSE "High"
END AS category
FROM upi_transactions ; 
-- 7.5 : Create a CTE showing monthly revenue.
WITH monthly_revenue AS
	   (SELECT month, month_name, SUM(amount) AS total_revenue
       FROM upi_transactions
       GROUP BY month, month_name)
       
SELECT *
FROM monthly_revenue
ORDER BY month;       
-- 7.6 : Find the top merchant category by revenue.
SELECT merchant_category, SUM(amount) AS revenue 
FROM upi_transactions
GROUP BY merchant_category 
ORDER BY SUM(amount) DESC 
LIMIT 1 ;
-- 7.7 : Find bank-wise fraud percentage.
SELECT sender_bank, COUNT(*) AS total_transactions,
SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_percentage 
FROM upi_transactions
GROUP BY sender_bank 
ORDER BY fraud_percentage DESC ;
-- 7.8 : Find success rate of every sender bank.
SELECT sender_bank, COUNT(*) AS total_transactions,
SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) AS successful_transactions,
ROUND(SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM upi_transactions
GROUP BY sender_bank
ORDER BY success_rate DESC ;
-- 7.9 : Find the month generating highest revenue.
SELECT month, SUM(amount) AS highest_revenue
FROM upi_transactions
GROUP BY month
ORDER BY highest_revenue DESC 
LIMIT 1 ;
-- 7.10 : Find merchant categories contributing more than 10% of total revenue.
SELECT merchant_category, SUM(amount) AS category_revenue,
ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM upi_transactions), 2) AS revenue_percentage
FROM upi_transactions
GROUP BY merchant_category
HAVING revenue_percentage > 10 
ORDER BY revenue_percentage DESC ;
-- 7.11 : Find sender banks that have at least one fraudulent transaction
SELECT DISTINCT sender_bank
FROM upi_transactions AS u1
WHERE EXISTS(
      SELECT 1
      FROM upi_transactions AS u2
	  WHERE u1.transaction_id = u2.transaction_id
      AND fraud_flag = 1) ;
-- 7.12 : Find sender banks that have no fraudulent transactions 
SELECT DISTINCT sender_bank
FROM upi_transactions AS u1
WHERE EXISTS(
      SELECT 1 
      FROM upi_transactions AS u2
      WHERE u1.transaction_id = u2.transaction_id
      AND fraud_flag = 0) ;
-- ================================================================================================================================================================================= 
-- Part 8: Views
-- ================================================================================================================================================================================= 
-- 8.1 : Create view of successful Transactions.
CREATE VIEW successful_transactions AS
			  SELECT 
                    transaction_id, 
                    sender_bank, 
					receiver_bank, 
                    transaction_status, 
                    amount, 
                    transaction_date
              FROM upi_transactions  
			  WHERE transaction_status = "SUCCESS" ;
             
SELECT * 
FROM successful_transactions ;             
-- 8.2 : Bank Summary
CREATE VIEW bank_summary AS
		    SELECT 
                  sender_bank,
                  COUNT(*) AS total_transactions,
                  SUM(amount) AS total_amount,
                  AVG(amount) AS avg_amount
				  FROM upi_transactions  
			      GROUP BY sender_bank ;
                  
SELECT *
FROM bank_summary ;
-- 8.3 : Fraud Transactions
CREATE VIEW fraud_transactions AS 
			SELECT *
            FROM upi_transactions  
            WHERE fraud_flag = 1 ;
            
SELECT *
FROM fraud_transactions ;   
-- 8.4 : Monthly Revenue
CREATE VIEW monthly_revenue AS
            SELECT 
                 YEAR(transaction_date) AS year,
                 MONTH(transaction_date) AS month,
                 SUM(amount) AS revenue
				 FROM upi_transactions 
                 GROUP BY YEAR(transaction_date),  MONTH(transaction_date) ;
                 
SELECT *
FROM upi_transactions  
ORDER BY year, month ; 
-- ================================================================================================================================================================================= 
-- Part 9: Indexes
-- ================================================================================================================================================================================= 
-- 9.1 : Create sender bank index. 
CREATE INDEX idx_sender_bank
ON upi_transactions(sender_bank) ;

-- 9.2 : Create receiver bank index. 
CREATE INDEX idx_receiver_bank
ON upi_transactions(receiver_bank) ;

-- 9.3 : Create transaction date index. 
CREATE INDEX idx_transaction_date
ON upi_transactions(transaction_date) ;

-- 9.4 : Showing all indexes 
SHOW INDEX 
FROM upi_transactions ;
 -- ================================================================================================================================================================================= 
-- Part 10: Window Functions 
-- ================================================================================================================================================================================= 
-- 10.1 : Assign row numbers based on highest transaction amount.
SELECT transaction_id, amount, sender_bank, receiver_bank, 
ROW_NUMBER() OVER(ORDER BY amount DESC) AS row_num
FROM upi_transactions ;
-- 10.2 : Rank transactions by amount.
SELECT amount,
DENSE_RANK() OVER(ORDER BY amount DESC) AS ranking
FROM upi_transactions ;
-- 10.3 : Rank transactions within each sender bank.
SELECT amount, sender_bank,
DENSE_RANK() OVER(PARTITION BY sender_bank ORDER BY amount DESC) AS rank_transactions
FROM upi_transactions ;
-- 10.4 : Find cumulative(running) revenue month-wise.
SELECT month, month_name, SUM(amount) AS monthly_revenue,
SUM(SUM(amount)) OVER(ORDER BY month DESC) AS cumulative_revenue
FROM upi_transactions 
GROUP BY month, month_name
ORDER BY month DESC ;
-- 10.5 : Calculate running total for each sender bank.
SELECT sender_bank, transaction_date, amount,
SUM(amount) OVER(PARTITION BY sender_bank ORDER BY transaction_date DESC) AS running_total
FROM upi_transactions 
ORDER BY sender_bank, transaction_date ;
-- 10.6 : Find previous transaction amount using LAG().
SELECT amount, transaction_date, sender_bank,
LAG(amount) OVER(PARTITION BY sender_bank ORDER BY transaction_date) AS previous_transaction_amount 
FROM upi_transactions 
ORDER BY sender_bank, transaction_date DESC ;
-- 10.7 : Find next transaction amount using LEAD(). 
SELECT amount, transaction_date, sender_bank,
LEAD(amount) OVER(PARTITION BY sender_bank ORDER BY transaction_date DESC) AS next_transaction_amount
FROM upi_transactions
ORDER BY transaction_date, sender_bank DESC ;
-- 10.8 : Find highest transaction within every merchant category using FIRST_VALUE().
SELECT transaction_id, merchant_category, amount, 
FIRST_VALUE(amount) OVER(PARTITION BY merchant_category ORDER BY amount DESC) AS highest_transactions
FROM upi_transactions 
ORDER BY merchant_category, amount ;
-- 10.9 : Divide transactions into four quartiles using NTILE(4).
SELECT transaction_id, amount, merchant_category, sender_bank,
NTILE(4) OVER(ORDER BY amount DESC) AS quartile
FROM upi_transactions
ORDER BY amount ;
-- ================================================================================================================================================================================= 
-- Part 11: Business Insights
-- ================================================================================================================================================================================= 
-- 11.1 : Which sender bank processed the highest number of transactions?
SELECT sender_bank, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY sender_bank 
ORDER BY COUNT(*) DESC ;
-- 11.2 : Which receiver bank received the highest amount?
SELECT receiver_bank, SUM(amount) AS total_received
FROM upi_transactions
GROUP BY receiver_bank
ORDER BY SUM(amount) DESC 
LIMIT 1 ;
-- 11.3 : Which merchant category generated maximum revenue? 
SELECT merchant_category, SUM(amount) AS total_revenue
FROM upi_transactions
GROUP BY merchant_category
ORDER BY SUM(amount) DESC 
LIMIT 1 ;
-- 11.4 : Which state has the highest transaction volume?
SELECT sender_state, COUNT(*) AS total_transactions
FROM upi_transactions
GROUP BY sender_state 
ORDER BY COUNT(*) DESC 
LIMIT 1;
-- 11.5 : Which state generated the highest revenue? 
SELECT sender_state, SUM(amount) AS highest_revenue
FROM upi_transactions
GROUP BY sender_state
ORDER BY SUM(amount) DESC 
LIMIT 1;
-- 11.6 : Which month had the highest transaction count?
SELECT month, month_name, COUNT(*) AS total_transaction
FROM upi_transactions
GROUP BY month, month_name
ORDER BY COUNT(*) DESC 
LIMIT 1;
-- 11.7 : Which month generated the highest revenue?
SELECT month, month_name, SUM(amount) AS total_revenue
FROM upi_transactions
GROUP BY month, month_name
ORDER BY SUM(amount) DESC 
LIMIT 1;
-- 11.8 : What is the success rate of UPI transactions?
SELECT COUNT(*) AS total_transactions,
SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) AS successful_transactions,
ROUND(SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate
FROM upi_transactions ;
-- 11.9 : What percentage of transactions were fraudulent? 
SELECT COUNT(*) AS total_transactions,
SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_percentage
FROM  upi_transactions ;
-- 11.10 : Which bank has the highest fraud rate?
SELECT sender_bank, COUNT(*) AS total_transactions,
SUM(CASE WHEN fraud_flag = "Yes" THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(SUM(CASE WHEN fraud_flag = "Yes" THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM  upi_transactions 
GROUP BY sender_bank 
ORDER BY fraud_rate DESC
LIMIT 1 ;
-- 11.11 : Which age group performs the most transactions?
SELECT sender_age_group, COUNT(*) AS total_transactions
FROM  upi_transactions 
GROUP BY sender_age_group
ORDER BY COUNT(*) DESC
LIMIT 1 ;
-- 11.12 : Which device type is used the most? 
SELECT device_type, COUNT(*) AS total_transactions
FROM  upi_transactions 
GROUP BY device_type
ORDER BY COUNT(*) DESC
LIMIT 1 ;
-- 11.13 : Which network type is used the most?
SELECT network_type, COUNT(*) AS total_transactions
FROM  upi_transactions 
GROUP BY network_type
ORDER BY COUNT(*) DESC
LIMIT 1 ;
-- 11.14 : Find the top 10 highest-value transactions. 
SELECT transaction_id, amount, sender_bank, receiver_bank, transaction_date
FROM  upi_transactions 
ORDER BY amount DESC
LIMIT 10 ;
-- 11.15: Find the top 5 merchant categories by transaction count.
SELECT merchant_category, COUNT(*) AS total_transactions
FROM  upi_transactions 
GROUP BY merchant_category
ORDER BY COUNT(*) DESC
LIMIT 5 ; 
-- 11.16 : Find Top 3 banks by successful transaction amount.
SELECT sender_bank, transaction_status, SUM(amount) AS total_transaction_amount
FROM upi_transactions
WHERE transaction_status = "SUCCESS"
GROUP BY sender_bank 
ORDER BY total_transaction_amount DESC
LIMIT 3 ;
-- 11.17 : Find Average transaction amount by age group.
SELECT sender_age_group, COUNT(*) AS total_transactions, ROUND(AVG(amount), 2) AS avg_transaction_amount
FROM upi_transactions
GROUP BY sender_age_group 
ORDER BY sender_age_group ;
-- 11.18 : Find Fraud rate by device type.
SELECT 
device_type, 
COUNT(*) AS total_transactions,
ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM upi_transactions
GROUP BY device_type 
ORDER BY fraud_rate DESC ;
-- 11.19 : Fraud rate by network type
SELECT 
network_type, 
COUNT(*) AS total_transactions,
ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM upi_transactions
GROUP BY network_type 
ORDER BY fraud_rate DESC ;
-- 11.20 : Find Monthly growth percentage.
WITH monthly_revenue AS
     (SELECT 
            YEAR(transaction_date) AS year,
            month(transaction_date) AS month,
            SUM(amount) AS total_revenue
            FROM upi_transactions
            GROUP BY YEAR(transaction_date), month(transaction_date))

SELECT year, month, total_revenue,
LAG(total_revenue) OVER(ORDER BY year,month) AS previous_month_revenue,
ROUND(total_revenue - LAG(total_revenue) OVER(ORDER BY year,month) / LAG(total_revenue) OVER(ORDER BY year,month) * 100.0, 2) 
AS monthly_growth_percentage 
FROM monthly_revenue ;
-- 11.21 : Find Month-over-Month Revenue Growth.
CREATE VIEW monthly_revenue_2 AS
     SELECT 
            YEAR(transaction_date) AS year,
			MONTH(transaction_date) AS month,
            SUM(amount) AS total_revenue
            FROM upi_transactions
            GROUP BY YEAR(transaction_date), MONTH(transaction_date);
         
SELECT *
FROM monthly_revenue_2 ;
  
SELECT year, month, total_revenue,
LAG(total_revenue) OVER(ORDER BY year, month) AS previous_month_revenue,
ROUND(total_revenue - LAG(total_revenue) OVER(ORDER BY year, month) / LAG(total_revenue) OVER(ORDER BY year, month) * 100.0, 2) 
AS monthy_revenue_growth
FROM  monthly_revenue_2;
-- 11.22 : Find Success Rate by State.
SELECT sender_state, COUNT(*) AS total_transactions,
SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) AS successful_transactions,
ROUND(SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS success_rate
FROM upi_transactions
GROUP BY sender_state
ORDER BY success_rate DESC ;
-- 11.23 : Find Top State for Fraud.
SELECT sender_state, COUNT(*) AS total_fraud_transactions
FROM upi_transactions
WHERE fraud_flag = 1
GROUP BY sender_state
ORDER BY total_fraud_transactions DESC 
LIMIT 1 ;
-- 11.24 : Find Revenue Contribution of Each Bank.
SELECT sender_bank, SUM(amount) AS total_revenue, 
ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER(), 2) AS revenue_contribution_percentage
FROM upi_transactions
GROUP BY sender_bank
ORDER BY revenue_contribution_percentage DESC ;
-- 11.25 : Find Highest Spending Age Group.
SELECT sender_age_group, SUM(amount) AS total_transactions
FROM upi_transactions
GROUP BY sender_age_group
ORDER BY SUM(amount) DESC 
LIMIT 1 ;
-- 11.26 : Find Average Amount by Day of Week.
SELECT DAYOFWEEK(transaction_date) AS day_of_week, AVG(amount) AS avg_amount
FROM upi_transactions
GROUP BY DAYOFWEEK(transaction_date)
ORDER BY AVG(amount) DESC ;
-- ================================================================================================================================================================================= 
-- Part 12: Final Dashboard / Report Queries
-- ================================================================================================================================================================================= 
-- 12.1 : Create a monthly performance report showing:
-- Month
-- Total Transactions
-- Total Revenue
-- Average Transaction Value 
WITH monthly_performance_report AS
       (SELECT month, month_name, COUNT(*) AS total_transactions, SUM(amount) AS total_revenue,
        ROUND(AVG(amount), 2) AS avg_transactions_value
		FROM upi_transactions
        GROUP BY month, month_name)

SELECT *
FROM monthly_performance_report
ORDER BY month ;
-- 12.2 : Create a bank performance report showing:
-- Sender Bank
-- Total Transactions
-- Total Revenue
-- Success Rate
-- Fraud Rate    
WITH bank_performance_report AS
     (SELECT sender_bank, COUNT(*) AS total_transactions, SUM(amount) AS total_revenue,
     SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) AS successful_transactions,
     ROUND(SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS success_rate,
     SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
     ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fraud_rate
     FROM upi_transactions
     GROUP BY sender_bank)

SELECT *
FROM bank_performance_report 
ORDER BY total_revenue DESC ;
-- 12.3 : Create a merchant category report showing:
-- Category
-- Transaction Count
-- Revenue
-- Average Amount 
WITH merchant_category_report AS
	(SELECT merchant_category AS category, COUNT(*) AS transaction_count, SUM(amount) AS revenue,
    ROUND(AVG(amount), 2) AS avg_amount
    FROM upi_transactions
    GROUP BY merchant_category)

SELECT * 
FROM merchant_category_report
ORDER BY revenue DESC ;
-- 12.4 : Create a state-wise dashboard showing:
-- State
-- Transactions
-- Revenue
-- Fraud Count alter
WITH state_wise_dashboard AS
	 (SELECT sender_state AS state, COUNT(*) AS total_transactions, SUM(amount) AS total_revenue, 
     SUM(CASE WHEN fraud_flag = 1 THEN "Fraud" ELSE "Not Fraud" END) AS fraud_count
     FROM upi_transactions
     GROUP BY sender_state)

SELECT *
FROM state_wise_dashboard
ORDER BY total_revenue DESC ;
-- 12.5 : Create an executive summary report containing:
-- Total Transactions
-- Total Revenue
-- Average Transaction Amount
-- Success Rate
-- Fraud Rate
-- Highest Revenue Month
-- Top Sender Bank
-- Top Merchant Category 

WITH executive_summary_report AS
     (SELECT
     (SELECT COUNT(*) 
     FROM upi_transactions) AS total_transactions,
     
     (SELECT SUM(amount) 
     FROM upi_transactions) AS total_revenue,
     
     (SELECT ROUND(AVG(amount), 2) 
     FROM upi_transactions) AS avg_transaction_amount,
     
     (SELECT ROUND(SUM(CASE WHEN transaction_status = "SUCCESS" THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
     FROM upi_transactions) AS success_rate,
     
     (SELECT ROUND(SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
     FROM upi_transactions) AS fraud_rate,
     
     (SELECT month_name 
     FROM upi_transactions 
     GROUP BY month, month_name 
     ORDER BY SUM(amount) DESC LIMIT 1) AS Highest_Revenue_Month,
     
     (SELECT sender_bank 
     FROM upi_transactions 
     GROUP BY sender_bank 
     ORDER BY SUM(amount) DESC LIMIT 1) AS Top_Sender_Bank,
     
	 (SELECT merchant_category
     FROM upi_transactions 
     GROUP BY merchant_category 
     ORDER BY SUM(amount) DESC LIMIT 1) AS Top_Merchant_Category)

SELECT *
FROM executive_summary_report ;

/*
=================================================================================================================================================
                            UPI TRANSACTIONS ANALYSIS PROJECT
================================================================================================================================================

Project Name : UPI Transactions Analysis using SQL
Database     : MySQL
Dataset      : UPI Transactions 2024
Author       : Divyanshi Sagal
Project Type : SQL Data Analysis Portfolio Project

---------------------------------------------------------------------------------------------------------------------------------------------------
PROJECT OBJECTIVE
----------------------------------------------------------------------------------------------------------------------------------------------------
This project analyzes a UPI Transactions dataset to demonstrate SQL skills,
including database creation, data cleaning, exploratory data analysis, advanced
SQL queries, window functions, business insights, and reporting. The project
simulates real-world banking and payment analytics using MySQL.

---------------------------------------------------------------------------------------------------------------------------------------------------
SQL TOPICS COVERED
---------------------------------------------------------------------------------------------------------------------------------------------------
✔ Database Creation (DDL)
✔ Data Import
✔ Data Cleaning
✔ Exploratory Data Analysis (EDA)
✔ Basic SQL Queries
✔ Aggregate Functions
✔ GROUP BY & HAVING
✔ CASE Statements
✔ String Functions
✔ Date Functions
✔ Subqueries
✔ Correlated Subqueries
✔ EXISTS & NOT EXISTS
✔ Common Table Expressions (CTEs)
✔ Views
✔ Indexes
✔ Window Functions
✔ Business Insight Queries
✔ Executive Summary Report

---------------------------------------------------------------------------------------------------------------------------------------------------
KEY BUSINESS QUESTIONS ANSWERED
---------------------------------------------------------------------------------------------------------------------------------------------------
✔ Total Revenue Generated
✔ Total Successful & Failed Transactions
✔ Transaction Trends by Month
✔ Top Sender & Receiver Banks
✔ Revenue Contribution by Banks
✔ Merchant Category Performance
✔ State-wise Transaction Analysis
✔ Fraud Analysis
✔ Success Rate by State
✔ Peak Transaction Hours
✔ Monthly Growth Percentage
✔ Most Preferred Bank by State
✔ Quarterly Revenue Analysis
✔ Executive Dashboard Metrics

---------------------------------------------------------------------------------------------------------------------------------------------------
SQL CONCEPTS DEMONSTRATED
---------------------------------------------------------------------------------------------------------------------------------------------------
✔ SELECT, WHERE, ORDER BY
✔ GROUP BY & HAVING
✔ CASE Expressions
✔ Aggregate Functions
✔ JOIN-ready Queries
✔ Subqueries
✔ Correlated Subqueries
✔ EXISTS / NOT EXISTS
✔ CTEs
✔ Views
✔ Indexes
✔ ROW_NUMBER()
✔ RANK()
✔ DENSE_RANK()
✔ LAG()
✔ LEAD()
✔ NTILE()
✔ FIRST_VALUE()
✔ LAST_VALUE()

---------------------------------------------------------------------------------------------------------------------------------------------------
PROJECT OUTCOME
---------------------------------------------------------------------------------------------------------------------------------------------------
This project demonstrates practical SQL skills for analyzing financial
transaction data. It showcases the ability to clean data, perform exploratory
analysis, generate business insights, optimize queries, and create analytical
reports using MySQL.

========================================================================================================================================================
                              END OF PROJECT
=========================================================================================================================================================
*/-- 











