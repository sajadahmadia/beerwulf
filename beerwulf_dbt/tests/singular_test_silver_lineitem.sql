SELECT *
FROM {{ref('lineitem')}}
WHERE discount > 1 
