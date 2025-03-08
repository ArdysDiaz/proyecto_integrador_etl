SELECT order_status AS Estado,
       CAST(AVG(julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)) AS INTEGER) AS Diferencia_Entrega
  FROM olist_orders
 WHERE order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
 GROUP BY order_status
 ORDER BY order_status;