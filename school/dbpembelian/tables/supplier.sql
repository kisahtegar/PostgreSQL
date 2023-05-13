CREATE TABLE IF NOT EXISTS public.supplier (
	kode_supplier BIGSERIAL NOT NULL PRIMARY KEY,
	nama_supplier VARCHAR(40) NOT NULL,
	alamat_supplier VARCHAR(100) NOT NULL,
	telepon_supplier VARCHAR(15) NOT NULL
);
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (1, 'Rakel', '200 Susan Trail', '+383628224365');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (2, 'Corilla', '52 Ronald Regan Pass', '+15614262438');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (3, 'Ced', '71199 High Crossing Road', '+865892184198');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (4, 'Henrieta', '57 Oakridge Court', '+862131582540');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (5, 'Barnabas', '6557 Sundown Way', '+373813997649');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (6, 'Rahel', '0561 Sunfield Way', '+555392600114');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (7, 'Liana', '2102 Quincy Crossing', '+74685253147');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (8, 'Kassandra', '54 Lerdahl Point', '+862361321074');
insert into supplier (id_supplier, nama_supplier, alamat_supplier, telepon_supplier) values (9, 'Barrie', '6 Lakewood Gardens Plaza', '+463929503223');