{{
    config(
        materialized='table'
    )
}}

with w_ort as (
    SELECT staging.ort.ort, staging.land.land  FROM staging.ort 
    INNER JOIN staging.land on ort.land_id = land.land_id
)

select o.ort, o.land
from w_ort o