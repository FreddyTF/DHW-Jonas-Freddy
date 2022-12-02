{% snapshot d_kunde_snapshot %}

{{
    config(
        target_schema='staging',
        unique_key='d_kunde_key',
        strategy='timestamp',
        updated_at='erstellt_am',
    )
}}


with w_kunde as (
    SELECT 
    row_number() over (order by staging.kunde.kunde_id) as d_kunde_key,
    staging.kunde.kunde_id, 
    staging.kunde.vorname, 
    staging.kunde.nachname, 
    staging.kunde.anrede,
    staging.kunde.geschlecht, staging.kunde.geburtsdatum, staging.ort.ort, staging.land.land, staging.kunde.erstellt_am from staging.kunde
    inner join staging.ort on staging.ort.ort_id = staging.kunde.wohnort
    inner join staging.land on staging.land.land_id = staging.ort.land_id
)
select 
k.d_kunde_key,
k.kunde_id, k.vorname, 
k.nachname, k.anrede, 
k.erstellt_am,
    k.geschlecht, k.geburtsdatum, k.ort, k.land
from w_kunde k

{% endsnapshot %}