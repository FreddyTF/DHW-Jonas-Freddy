drop schema staging cascade;

create schema staging;

create table staging.hersteller (
     hersteller_code char(3) not null
   , hersteller varchar(200) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_hersteller PRIMARY KEY(hersteller_code)
);

create table staging.land (
     land_id integer not null
   , land varchar(200) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_land PRIMARY KEY(land_id)
);

create table staging.ort (
     ort_id integer not null
   , ort varchar(200) not null
   , land_id integer not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_ort PRIMARY KEY(ort_id)
   --, CONSTRAINT fk_o_land FOREIGN KEY(land_id) REFERENCES staging.land(land_id)
);

create table staging.kunde (
     kunde_id integer not null
   , vorname varchar(200) not null
   , nachname varchar(200) not null
   , anrede varchar(20) 
   , geschlecht varchar(20) not null 
   , geburtsdatum date
   , wohnort integer not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_kunde PRIMARY KEY(kunde_id)
   , CONSTRAINT fk_k_ort FOREIGN KEY(wohnort) REFERENCES staging.ort(ort_id)
);

create table staging.fahrzeug (
     fin char(17) not null
   , hersteller_code char(3) GENERATED ALWAYS AS (substring(fin from 1 for 3)) stored
   , kunde_id integer
   , baujahr integer not null
   , modell varchar(200) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_fahrzeug PRIMARY KEY(fin)
   , CONSTRAINT fk_f_hersteller FOREIGN KEY(hersteller_code) REFERENCES staging.hersteller(hersteller_code)
   , CONSTRAINT fk_f_kunde FOREIGN KEY(kunde_id) REFERENCES staging.kunde(kunde_id)
);

create table staging.kfzzuordnung (
     fin char(17) not null
   , kfz_kennzeichen varchar(20) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_kfzzuordnung PRIMARY KEY(fin, kfz_kennzeichen)
   , CONSTRAINT fk_k_fahrzeug FOREIGN KEY(fin) REFERENCES staging.fahrzeug(fin)
);

create table staging.messung (
     messung_id bigint GENERATED ALWAYS AS IDENTITY
   , payload JSON not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) DEFAULT 'MQTT'
   , CONSTRAINT pk_messung PRIMARY KEY(messung_id)
);



