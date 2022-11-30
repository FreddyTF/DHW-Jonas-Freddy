{{
    config(
        materialized='incremental'
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
select c.customerid
     , c.customername
     , c.insertedat
from w_cust c