# Write your MySQL query statement below

#APPROACH 1
with state_table as(
  select fail_date dates, 'failed' state from Failed where year(fail_date) = 2019
  union
  select *, 'succeeded' state from Succeeded where year(success_date) = 2019
),
rank_table as(
  select dates, state, dense_rank()over(partition by state order by dates,state) rnk from state_table
)
select state period_state, min(dates) start_date, min(dates)+ interval count(dates)-1 day end_date from rank_table group by state,dates-interval rnk day order by start_date

#APPROACH 2
# WITH cte AS(
#     SELECT 
#         *, 
#         DENSE_RANK() OVER (PARTITION BY status ORDER BY dt) AS id
#     FROM (
#         SELECT 
#             'failed' AS status, 
#             fail_date dt 
#         FROM Failed 
#         UNION ALl 
#         SELECT 
#             'succeeded' AS status, 
#             success_date dt 
#         FROM Succeeded) AS t
#     WHERE 
#         Year(dt) = 2019
# )

# SELECT 
#     status period_state, 
#     MIN(dt) start_date, 
#     MIN(dt) + INTERVAL COUNT(dt) - 1 DAY end_date 
# FROM
#     cte 
# GROUP BY 
#     status, 
#     (dt - INTERVAL id DAY) 
# ORDER BY 
#     start_date