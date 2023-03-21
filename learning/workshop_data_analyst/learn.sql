-- DATE: 19/03/2023


-- =========================================================
-- # Buat Tabel baru “mst_cabang” 
CREATE TABLE IF NOT EXISTS public.mst_cabang ( 
    kode_cabang character(10) COLLATE pg_catalog."default", 
    nama_cabang text COLLATE pg_catalog."default", 
    kode_kota character(8) COLLATE pg_catalog."default" 
) 

-- # Buat Tabel baru “mst_harga_harian” 
CREATE TABLE IF NOT EXISTS public.mst_harga_harian ( 
    kode_produk character(12) COLLATE pg_catalog."default" NOT NULL, 
    tgl_berlaku character varying(20) COLLATE pg_catalog."default", 
    tanggal_berlaku date, 
    harga_berlaku_cabang integer, 
    modal_cabang integer, 
    biaya_cabang integer 
) 
 
-- # Buat Tabel baru “mst_kategori” 
CREATE TABLE IF NOT EXISTS public.mst_kategori ( 
    kode_kategori character(7) COLLATE pg_catalog."default", 
    nama_kategori character varying(50) COLLATE pg_catalog."default" 
) 

-- # Buat Tabel baru “mst_produk” 
CREATE TABLE IF NOT EXISTS public.mst_produk ( 
    kode_produk character(12) COLLATE pg_catalog."default", 
    kode_kategori character(7) COLLATE pg_catalog."default", 
    nama_produk character varying(255) COLLATE pg_catalog."default", 
    unit integer, 
    kode_satuan character varying(20) COLLATE pg_catalog."default" 
) 

-- # Buat Tabel baru “trans_penjualan” 
CREATE TABLE IF NOT EXISTS public.trans_penjualan ( 
    id_transaksi bigint NOT NULL, 
    tgl_transaksi character varying(10) COLLATE pg_catalog."default", 
    tanggal_transaksi date, 
    kode_cabang character(10) COLLATE pg_catalog."default", 
    kode_kasir character(7) COLLATE pg_catalog."default", 
    kode_item character(7) COLLATE pg_catalog."default", 
    kode_produk character(12) COLLATE pg_catalog."default", 
    qty_pembelian integer 
)


-- =========================================================
-- # Import CSV File ke dalam database 
COPY mst_cabang 
FROM 'D:\Indra\Tableau\Unipi\Data\mst_cabang.csv' 
DELIMITER ';' 
CSV HEADER; 
 
COPY mst_kategori 
FROM 'D:\Indra\Tableau\Unipi\Data\mst_kategori.csv' 
DELIMITER ';' 
CSV HEADER; 
 
COPY mst_produk 
FROM 'D:\Indra\Tableau\Unipi\Data\mst_produk.csv' 
DELIMITER ';' 
CSV HEADER;

COPY mst_harga_harian 
FROM 'D:\Indra\Tableau\Unipi\Data\mst_harga_harian.csv' 
DELIMITER ';' 
CSV HEADER; 
 
COPY trans_penjualan 
FROM 'D:\Indra\Tableau\Unipi\Data\trans_penjualan.csv' 
DELIMITER ';' 
CSV HEADER;


-- =========================================================
-- # Pengecekan Data
SELECT * FROM mst_cabang
SELECT * FROM mst_kategori
SELECT * FROM mst_produk
SELECT * FROM mst_harga_harian
SELECT * FROM trans_penjualan


-- =========================================================
-- # Join tabel
SELECT tp.id_transaksi,
 tp.tanggal_transaksi as tgl_transaksi,
 tp.kode_cabang,
 mc.nama_cabang,
 tp.kode_kasir,
 tp.kode_item,
 tp.kode_produk,
 mp.nama_produk,
 mp.kode_kategori,
 mk.nama_kategori,
 mp.unit,
 mp.kode_satuan,
 mh.harga_berlaku_cabang,
 mh.modal_cabang,
 mh.biaya_cabang,
 tp.qty_pembelian
 
FROM trans_penjualan tp
LEFT JOIN mst_cabang mc ON tp.kode_cabang = mc.kode_cabang
LEFT JOIN mst_produk mp ON tp.kode_produk = mp.kode_produk
LEFT JOIN mst_kategori mk ON mp.kode_kategori = mk.kode_kategori
LEFT JOIN mst_harga_harian mh ON tp.kode_produk = mh.kode_produk
AND tp.tanggal_transaksi = mh.tanggal_berlaku
order by id_transaksi;


-- =========================================================
-- # Buat tabel penampung dengan nama “dt_trans_penjualan” dengan query Insert INTO
-- # sExport tabel “dt_trans_penjualan” ke dalam file .csv
COPY dt_trans_penjualan
TO 'C:\data\tableau\backup\dt_trans_penjualan.csv'
DELIMITER ';'
CSV HEADER;


-- =========================================================