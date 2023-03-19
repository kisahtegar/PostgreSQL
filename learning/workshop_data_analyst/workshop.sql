-- DATE: 19/03/2023

-- =========================================================
-- SELECT * FROM mst_cabang
-- SELECT * FROM mst_kategori
-- SELECT * FROM mst_produk
-- SELECT * FROM mst_harga_harian
-- SELECT * FROM trans_penjualan

-- =========================================================

-- // Import CSV File ke dalam database
-- COPY mst_harga_harian
-- FROM 'C:\data\tableau\backup\mst_harga_harian.csv'
-- DELIMITER ';'
-- CSV HEADER;

-- =========================================================
-- // Join tabel
-- SELECT tp.id_transaksi,
--  tp.tanggal_transaksi as tgl_transaksi,
--  tp.kode_cabang,
--  mc.nama_cabang,
--  tp.kode_kasir,
--  tp.kode_item,
--  tp.kode_produk,
--  mp.nama_produk,
--  mp.kode_kategori,
--  mk.nama_kategori,
--  mp.unit,
--  mp.kode_satuan,
--  mh.harga_berlaku_cabang,
--  mh.modal_cabang,
--  mh.biaya_cabang,
--  tp.qty_pembelian
 
-- FROM trans_penjualan tp
-- LEFT JOIN mst_cabang mc ON tp.kode_cabang = mc.kode_cabang
-- LEFT JOIN mst_produk mp ON tp.kode_produk = mp.kode_produk
-- LEFT JOIN mst_kategori mk ON mp.kode_kategori = mk.kode_kategori
-- LEFT JOIN mst_harga_harian mh ON tp.kode_produk = mh.kode_produk
-- AND tp.tanggal_transaksi = mh.tanggal_berlaku
-- order by id_transaksi;

-- =========================================================

-- Buat tabel penampung dengan nama “dt_trans_penjualan” dengan query Insert INTO
-- Export tabel “dt_trans_penjualan” ke dalam file .csv
-- COPY dt_trans_penjualan
-- TO 'C:\data\tableau\backup\dt_trans_penjualan.csv'
-- DELIMITER ';'
-- CSV HEADER;

-- =========================================================