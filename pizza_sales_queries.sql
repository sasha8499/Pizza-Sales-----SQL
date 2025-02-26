-- [1]Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
    
-- [2]Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- [3]Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- [4] Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-- [5]List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- [6]Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- [7]Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(orders.order_time) AS hour,
    COUNT(orders.order_id) AS order_count
FROM
    orders
GROUP BY hour;


-- [8]Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS pizza_count
FROM
    pizza_types
GROUP BY pizza_types.category;


-- [9]Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity))
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    

-- [10]Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- [11]Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(pizzas.price * order_details.quantity) / (SELECT 
                    ROUND(SUM(pizzas.price * order_details.quantity),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;


-- [12]Analyze the cumulative revenue generated over time.

select order_date,sum(revenue) over (order by order_date) 
as cumulative_revenue from 
(Select orders.order_date , Sum(order_details.quantity*pizzas.price) as revenue 
from order_details 
join pizzas on order_details.pizza_id = pizzas.pizza_id 
join orders on orders.order_id = order_details.order_id
group by orders.order_date) as sales;


-- [13]Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category , name, revenue from 
(Select category,name,revenue ,rank() over(partition by category order by revenue desc) 
as ranking from 
(Select pizza_types.category , pizza_types.name, sum(order_details.quantity * pizzas.price)
 as revenue from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where ranking <= 3;


-- [14]Identify peak ordering days of the week and their impact on revenue.

SELECT
    DAYNAME(orders.order_date) AS day_of_week, 
    COUNT(DISTINCT orders.order_id) AS total_orders,
    ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_revenue,
    ROUND(SUM(order_details.quantity * pizzas.price) * 100.0 / 
          SUM(SUM(order_details.quantity * pizzas.price)) OVER (), 2) AS revenue_percentage
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY day_of_week
ORDER BY total_revenue DESC;


-- [15]Identify pairs or groups of pizzas frequently ordered together.

SELECT 
    pt1.name AS pizza_1,
    pt2.name AS pizza_2,
    COUNT(*) AS times_ordered_together
FROM
    order_details p1
        JOIN
    order_details p2 ON p1.order_id = p2.order_id
        AND p1.pizza_id < p2.pizza_id
        JOIN
    pizzas pi1 ON p1.pizza_id = pi1.pizza_id
        JOIN
    pizzas pi2 ON p2.pizza_id = pi2.pizza_id
        JOIN
    pizza_types pt1 ON pi1.pizza_type_id = pt1.pizza_type_id
        JOIN
    pizza_types pt2 ON pi2.pizza_type_id = pt2.pizza_type_id
GROUP BY pt1.name , pt2.name
ORDER BY times_ordered_together DESC
LIMIT 10;


-- [16]Calculate the average revenue per order.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price) / COUNT(DISTINCT orders.order_id),
            2) AS average_revenue_per_order
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
ORDER BY average_revenue_per_order;
