create database bookstore;

use bookstore; 

create table books(  
Book_ID	INT	PRIMARY KEY,
Title	VARCHAR(100),	
Author	VARCHAR(100),	
Genre	VARCHAR(100),	
Published_Year	INT	NOT  NULL,
Price	DOUBLE,	
Stock	INT	
);

-- import data into books table

create table CUSTOMERS(
Customer_ID	INT	PRIMARY KEY, 
Name	VARCHAR(50),	
Email	VARCHAR(50),	
Phone	VARCHAR(15),	
City	VARCHAR(50),	
Country	VARCHAR(25)	
);
  
-- import data into CUSTOMERS table

create table orders(  
Order_ID	SERIAL	PRIMARY KEY,	
Customer_ID	INT	REFERENCES	CUSTOMERS(Customer_ID),
Book_ID	INT	REFERENCES	books(Book_ID),
Order_Date	date,		
Quantity	INT,		
Total_Amount	numeric(10,2)		
);

-- import data into orders table 
 
select * from books;
select * from CUSTOMERS;
select * from orders;  

-- 1) Retrieve all  books in the "fiction" Genre;

select * from books 
where genre ="Fiction";

-- 2) Find books published after the year 1950; 

select * from books 
where Published_Year >1950;

-- 3) list all the customers from the Canada;

select * from CUSTOMERS
where Country = "Canada"; 

-- 4)show orders in november 2023; 

select * from orders
where Order_Date between '2023-11-01' AND '2023-11-30'; 

-- 5) Retrieve the total stock of books available;
 
 select sum(stock) as total_stock
 from books; 
 
 -- 6) Find the details of the most expensive book: 
 
 select * from books order by Price Desc LIMIT 1; 
 
 -- 7) show all the customers who ordered more than 1 quantity of a book: 
 
 select * from orders 
 where Quantity > 1;
 
 -- 8) Reterive all the orders where the total amount exceeds $20: 
 
 select * from orders 
 where Total_Amount >20; 
 
 -- 9) List all the genres available in the books table:
 
 select distinct genre 
 from books;

-- 10) Find the book with lowest stock: 

select * from books 
order by stock asc limit 1; 

-- 11) Calculate the total revenue generated from all order:

select sum(Total_Amount) 
from orders;

-- Advanced questions : 

-- 1) Retrieve the total numbers of  books sold for each genre: 
 
 select b.Genre, sum(o.Quantity) AS Total_Books_sold 
 from orders o 
 join books b On o.book_id 
 group by b.Genre;
 
-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price
FROM books
WHERE Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders: 

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;




-- 4) Find the most frequently ordered book: 

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre : 

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;





-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders: 

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;



