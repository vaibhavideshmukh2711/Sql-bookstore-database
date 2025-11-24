create database Booksystem;

use booksystem;
select * from books;
select * from customers;
select * from orders;

# 1.Retrieve all books in the "Fiction" genre

select *from books
where Genre='Fiction';

#2 Find books published after the year 1950

select * from books
 where published_Year > 1950;
 
#3) List all customers from the Canada

select * from customers
where Country='Canada';

#4) Show orders placed in November 2023

select * from orders
where month(Order_date) = '11' and year(Order_date) = '2023';


#5) Retrieve the total stock of books available
select count(*)  as Book_cnt  from books;


#6) Find the details of the most expensive book

select Title , max(price) as Expensive_price 
from books 
group by  Title
order by  Expensive_price   desc limit 1 ;

# 7) Show all customers who ordered more than 1 quantity of a book

select * from orders 
where Quantity > 1;


select c.Name, c.Customer_ID, o.Quantity from customers c
join orders o on  c.Customer_ID=o.Customer_ID
where o.Quantity > 1;


#8) Retrieve all orders where the total amount exceeds $100
select * from orders 
where Total_Amount > 100;


 # 9) List all genres available in the Books table
 
select count(Genre ) as genre_cnt, Genre from books
group by Genre;


#10) Find the book with the lowest stock
select Title , min(Stock)  as min_stock
from books
Group by Title
order by min_stock asc limit 5;


#11) Calculate the total revenue generated from all orders

select sum(b.Price *o.quantity) as Revenue from books b 
join orders o 
on b.Book_ID=o.Book_ID;

 #   Advanced Questions

# 12) Retrieve the total number of books sold for each genre

select sum(o.quantity) as Book_sold , b.genre
from books b
join orders o on o.book_id=b.book_id
group by genre;


#13) Find the average price of books in the "Fantasy" genre
select round(avg(Price),2) as avg_price , genre from books
where genre='Fantasy';



#14) List customers who have placed at least 2 orders
select count(o.order_id) as order_cnt  , o.customer_id , c.Name from orders o
join customers c on c.Customer_ID=o.Customer_ID
Group by o.customer_id , c.Name
having order_cnt>=2;



#15) Find the most frequently ordered book

select  book_id ,count(*) as order_cnt
from orders 
group by book_id 
order by order_cnt desc limit 1;

#16) Show the top 3 most expensive books of 'Fantasy' Genre

select max(price) as expensive_book , Title 
from books
where genre='Fantasy'
group by Title
order by  expensive_book desc limit 3;


# 17) Retrieve the total quantity of books sold by each author

select b.Author , sum(o.quantity) as order_cnt
from books b 
join orders o on b.book_id=o.book_id
group by b.Author;


#18) List the cities where customers who spent over $30 are located

select distinct c.city , total_amount from orders o 
join customers c on o.customer_id=c.customer_id
where o.total_amount > 30;


#19) Find the customer who spent the most on orders


select c.name , sum(o.total_amount) as total_Amount
from customers c
join orders o on c.customer_id=o.customer_id
group by c.name
order by total_amount desc limit 1;


#20) Calculate the stock remaining after fulfilling all orders

select b.book_id , b.title, b.stock , coalesce(sum(o.quantity),0) as order_quantity,

b.stock - coalesce(sum(o.quantity),0) as Remaining_Quantity 
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id , b.title , b.stock
order by b.book_id;

