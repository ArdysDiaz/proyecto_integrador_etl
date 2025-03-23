SELECT 
    o.order_status AS order_status,
    COUNT(o.order_id) AS Ammount
FROM
    olist_orders o
GROUP BY
    o.order_status;