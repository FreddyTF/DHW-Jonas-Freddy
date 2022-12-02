{{
    config(
        materialized='table',
        unique_key="d_ort_key"
    )
}}

with w_ort as (
    SELECT  row_number() over (order by staging.land.land_id ) as d_ort_key, staging.ort.ort, staging.land.land  FROM staging.ort 
    INNER JOIN staging.land on ort.land_id = land.land_id
)

select o.ort, o.land, o.d_ort_key
from w_ort o