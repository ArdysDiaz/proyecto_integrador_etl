SELECT 
    STRFTIME('%m', o.order_delivered_customer_date) AS month_no,
    CASE STRFTIME('%m', o.order_delivered_customer_date)
        WHEN '01' THEN 'Ene'
        WHEN '02' THEN 'Feb'
        WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Abr'
        WHEN '05' THEN 'May'
        WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul'
        WHEN '08' THEN 'Ago'
        WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct'
        WHEN '11' THEN 'Nov'
        WHEN '12' THEN 'Dic'
    END AS month,
    COALESCE(SUM(CASE 
        WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2016' 
        THEN p.payment_value 
    END), 0.00) AS Year2016,
    COALESCE(SUM(CASE 
        WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2017' 
        THEN p.payment_value 
    END), 0.00) AS Year2017,
    COALESCE(SUM(CASE 
        WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2018' 
        THEN p.payment_value 
    END), 0.00) AS Year2018
FROM olist_orders o
JOIN olist_order_payments p ON o.order_id = p.order_id
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    month_no, month
ORDER BY 
    month_no;