with AmericaCTE as (
  select name,ROW_NUMBER() over (partition by continent order by name) as row_id from Student
  where continent='America'
),
AsiaCTE as (
  select name,ROW_NUMBER() over (partition by continent order by name) as row_id from Student
  where continent='Asia'
),
EuropeCTE as (
  select name,ROW_NUMBER() over (partition by continent order by name) as row_id from Student
  where continent='Europe'
)

select AmericaCTE.name as America,AsiaCTE.name as Asia,  EuropeCTE.name as Europe from AmericaCTE
left join AsiaCTE
on AmericaCTE.row_id= AsiaCTE.row_id
left join EuropeCTE 
on AmericaCTE.row_id=EuropeCTE.row_id