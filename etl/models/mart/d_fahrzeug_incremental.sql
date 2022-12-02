{{
    config(
        materialized='incremental',
        unique_key="d_fahrzeug_key",
    )
}}

with w_fahrzeug as (
    SELECT staging.fahrzeug.fin, cast(staging.fahrzeug.baujahr as int), staging.fahrzeug.modell, 
    row_number() over (order by staging.fahrzeug.fin) as d_fahrzeug_key,
    staging.hersteller.hersteller, staging.kfzzuordnung.kfz_kennzeichen from staging.fahrzeug
    inner join staging.hersteller on staging.hersteller.hersteller_code = staging.fahrzeug.hersteller_code
    inner join staging.kfzzuordnung on staging.kfzzuordnung.fin = staging.fahrzeug.fin
)
select f.fin, f.baujahr, f.modell, f.hersteller, f.kfz_kennzeichen, f.d_fahrzeug_key
from w_fahrzeug f