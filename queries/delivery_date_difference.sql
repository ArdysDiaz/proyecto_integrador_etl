SELECT order_status AS State,
       CAST(AVG(julianday(
           SUBSTR(order_delivered_customer_date, 7, 4) || '-' || 
           SUBSTR(order_delivered_customer_date, 4, 2) || '-' || 
           SUBSTR(order_delivered_customer_date, 1, 2) || ' ' || 
           SUBSTR(order_delivered_customer_date, 12, 5)
       ) - julianday(
           SUBSTR(order_estimated_delivery_date, 7, 4) || '-' || 
           SUBSTR(order_estimated_delivery_date, 4, 2) || '-' || 
           SUBSTR(order_estimated_delivery_date, 1, 2) || ' ' || 
           SUBSTR(order_estimated_delivery_date, 12, 5)
       )) AS INTEGER) AS Delivery_Difference
  FROM olist_orders
 WHERE order_status = 'delivered' 
   AND order_delivered_customer_date IS NOT NULL
 GROUP BY order_status
 ORDER BY order_status;