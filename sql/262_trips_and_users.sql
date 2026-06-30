-- Write your PostgreSQL query statement below
SELECT 
  t.request_at AS "Day",
  ROUND(
    SUM(
      CASE WHEN t.status IN ('cancelled_by_driver','cancelled_by_client') THEN 1 ELSE 0 END
      )::numeric / count(*),
  2) AS "Cancellation Rate" 
FROM Trips AS t
INNER JOIN Users AS c
ON  t.client_id = c.users_id
INNER JOIN Users AS d
ON t.driver_id = d.users_id
WHERE c.banned = 'No'
AND d.banned = 'No'
AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03' 
GROUP BY t.request_at
ORDER BY t.request_at;
