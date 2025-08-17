-- using min and group by

select player_id, min(event_date) as first_login
from Activity
group by player_id;

-- using partition by

with CTE as (
  select player_id, event_date as first_login, row_number() over (partition by player_id
  order by event_date) as rn from activity
)
select CTE.player_id, CTE.first_login from CTE where rn = 1;

-- uing first value

With CTE as(
  select distinct player_id, first_value(event_date) over(partition by player_id order by #event_date)
  as first_login from  activity
)
select * from CTE;


-- uing last value

With CTE as(
 select distinct player_id, last_value(event_date) over(partition by player_id order by event_date desc range between unbounded preceding and unbounded following)  as first_login from  activity
)
select * from CTE;