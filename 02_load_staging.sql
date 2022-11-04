
insert into staging.hersteller (hersteller_code, hersteller, quelle)
  values 
      ('WDD', 'Mercedes-Benz', 'WMI database')
	, ('WVW', 'Volkswagen', 'WMI database')
	, ('WBA', 'BMW', 'WMI database')
	, ('WB1', 'BMW Motorrad', 'WMI database')
	, ('1FM', 'Ford', 'WMI database')
	, ('ZFF', 'Ferrari', 'WMI database')
	, ('WMA', 'MAN', 'WMI database')
	, ('WAU', 'Audi', 'WMI database')
	, ('WPO', 'Porsche', 'WMI database')
	, ('SCC', 'Lotus', 'WMI database')
	, ('WOL', 'Opel', 'WMI database')
	, ('VF1', 'Renault', 'WMI database')
	, ('SNT', 'Sachsenring Automobilwerke Zwickau GmbH', 'WMI database')
;


insert into staging.land (land_id, land, quelle) values 
      (101, 'Deutschland', 'Geo System')
	, (102, 'Österreich', 'Geo System')
	, (103, 'Mittelerde', 'Geo System')
	, (104, 'Schweiz', 'Geo System')
	, (105, 'China', 'Geo System')
;

insert into staging.ort (ort_id, ort, land_id, quelle) values 
      (1, 'Stuttgart', 101, 'Geo System')
	, (2, 'München', 101, 'Geo System')
	, (3, 'Frankfurt', 101, 'Geo System')
	, (4, 'Türmli', 104, 'Geo System')
	, (5, 'Xian', 105, 'Geo System')
	, (6, 'Peking', 105, 'Geo System')
	, (7, 'Valmar', 103, 'Geo System')
	, (8, 'Númenor', 103, 'Geo System')
	, (9, 'Wien', 102, 'Geo System')
	, (10, 'Rot a.d. Rot', 100, 'Geo System')
;
	


insert into staging.kunde (kunde_id, vorname, nachname, anrede, geschlecht, geburtsdatum, wohnort, quelle)
  values (171893, 'Kevin', 'Minion', 'Herr', 'männlich', to_date('12.02.1990', 'DD.MM.YYYY'), 7, 'CRM');

insert into staging.fahrzeug (fin, kunde_id, baujahr, modell, quelle)
  values ('SNTU411STM9032150', 171893, 1985, 'Trabant 601 de luxe', 'Fahrzeug DB');

insert into staging.kfzzuordnung (fin, kfz_kennzeichen, quelle)
  values ('SNTU411STM9032150', 'UL-DV 111', 'Fahrzeug DB');
