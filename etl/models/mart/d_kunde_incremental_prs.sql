{{
    config(
        materialized='table'
    )
}}

with w_kunde as (
    SELECT staging.kunde.kunde_id, staging.kunde.vorname, staging.kunde.nachname, staging.kunde.anrede,
    staging.kunde.geschlecht, staging.kunde.geburtsdatum, staging.ort.ort, staging.land.land from staging.kunde
    inner join staging.ort on staging.ort.ort_id = staging.kunde.wohnort
    inner join staging.land on staging.land.land_id = staging.ort.land_id
)
select k.kunde_id, k.vorname, k.nachname, k.anrede,
    k.geschlecht, k.geburtsdatum, k.ort, k.land
from w_kunde k