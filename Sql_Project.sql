-- Project Title: Bookstore Database Analysis and Management

/*
Problem:
Bookstores deal with large volumes of data (books, customers, orders, stock).
Without proper data analysis, making effective business decisions is difficult.
This project uses SQL queries on a relational database to analyze sales, inventory, 
and customer behavior for better operational efficiency and profitability.

Objectives:
- To analyze bookstore data including books, customers, orders, and stock information.
- To identify sales and stock details across different book genres.
- To understand customer buying behavior and order patterns.
- To optimize inventory management to avoid stockouts and overstocking.
- To analyze revenue and sales trends for informed business decision-making.

Technology:
- PostgreSQL (or any relational DBMS) for database management.
- SQL for data querying, aggregation, and analysis.
- CSV import for populating tables with real data.
*/


-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- Sample Selects (to check tables)
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:/Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:/Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:/Orders.csv' 
CSV HEADER;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year > 1950;

-- 3) List all customers from Canada:
SELECT * FROM Customers 
WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books 
ORDER BY Price DESC 
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders 
WHERE Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE Total_Amount > 20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY Stock 
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Revenue 
FROM Orders;

-- Advanced Questions:

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders AS o
JOIN Books AS b 
ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders AS o
JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 4) Find the most frequently ordered book:
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders AS o
JOIN Books AS b 
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' genre:
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders AS o
JOIN Books AS b 
ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City
FROM Orders AS o
JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- 8) Find the customer who spent the most on orders:
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders AS o
JOIN Customers AS c 
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity), 0) AS Order_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books AS b
LEFT JOIN Orders AS o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;



/*
Challenges:
- Handling multi-table joins efficiently (Books, Orders, Customers).
- Ensuring data consistency during import and querying.
- Managing NULLs and missing data (using COALESCE where needed).


Future Scope:
- Integrate predictive analytics to forecast sales and demand trends.
- Develop a recommendation system for personalized book suggestions.
- Optimize queries for scalability with larger datasets.
- Implement dashboards for real-time business insights.


Conclusion:
The SQL queries provided allow deep analysis of bookstore data by genre, author, pricing,
orders, and customers. This facilitates better inventory control, targeted marketing,
and revenue tracking. Overall, the project demonstrates the effectiveness of SQL and relational
databases in supporting business intelligence and decision-making in a bookstore environment.
*/
