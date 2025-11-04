CREATE OR REPLACE VIEW user_summary AS
SELECT 
    u.id AS user_id,
    u.email,
    COUNT(DISTINCT t.id) AS total_transactions,
    SUM(DISTINCT w.balance) AS total_balance,

    ABS(SUM(o.price * o.kilkist)) AS total_order_sum,

    ABS(SUM(s.trade_price * s.trade_amount)) AS total_spot_sum,

    ABS(SUM(o.price * o.kilkist) - SUM(s.trade_price * s.trade_amount)) AS difference_order_spot,

    MAX(tr.status) AS last_trade_status

FROM user AS u
LEFT JOIN transaction AS t 
    ON u.id = t.user_id
LEFT JOIN wallet AS w 
    ON u.id = w.user_id
LEFT JOIN orders AS o 
    ON 1=1
LEFT JOIN trade AS tr 
    ON u.id = tr.id
LEFT JOIN spot AS s 
    ON s.order_id = o.id
GROUP BY 
    u.id, 
    u.email
ORDER BY 
    total_transactions DESC;