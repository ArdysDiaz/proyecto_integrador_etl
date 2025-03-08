SELECT 
    o.order_status AS estado_pedido,
    COUNT(o.order_id) AS Cantidad
FROM
    olist_orders o
GROUP BY
    o.order_status;