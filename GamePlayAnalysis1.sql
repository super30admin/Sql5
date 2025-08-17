--Solution1
select player_id , min(event_date) as 'first_login' from activity group by player_id

--Solution2
select distinct player_id, min(event_date) over(partition by player_id) as 'first_login' from activity;

--Solution3
select a.player_id, a.event_date as 'first_login' from ( select b.player_id, b.event_date, rank() over(partition by b.player_id order by b.event_date) as 'rnk' from activity b ) a where a.rnk = 1;

--Solution4
select distinct a.player_id , first_value(event_date) over(partition by a.player_id order by event_date) as 'first_login' from activity a

--Solution5
select distinct a.player_id , last_value(event_date) over(partition by a.player_id order by event_date desc 
range between unbounded preceding and unbounded following) as 'first_login' from activity a
