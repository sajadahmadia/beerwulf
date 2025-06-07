select * 
from {{ source('landing_zone', 'region') }}
