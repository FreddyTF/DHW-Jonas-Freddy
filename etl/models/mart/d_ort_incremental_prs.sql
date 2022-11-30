{{
    config(
        materialized='table'
    )
}}

with w_cust as (
    select *
    from {{ source('staging', 'stg_customer_prs') }}

    -- filter for an incremental run to get new data
    {% if is_incremental() %}

    where insertedat > (select max(insertedat) from {{ this }})

    {% endif %}

)
SELECT staging.ort.ort, staging.land.land  FROM staging.ort
INNER JOIN staging.land on ort.land_id = land.land_id;