WITH formatted_orders AS (
    SELECT 
        order_id,
        order_status,
        SUBSTR(order_delivered_customer_date, 7, 4) || '-' || 
        SUBSTR(order_delivered_customer_date, 4, 2) || '-' || 
        SUBSTR(order_delivered_customer_date, 1, 2) AS delivered_date,
        SUBSTR(order_estimated_delivery_date, 7, 4) || '-' || 
        SUBSTR(order_estimated_delivery_date, 4, 2) || '-' || 
        SUBSTR(order_estimated_delivery_date, 1, 2) AS estimated_date,
        SUBSTR(order_purchase_timestamp, 7, 4) || '-' || 
        SUBSTR(order_purchase_timestamp, 4, 2) || '-' || 
        SUBSTR(order_purchase_timestamp, 1, 2) AS purchase_date
    FROM olist_orders
    WHERE order_status = 'delivered' AND order_delivered_customer_date IS NOT NULL
)
SELECT 
    STRFTIME('%m', delivered_date) AS month_no,
    CASE STRFTIME('%m', delivered_date)
        WHEN '01' THEN 'Ene' WHEN '02' THEN 'Feb' WHEN '03' THEN 'Mar'
        WHEN '04' THEN 'Abr' WHEN '05' THEN 'May' WHEN '06' THEN 'Jun'
        WHEN '07' THEN 'Jul' WHEN '08' THEN 'Ago' WHEN '09' THEN 'Sep'
        WHEN '10' THEN 'Oct' WHEN '11' THEN 'Nov' WHEN '12' THEN 'Dic'
    END AS month,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', delivered_date) = '2016' 
        THEN JULIANDAY(delivered_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2016_real_time,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', delivered_date) = '2017' 
        THEN JULIANDAY(delivered_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2017_real_time,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', delivered_date) = '2018' 
        THEN JULIANDAY(delivered_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2018_real_time,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', estimated_date) = '2016' 
        THEN JULIANDAY(estimated_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2016_estimated_time,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', estimated_date) = '2017' 
        THEN JULIANDAY(estimated_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2017_estimated_time,
    COALESCE(AVG(CASE 
        WHEN STRFTIME('%Y', estimated_date) = '2018' 
        THEN JULIANDAY(estimated_date) - JULIANDAY(purchase_date) 
    END), 'NaN') AS Year2018_estimated_time
FROM formatted_orders
GROUP BY month_no, month
ORDER BY month_no;
