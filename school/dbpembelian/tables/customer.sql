CREATE TABLE IF NOT EXISTS public.customer (
	id_customer BIGSERIAL NOT NULL PRIMARY KEY,
	nama_customer VARCHAR(40) NOT NULL,
	alamat_customer VARCHAR(100) NOT NULL,
	telepon_customer VARCHAR(15) NOT NULL
);
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (1, 'Hobie', '07251 Bartillon Terrace', '+3728629091374');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (2, 'Gabbie', '56 Armistice Trail', '+625808791787');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (3, 'Zak', '293 Mariners Cove Park', '+635235129487');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (4, 'Boot', '78572 Hoepker Lane', '+628378551255');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (5, 'Clarisse', '043 Upham Parkway', '+335783792872');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (6, 'Elspeth', '7998 Schiller Terrace', '+353339316936');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (7, 'Pavla', '6631 Roxbury Point', '+621312400185');
insert into customer (id_customer, nama_customer, alamat_customer, telepon_customer) values (8, 'Pooh', '98 Center Center', '+337529453177');