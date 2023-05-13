CREATE TABLE IF NOT EXISTS public.daftar_pembelian (
	kode_pembelian CHARACTER(6) COLLATE  pg_catalog."default" NOT NULL PRIMARY KEY,
	jumlah integer NOT NULL,
    harga_barang NUMERIC(19) NOT NULL,
	kode_faktur CHARACTER(6) REFERENCES transaksi (kode_faktur),
	kode_barang CHARACTER(6) REFERENCES daftar_barang (kode_barang),
	UNIQUE(kode_faktur),
	UNIQUE(kode_barang)
);