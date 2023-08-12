/*
1. First login is obtained as the first date of the activity for each player
2. We get it using min function on event_date. Group by player_id to get the first login for each player.
*/

select player_id, min(event_date) first_login 
from Activity 
group by player_id