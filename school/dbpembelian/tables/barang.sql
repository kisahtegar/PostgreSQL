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
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (1, 'Kulkas', 15, '1065.83', 'KG');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (2, 'Kulkas', 74, '1537.27', 'BOX');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (3, 'Kulkas', 92, '2376.30', 'PCS');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (4, 'Kulkas', 33, '6236.95', 'KG');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (5, 'Kulkas', 51, '3856.45', 'BOX');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (6, 'Kulkas', 53, '8798.87', 'BOX');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (7, 'Kulkas', 79, '2230.35', 'PCS');
INSERT INTO barang (kode_barang, nama_barang, stok_barang, harga_barang, kode_satuan) VALUES (8, 'Kulkas', 98, '8772.94', 'SET');
