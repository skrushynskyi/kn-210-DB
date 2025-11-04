SELECT 
    u.id AS user_id,
    u.email,
    COUNT(DISTINCT t.id) AS total_transactions,
    SUM(DISTINCT w.balance) AS total_balance,
    SUM(o.price) AS total_order_price,
    MAX(tr.status) AS last_trade_status,
    SUM(s.trade_amount) AS total_spot_sum
FROM user AS u
LEFT JOIN transaction AS t 
    ON u.id = t.user_id
LEFT JOIN wallet AS w 
    ON u.id = w.user_id
LEFT JOIN `order` AS o 
    ON u.id = o.user_id
LEFT JOIN trade AS tr 
    ON u.id = tr.id
LEFT JOIN spot AS s 
    ON o.id = s.order_id
GROUP BY 
    u.id, 
    u.email
ORDER BY 
    total_transactions DESC;

