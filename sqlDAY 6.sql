



day 6

use sql7challenge;
--1. Total orders and order status distribution
select count(*),o.status
from orders o
join orders_item oi on o.order_id=oi.order_id
group by o.status;


--2. Total sales value for non- cancelled
Select sum(oi.unit_price*oi.quantity)
from orders_item oi
join orders o on o.order_id=oi.order_id
where o.status<>'cancelled';

--3.months with highest and lowest order volumes
select count(*) as total_order_volume , month(order_date) as months
from orders
group by months
order by total_order_volume;


--4. Sales value by sales_channel
select sum(oi.quantity*oi.unit_price) as Total_sales, o.channel
from orders_item oi
join orders o on oi.order_id=o.order_id
where status<>'cancelled'
group by channel
order by Total_sales desc;

--5. Sales by product category
Identify which product category generates most sales
select sum(oi.quantity* oi.unit_price) as Total_sales, p.category
from orders_item oi
join orders o
on oi.order_id=o.order_id
join products p
on p.product_id=oi.product_id
where status<>'cancelled'
group by p.category
order by Total_sales;

--6. Top 10 products by salesvalue
select sum(oi.quantity* oi.unit_price) as Total_sales, p.product_name
from orders_item oi
join orders o
on oi.order_id=o.order_id
join products p
on p.product_id=oi.product_id
where status<>'cancelled'
group by p.product_name
order by Total_sales desc
limit 10;

-7.roducts with no sales from non_cancelled

SELECT p.product_name 
FROM products p 
LEFT JOIN orders_item oi ON p.product_id = oi.product_id 
WHERE oi.product_id IS NULL;

--8.Estimated product profit by category
select sum((p.price-p.cost)*oi.quantity) as total_profit , p.category
from products p
join orders_item oi on p.product_id=oi.product_id
group by p.category
order by total_profit;

--9.Top 10 customers by non- cancelled orders
select c.full_name, count(o.order_id) as no_of_orders
from customers c
join orders o
on c.customer_id=o.customer_id
where o.status<>'cancelled'
group by c.full_name
order by no_of_orders desc
limit 10;

--10 top 10 customers by calculated spending
select sum(oi.unit_price* oi.quantity) as amount_spent, c.full_name
from customers c
join orders o on c.customer_id=o.customer_id
join orders_item oi on o.order_id=oi.order_id
where o.status<>'cancelled'
group by c.full_name
order by amount_spent desc
limit 10;

--11. city with largest customer base
select count(*) as Total_customers , city
from customers
group by city
order by Total_customers desc;

--12.Average customer spending by segement
select sum(oi.unit_price * oi.quantity) as spend, c.segment
from customers c
 join orders o on o.customer_id = c.customer_id
join orders_item oi on o.order_id=oi.order_id
group by segment
order by spend;

--13. payment status distribution
select count(*), payment_status
from payments
group by payment_status;

--14.Average delivery time
select avg(delivery_date - dispatch_date)
from deliveries;

--15.orders taking more than five days to deliver
select order_id, (delivery_date-dispatch_date) as time
from deliveries
where delivery_date - dispatch_date > 5
order by time desc;

--insights--
1.The avaerage delivery time is 95.47 days.
2.The order volume is amximum in august and minimum in november.
3.The noida has largest customer base and patna has the lowest custmoer base
4.The category books has highest sales and the electronics has least sales value
5.The website is the best performing sales channel
