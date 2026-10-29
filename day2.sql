SELECT * FROM sql7challenge.orders;
--3. most recent 10 orders
select order_id , order_date from orders
order by order_date desc
limit 10;

-- 4. top 10 high value orders
select order_id, quantity*unit_price as order_value from orders_item
order by quantity*unit_price desc
limit 10;

--5. count orders per day in chronological order
select order_date, count(*) as total_orders
from orders
group by order_date
order by order_date asc;

--6. monthly order trend
select month(order_date), count(*) as total_orders
from orders
group by month(order_date)
order by month(order_date) asc;

--7. Average order value

select round(avg(order_amount),2) as avg_value
from
(select order_id, SUM(quantity * unit_price) as order_amount
from orders_item
group by order_id ) as orders_total;

--8. tOP 10 CUSTOMERS BASED ON NUMBER OF ORDERS PLACED


SELECT 
    customer_id, 
    COUNT(order_id) AS total_orders
FROM 
    orders
GROUP BY 
    customer_id
ORDER BY 
    total_orders DESC
    limit 10;
    
INSIGHTS:

1. The highest order value is Rs.29835.48 and it is observed that top 10 customers have their order values greater than Rs.20000.
2. It was observed that the highest number of orders were recieved in august as 85 orders and it was observed that there was a contionous drop in numbers orders after reaching peak in august and the 
lowest number of orders was observed in Novemeber and after that there was a slight rise and fluctating rise and fall.
3. The average order value is 23404.04.
4. The top 3 customers placed 8 orders each and the top 10 customers placed atleast 6 orders.