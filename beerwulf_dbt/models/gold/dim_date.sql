{{ config(
    schema='gold',
    materialized='table'
) }}

WITH
--min and max date values across the lineitem and order date columns
date_bounds AS (
  SELECT
    MIN(order_date)     as min_dt,
    MAX(order_date)     as max_dt
  FROM {{ ref('orders') }}

  UNION ALL 

  SELECT
    MIN(ship_date)      as min_dt,
    MAX(receipt_date)   as max_dt
  FROM {{ ref('lineitem') }}
),

-- min and max date across both tables
bounds as (
  SELECT
    min(min_dt) as start_date,
    max(max_dt) as end_date
  FROM date_bounds
),

-- start from start date and generate +1 days up to the end dates
date_spine AS (
  SELECT
    CAST(generate_series(start_date, end_date, interval '1 day') AS DATE) as date_day
  FROM bounds
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
