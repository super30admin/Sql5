-- Problem 2
With AmericaCTE as(
  select name,row_number() over(partition by continent order by name) as row_id from Student where continent ='America'),
AsiaCTE as(
  Select name,row_number() over(partition by continent order by name) as row_id from Student where continent ='Asia'),
EuropeCTE as(
  Select name,row_number() over(partition by continent order by name) as row_id from Student where continent ='Europe'

  )


select AmericaCTE.name As America,AsiaCTE.name As Asia,EuropeCTE.name As Europe from AmericaCTE 
left join AsiaCTE on AmericaCTE.row_id = AsiaCTE.row_id 
left join EuropeCTE ON AmericaCTE.row_id=EuropeCTE.row_id 