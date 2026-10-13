I analysed 98,000+ Indian job postings to answer 
one question: what should a fresher learn to get a Data Analyst job? 
📊 I cleaned the data with Python, designed a 6-table MySQL database, wrote SQL queries (JOINs, CTEs, window functions) and built an interactive Power BI dashboard. 
What I found: 
🔹 Python is the most demanded skill (1,725 jobs), followed by SQL (980) 
🔹 Bengaluru has the most data amp; AI openings (1,101), then Hyderabad (842) 
🔹 Data Engineer is the largest role category in the dataset
 Limitations: only about 900 jobs show a salary, and job categories come from title keywords, so I treat the salary results with care. 
 # Bengaluru AI & Data Job Market Analysis Using MySQL

## 📌 Project Overview

This project analyzes job market data using MySQL to identify in-demand skills, salary trends, hiring companies, job categories, and work modes. It focuses on AI and data-related career opportunities and helps job seekers understand industry requirements.

## 🎯 Project Objectives

- Analyze job opportunities across different categories and cities.
- Identify the most in-demand skills for Data Analyst and AI/ML roles.
- Compare average salaries across job categories and experience levels.
- Identify companies with the highest number of job postings.
- Analyze job distribution across remote, hybrid, and on-site work modes.
- Find entry-level Data Analyst opportunities in Bengaluru.

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Tool:** MySQL Workbench
- **Language:** SQL
- **Data Import:** CSV files using `LOAD DATA INFILE`

## 🗂️ Database Schema

The project contains six relational tables:

1. `location` – Stores city and work-mode information.
2. `company` – Stores company names, ratings, and review counts.
3. `job_category` – Stores job categories and AI-related classifications.
4. `skill` – Stores skill names and skill categories.
5. `job_posting` – Stores job titles, experience levels, salaries, and related IDs.
6. `job_skill` – Maps job postings to their required skills.

Primary keys and foreign keys are used to establish relationships between the tables.

## 📊 SQL Analysis Performed

- Job count by category and city.
- Top 15 most demanded skills.
- Top 10 skills required for Data Analyst roles.
- Average salary by job category and experience level.
- Maximum salary by experience level.
- Top hiring companies by city.
- Job distribution by work mode.
- Job category comparison across Bengaluru, Hyderabad, and Pune.
- Entry-level Data Analyst jobs in Bengaluru.
- Top five demanded skills within each job category.
- Companies with high ratings and multiple job postings.

## 💡 SQL Concepts Used

- DDL, DML, and DQL
- CREATE, ALTER, DROP, and INSERT statements
- Primary keys and foreign keys
- INNER JOIN and LEFT JOIN
- Aggregate functions: `COUNT()`, `AVG()`, `SUM()`, and `MAX()`
- `GROUP BY`, `HAVING`, and `ORDER BY`
- Common Table Expressions (CTEs)
- Window functions: `DENSE_RANK()`
- Stored procedures with input parameters
- Subqueries
- Conditional aggregation
- CSV data import and data validation

## ⚙️ Stored Procedures

The project includes three stored procedures:

1. `top_skills_by_category` – Retrieves the most demanded skills for a selected job category.
2. `jobs_by_city_category` – Retrieves job opportunities for a specified city and job category.
3. `salary_by_experience` – Calculates salary summaries for different experience levels within a selected category.

## 📈 Key Outcomes

- Identified the most frequently required skills across job postings.
- Compared salary trends across job categories and experience levels.
- Examined job opportunities across multiple cities and work modes.
- Created reusable stored procedures for dynamic job market analysis.
- Practiced relational database design and advanced SQL querying.

## 🚀 Conclusion

This project demonstrates my practical SQL skills in database design, data loading, data validation, relational joins, aggregation, window functions, and stored procedures. It helped me understand how SQL can be used to analyze job market trends and support data-driven career decisions.


