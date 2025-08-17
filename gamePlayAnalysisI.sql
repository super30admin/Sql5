select distinct player_id, 
min(event_date) over(partition by player_id) as first_login 
from activity