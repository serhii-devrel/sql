/*
Find customers and serve their orders such employees, that both customers and employees are from the city of London, and delivery is carried out by Speedy Express.
Display the customer's company and the full name of the employees.
*/
SELECT c.company_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM orders AS o
JOIN customers AS c USING(customer_id)
JOIN employees AS e USING(employee_id)
JOIN shippers AS s ON o.ship_via = s.shipper_id
WHERE c.city = 'London' AND e.city = 'London'
GROUP BY s.company_name, c.company_name, e.first_name, e.last_name
HAVING s.company_name = 'Speedy Express'	

/*
Find active (discontinued) products from the Beverages and Seafood category with less than 20 items on sale.
Display the name of the products, the number of units on sale, the supplier's contact name and phone number.
*/
SELECT products.product_name, products.units_in_stock, categories.category_name, suppliers.contact_name, suppliers.phone
FROM products
JOIN categories USING(category_id)
JOIN suppliers USING(supplier_id)
WHERE products.discontinued <> 1 AND categories.category_name IN('Beverages', 'Seafood')
GROUP BY products.product_name, categories.category_name, suppliers.contact_name, suppliers.phone, products.units_in_stock
HAVING products.units_in_stock < 20

/*
Find customers who have not placed a single order. Display customer name and order_id.
*/
SELECT customers.contact_name, orders.order_id
FROM customers
LEFT JOIN orders USING(customer_id)
WHERE orders.order_id IS NULL

SELECT customers.contact_name, orders.order_id
FROM orders
RIGHT JOIN customers USING(customer_id)
WHERE orders.order_id IS NULL

SELECT customers.contact_name, orders.order_id
FROM customers
NATURAL JOIN orders