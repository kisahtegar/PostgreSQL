CREATE TABLE IF NOT EXISTS public.daftar_barang (
    kode_barang character(6) COLLATE pg_catalog."default" NOT NULL PRIMARY KEY,
	nama_barang VARCHAR(255) NOT NULL,  
	jenis_barang VARCHAR(10)
);