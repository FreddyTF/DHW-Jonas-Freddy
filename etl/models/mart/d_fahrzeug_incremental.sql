{{
    config(
        materialized='incremental'
    )
}}

with w_fahrzeug as (
    SELECT staging.fahrzeug.fin, staging.fahrzeug.baujahr, staging.fahrzeug.modell, 
    staging.hersteller.hersteller, staging.kfzzuordnung.kfz_kennzeichen from staging.fahrzeug
    inner join staging.hersteller on staging.hersteller.hersteller_code = staging.fahrzeug.hersteller_code
    inner join staging.kfzzuordnung on staging.kfzzuordnung.fin = staging.fahrzeug.fin
)
select f.fin, f.baujahr, f.modell, f.hersteller, f.kfz_kennzeichen
from w_fahrzeug f