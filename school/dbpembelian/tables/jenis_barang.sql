-- TODO: Add/edit nama_jenis_barang.

CREATE TABLE IF NOT EXISTS public.jenis_barang (
	id_jenis_barang BIGSERIAL NOT NULL PRIMARY KEY,
	nama_jenis_barang VARCHAR(10) NOT NULL
);
INSERT INTO jenis_barang (id_jenis_barang, nama_jenis_barang) values (1, 'Baku');
INSERT INTO jenis_barang (id_jenis_barang, nama_jenis_barang) values (2, 'Jadi');
INSERT INTO jenis_barang (id_jenis_barang, nama_jenis_barang) values (3, 'Rusak');