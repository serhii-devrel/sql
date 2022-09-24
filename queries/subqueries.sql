/*
Display products whose quantity on sale is less than the smallest average quantity of products in order details
(grouping by product_id). The resulting table should have product_name and units_in_stock columns.
*/
SELECT product_name, units_in_stock
FROM products
WHERE products.units_in_stock < ALL(SELECT AVG(quantity)
								FROM order_details
								GROUP BY products.product_id)
ORDER BY units_in_stock DESC

/*
Query that displays the total amount of order freights for customer companies for orders,
whose freight cost is greater than or equal to the average freight cost of all orders, and also the date of shipment of the order must be in the second half of July 1996.
The resulting table should have customer_id and freight_sum columns, the lines of which should be sorted by the amount of freight orders.
*/
SELECT orders.customer_id, SUM(orders.freight) AS freight_sum
FROM orders
WHERE (orders.shipped_date BETWEEN '1996-07-15' AND '1996-07-31') AND (orders.freight >= ALL(SELECT AVG(orders.freight)  
						    																 FROM orders))
GROUP BY orders.customer_id
ORDER BY freight_sum DESC

/*
Query that displays the 3 orders with the highest cost, which were created after September 1, 1997 inclusive and were delivered to the countries of South America.
The total cost is calculated as the sum of the cost of the order details, taking into account the discount.
The resulting table should have customer_id, ship_country and order_price columns, the lines of which should be sorted by order value in reverse order.
*/
SELECT orders.customer_id, orders.ship_country, SUM(od.unit_price * od.quantity - od.unit_price * od.quantity * od.discount) AS order_price
FROM orders
JOIN order_details AS od USING(order_id)
WHERE (orders.order_date >= '1996-09-01') AND (orders.ship_country NOT IN('Germany', 'Italy', 'Ireland', 'Austria', 'Sweden'))
GROUP BY orders.customer_id, orders.ship_country
ORDER BY order_price DESC
LIMIT 3

-- Display all products (unique product names) of which exactly 10 units are ordered.
SELECT product_id, product_name, units_on_order
FROM products
WHERE products.product_id = ANY(SELECT order_details.product_id
						  		FROM order_details
						 	    WHERE quantity = 10)