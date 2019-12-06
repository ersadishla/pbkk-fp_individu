SELECT  g.id,
        g.name,
        g.type,
        g.volume,
        g.created_at,
        g.last_purchase_price,
        r.variant,
        r.normal_profit,
        r.normal_price,
        r.market_price,
        r.recommend_price,
        r.profit,
        r.last_profit,
        r.last_price
FROM goods as g
LEFT JOIN recommends r
ON g.id = r.goods_id