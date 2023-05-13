CREATE TABLE IF NOT EXISTS public.supplier (
	kode_supplier CHARACTER(6) COLLATE  pg_catalog."default" NOT NULL PRIMARY KEY,
	nama_supplier VARCHAR(40) NOT NULL,
	alamat_supplier VARCHAR(100) NOT NULL,
	telepon_supplier VARCHAR(15) NOT NULL
);