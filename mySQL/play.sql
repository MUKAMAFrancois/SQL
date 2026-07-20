create DATABASE IF NOT EXISTS lesson3;
use lesson3;


select 
auth.author_name,
count(bk.book_id) as total_books,
sum(bk.price) as total_inventory_price,
max(bk.price) as max_book_price
from books bk
inner join authors auth on bk.bk_author_id = auth.author_id
GROUP BY auth.author_name
ORDER BY total_inventory_price desc


-- challenge 2
-- you brought new topics.

select 
cust.customer_name,
COUNT(ord.order_id) AS total_orders,
ROUND(
    AVG(ord.amount), 2
) AS average_order_amount,

CASE 
   WHEN AVG(ord.amount) > 0 THEN "Active"
   ELSE "Inactive"
END  AS customer_status

from customers cust
left join orders ord on cust.customer_id = ord.customer_id
GROUP BY cust.customer_name
ORDER BY AVG(ord.amount) DESC
