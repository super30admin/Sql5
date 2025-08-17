select 
distinct a.player_id , 
first_value(a.event_date) over ( partition by a.player_id order by a.event_date) as 'first_login' 
from activity a