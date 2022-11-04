insert into staging.kunde (kunde_id, vorname, nachname, anrede, geschlecht, geburtsdatum, wohnort, quelle)
values (171893, ‚Kevin', Minion', 'Herr', 'männlich', to_date('12.02.1990', 'DD.MM.YYYY'), 7, 'CRM');
insert into staging.fahrzeug (fin, kunde_id, baujahr, modell, quelle)
values ('SNTU411STM9032150', 171893, 1985, 'Trabant 601 de luxe', 'Fahrzeug DB');
insert into staging.kfzzuordnung (fin, kfz_kennzeichen, quelle)
values ('SNTU411STM9032150', 'UL-DV 111', 'Fahrzeug DB');