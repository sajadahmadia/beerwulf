{{ config(
    schema='gold',
    materialized='table'
) }}

with
--min and max date values across the lineitem and order date columns
date_bounds as (
  select
    min(order_date)     as min_dt,
    max(order_date)     as max_dt
  from {{ ref('orders') }}

  union all 

  select
    min(ship_date)      as min_dt,
    max(receipt_date)   as max_dt
  from {{ ref('lineitem') }}
),

-- min and max date across both tables
bounds as (
  select
    min(min_dt) as start_date,
    max(max_dt) as end_date
  from date_bounds
),

-- start from start date and generate +1 days up to the end dates
date_spine as (
  select
    generate_series(start_date, end_date, interval '1 day')::date as date_day
  from bounds
)

select CAST(to_char(date_day, 'YYYYMMDD') as integer) as date_key,
    date_day AS date_actual,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(QUARTER FROM date_day) AS quarter,
    EXTRACT(MONTH FROM date_day) AS month,
    TO_CHAR(date_day, 'Month') AS month_name,
    EXTRACT(DAY FROM date_day) AS day_of_month,
    EXTRACT(DOW FROM date_day) AS day_of_week,
    TO_CHAR(date_day, 'Day') AS day_name,
    CASE 
        WHEN EXTRACT(MONTH FROM date_day) >= 7 
        THEN EXTRACT(YEAR FROM date_day)
        ELSE EXTRACT(YEAR FROM date_day) - 1
    END AS fiscal_year
from date_spine
