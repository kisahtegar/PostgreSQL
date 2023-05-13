CREATE TABLE IF NOT EXISTS public.transaksi (
	kode_faktur CHARACTER(6) COLLATE  pg_catalog."default" NOT NULL PRIMARY KEY,
	tanggal_transaksi DATE NOT NULL,
	kode_supplier CHARACTER(6) REFERENCES supplier (kode_supplier),
	UNIQUE(kode_supplier)
);