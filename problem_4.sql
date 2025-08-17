--Game play analysis I:

SELECT a.player_id , a.event_date AS 'first_login'
FROM (
    SELECT b.player_id, b.event_date, RANK() OVER (PARTITION by b.player_id ORDER BY b.event_date) as rnk 
    FROM Activity b
 )
a WHERE a.rnk=1;

--Using first_value():

SELECT DISTINCT a.player_id, FIRST_VALUE(a.event_date) OVER (PARTITION by a.player_id ORDER BY a.event_date)
AS first_login
FROM Activity a;
