WITH CTE AS(
    SELECT customer_id, YEAR(order_date) as 'year',sum(price) FROM Orderd
    GROUP BY customer_id, 'year'
    Order By customer_id
)

SELECT c1.customer_id FROM CTE c1 LEFT JOIN CTE c2
ON (c1.customer_id = c2.customer_id) AND
    (c2.year = c1.year+1) AND
    (c2.price > c1.price)
GROUP BY c1.customer_id
HAVING (COUNT(*)- COUNT(c2.customer_id)) = 1