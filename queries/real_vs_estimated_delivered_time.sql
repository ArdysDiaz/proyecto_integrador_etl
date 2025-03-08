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
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2016' 
            THEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2016_real_time,
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2017' 
            THEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2017_real_time,
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_delivered_customer_date) = '2018' 
            THEN JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2018_real_time,
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_estimated_delivery_date) = '2016' 
            THEN JULIANDAY(o.order_estimated_delivery_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2016_estimated_time,
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_estimated_delivery_date) = '2017' 
            THEN JULIANDAY(o.order_estimated_delivery_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2017_estimated_time,
    COALESCE(AVG(CASE 
            WHEN STRFTIME('%Y', o.order_estimated_delivery_date) = '2018' 
            THEN JULIANDAY(o.order_estimated_delivery_date) - JULIANDAY(o.order_purchase_timestamp) 
        END), 'NaN') AS Year2018_estimated_time
FROM olist_orders o
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    month_no, month
ORDER BY 
    month_no;