Online Bookstore Database Project

 📚Project Overview:

This project is an Online Bookstore Database developed using Oracle SQL and Oracle SQL Developer.

The database is designed to manage books, authors, genres, customers, orders, and order details. It demonstrates database design, relationships, SQL queries, views, indexes, and query optimization.

🛠️ Tools Used:

- Oracle SQL
- Oracle SQL Developer
- GitHub

🗂️ Database Tables:

The project contains the following tables:

1. Authors
2. Genres
3. Books
4. Customers
5. Orders
6. Order_Details

🔗 Table Relationships:

- Authors → Books
- Genres → Books
- Customers → Orders
- Orders → Order_Details
- Books → Order_Details

These relationships help maintain data consistency and connect customers, orders, and book information.

👁️ Views Created:

The project includes the following views:

- Books by Author
- Book Total Sales
- Customer Order History

These views simplify frequently used queries and make data easier to analyze.

🔍 SQL Queries:

The project demonstrates:

- SELECT statements
- JOIN operations
- GROUP BY
- Aggregate functions
- ORDER BY
- Filtering
- Top 5 best-selling books
- Customer order history
- Book and author information

⚡ Indexing and Query Optimization:

Indexes were created on important columns to support efficient searching and joining.

The project also uses `EXPLAIN PLAN` to analyze how Oracle executes SQL queries.

📁 Project Structure:

text
Online_Bookstore_Database_Project/
│
├── 01_SQL_Script/
│   └── Online_Bookstore_Database.sql
│
├── 02_Screenshots/
│   └── Project screenshots
│
└── 03_Project_Report/
    └── Online_Bookstore_Database_Report.pdf

🎯 Project Objectives:
- Design a relational database for an online bookstore
- Create tables using primary and foreign keys
- Perform SQL queries using joins and aggregate functions
- Create views for commonly used queries
- Implement indexes and analyze query execution

👩‍💻 Author
Gnana Sri
