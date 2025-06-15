SELECT *
FROM {{ref('lineitem')}}
WHERE quantity < 1 
