insert into staging.kunde (kunde_id, vorname, nachname, anrede, geschlecht, geburtsdatum, wohnort, quelle)
values (171894, 'Max', 'Musterman', 'Herr', 'männlich', to_date('12.02.1990', 'DD.MM.YYYY'), 7, 'CRM');
		
insert into staging.fahrzeug (fin, kunde_id, baujahr, modell, quelle)
values ('WDDU411STM9032150', 171893, 1985, 'Mercedes', 'Fahrzeug DB');

insert into staging.kfzzuordnung (fin, kfz_kennzeichen, quelle)
values ('WDDU411STM9032150', 'FR-FR 701', 'Fahrzeug DB');