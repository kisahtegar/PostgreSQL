-- TODO: Change nama_barang, kode_satuan.
-- Pcs
-- Set
-- Box
-- Kg
-- Kardus
-- Meter    

CREATE TABLE IF NOT EXISTS public.barang (
	kode_barang BIGSERIAL NOT NULL PRIMARY KEY,
	nama_barang VARCHAR(40) NOT NULL,
    stok_barang INT NOT NULL,
	harga_barang NUMERIC(19,2) NOT NULL,
	kode_satuan VARCHAR(5) NOT NULL,
	id_jenis_barang BIGINT REFERENCES jenis_barang (id_jenis_barang),
	id_supplier BIGINT REFERENCES supplier (id_supplier),
	UNIQUE(id_jenis_barang),
	UNIQUE(id_supplier)
);
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (1, 'Batik', 15, '1065.83', 'PCS');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (2, 'Jacket', 74, '1537.27', 'KODI');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (3, 'Sweater', 92, '2376.30', 'LUSIN');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (4, 'Crewneck', 33, '6236.95', 'GRIM');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (5, 'Kemeja', 51, '3856.45', 'BOX');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (6, 'Flanel', 53, '8798.87', 'BOX');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (7, 'Koko pria', 79, '2230.35', 'PCS');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (8, 'Gamis', 98, '8772.94', 'SET');
