-- TODO: Change keterangan.

CREATE TABLE IF NOT EXISTS public.transaksi_penjualan (
	kode_transaksi BIGSERIAL NOT NULL PRIMARY KEY,
	tanggal_transaksi DATE NOT NULL,
	keterangan VARCHAR(10) NOT NULL,
	kode_barang BIGINT REFERENCES barang (kode_barang),
	id_customer BIGINT REFERENCES customer (id_customer),
	UNIQUE(kode_barang),
	UNIQUE(id_customer)
);
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (1, '29-07-2022', 'Berhasil');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (2, '15-01-2023', 'Gagal');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (3, '18-10-2022', 'Pending');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (4, '25-06-2022', 'Pending');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (5, '02-08-2022', 'Berhasil');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (6, '25-09-2022', 'Berhasil');
INSERT INTO transaksi_penjualan (kode_transaksi, tanggal_transaksi, keterangan) VALUES (7, '10-08-2022', 'Gagal');