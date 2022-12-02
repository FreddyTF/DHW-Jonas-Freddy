{{
    config(
        materialized='view'
    )
}}

with w_messung as (
    SELECT
        staging.fahrzeug.kunde_id as d_kunde_key,
        payload ->> 'ort' as d_ort_messung_key,
        payload ->> 'fin' as d_fahrzeug_key,
        staging.messung.erstellt_am as messung_eingetroffen,
        payload ->> 'zeit' as messung_erzeugt, 
        payload ->> 'geschwindigkeit' as geschwindigkeit 
    from staging.messung
    inner join staging.fahrzeug 
        on staging.fahrzeug.fin = 
        (staging.messung.payload ->> 'fin')
)

select m.d_kunde_key, m.d_ort_messung_key, m.d_fahrzeug_key, m.messung_eingetroffen, m.messung_erzeugt, m.geschwindigkeit
from w_messung m
