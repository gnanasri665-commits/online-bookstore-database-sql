CREATE TABLE authors (
    author_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    bio VARCHAR2(500)
);
CREATE TABLE genres (
    genre_id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL
);
CREATE TABLE books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(150) NOT NULL,
    author_id NUMBER NOT NULL,
    price NUMBER(10,2) NOT NULL,
    publication_date DATE,
    genre_id NUMBER,

    CONSTRAINT fk_book_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id),

    CONSTRAINT fk_book_genre
        FOREIGN KEY (genre_id)
        REFERENCES genres(genre_id)
);
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(150) UNIQUE,
    phone VARCHAR2(20)
);
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    order_date DATE,
    total NUMBER(10,2),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
CREATE TABLE order_details (
    order_id NUMBER,
    book_id NUMBER,
    quantity NUMBER NOT NULL,

    CONSTRAINT pk_order_details
        PRIMARY KEY (order_id, book_id),

    CONSTRAINT fk_detail_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_detail_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);
SELECT table_name
FROM user_tables
ORDER BY table_name;
DROP TABLE employee;
DROP TABLE staff;
SELECT table_name
FROM user_tables
ORDER BY table_name;
INSERT INTO authors
VALUES (1,'J.K. Rowling','British author known for the Harry Potter series');
INSERT INTO authors
VALUES (2,'George Orwell','English novelist and essayist');
INSERT INTO authors
VALUES (3,'Jane Austen','English novelist known for her romantic fiction');
INSERT INTO authors
VALUES (4,'Dan Brown','American author of thriller novels');
INSERT INTO authors
VALUES (5,'Agatha Christie','English mystery writer');
SELECT * FROM authors;
COMMIT;
INSERT INTO genres 
VALUES(1, 'Fantasy');

INSERT INTO genres
VALUES(2, 'Dystopian');

INSERT INTO genres 
VALUES(3, 'Romance');

INSERT INTO genres 
VALUES(4, 'Thriller');

INSERT INTO genres 
VALUES(5, 'Mystery');
SELECT * FROM genres;
COMMIT;
INSERT INTO books 
VALUES(101, 'Harry Potter and the Sorcerers Stone', 1, 499, DATE '1997-06-26', 1);

INSERT INTO books 
VALUES(102, '1984', 2, 399, DATE '1949-06-08', 2);

INSERT INTO books 
VALUES(103, 'Pride and Prejudice', 3, 299, DATE '1813-01-28', 3);

INSERT INTO books 
VALUES(104, 'The Da Vinci Code', 4, 599, DATE '2003-04-01', 4);

INSERT INTO books 
VALUES(105, 'Murder on the Orient Express', 5, 450, DATE '1934-01-01', 5);
SELECT * FROM books;
COMMIT;
INSERT INTO customers 
VALUES(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210');

INSERT INTO customers 
VALUES(2, 'Priya Reddy', 'priya@gmail.com', '9876543211');

INSERT INTO customers 
VALUES(3, 'Arun Kumar', 'arun@gmail.com', '9876543212');

INSERT INTO customers 
VALUES(4, 'Sneha Rao', 'sneha@gmail.com', '9876543213');

INSERT INTO customers 
VALUES(5, 'Kiran Singh', 'kiran@gmail.com', '9876543214');
SELECT * FROM customers ;
COMMIT;
INSERT INTO orders 
VALUES(1001, 1, DATE '2026-09-01', 998);

INSERT INTO orders 
VALUES(1002, 2, DATE '2026-09-02', 399);

INSERT INTO orders 
VALUES(1003, 3, DATE '2026-09-03', 599);

INSERT INTO orders 
VALUES(1004, 1, DATE '2026-09-05', 299);

INSERT INTO orders 
VALUES(1005, 4, DATE '2026-09-06', 900);
SELECT * FROM orders ;
COMMIT;
INSERT INTO order_details 
VALUES(1001, 101, 2);

INSERT INTO order_details 
VALUES(1002, 102, 1);

INSERT INTO order_details 
VALUES(1003, 104, 1);

INSERT INTO order_details 
VALUES(1004, 103, 1);

INSERT INTO order_details 
VALUES(1005, 105, 2);
SELECT * FROM order_details ;
COMMIT;
SELECT * FROM authors ;
SELECT * FROM books ;
SELECT * FROM customers ;
SELECT * FROM genres ;
SELECT * FROM orders ;
SELECT * FROM order_details ;

CREATE OR REPLACE VIEW books_by_author AS
SELECT
    b.book_id,
    b.title,
    a.name AS author_name,
    b.price,
    b.publication_date
FROM books b
JOIN authors a
ON b.author_id = a.author_id;
SELECT * FROM books_by_author;

CREATE OR REPLACE VIEW book_total_sales AS
SELECT
    b.book_id,
    b.title,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * b.price) AS total_sales
FROM books b
JOIN order_details od
ON b.book_id = od.book_id
GROUP BY
    b.book_id,
    b.title;
SELECT * FROM book_total_sales;

CREATE OR REPLACE VIEW customer_order_history AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.email,
    o.order_id,
    o.order_date,
    o.total
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;
SELECT * FROM customer_order_history;

SELECT
    b.book_id,
    b.title,
    a.name AS author_name,
    g.name AS genre,
    b.price,
    b.publication_date
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN genres g
ON b.genre_id = g.genre_id;

SELECT
    b.book_id,
    b.title,
    SUM(od.quantity) AS total_quantity_sold
FROM books b
JOIN order_details od
ON b.book_id = od.book_id
GROUP BY
    b.book_id,
    b.title
ORDER BY total_quantity_sold DESC
FETCH FIRST 5 ROWS ONLY;

SELECT
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.email,
    b.title,
    od.quantity,
    b.price,
    od.quantity * b.price AS line_total
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN books b
ON od.book_id = b.book_id
ORDER BY o.order_id;

CREATE INDEX idx_books_author
ON books(author_id);
CREATE INDEX idx_books_genre
ON books(genre_id);
CREATE INDEX idx_orders_customer
ON orders(customer_id);
CREATE INDEX idx_order_details_book
ON order_details(book_id);

SELECT
    index_name,
    table_name
FROM user_indexes
ORDER BY table_name;
EXPLAIN PLAN FOR
SELECT
    b.title,
    a.name AS author_name
FROM books b
JOIN authors a
ON b.author_id = a.author_id;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT
    b.title,
    a.name AS author,
    g.name AS genre,
    b.price
FROM books b
JOIN authors a
ON b.author_id = a.author_id
JOIN genres g
ON b.genre_id = g.genre_id;