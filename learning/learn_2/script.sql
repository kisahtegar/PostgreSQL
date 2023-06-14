--
-- [DATABASE] ======================================================
---

-- -----------------------------------------------------------------
-- # Menggunakan PostgreSQL Client
-- psql --host=localhost --port=5432 --dbname=dblearn2 --username=postgres --password

-- -----------------------------------------------------------------
-- # Membuat Database
create database nama_database;



--
-- [TABLE] =========================================================
--

-- -----------------------------------------------------------------
-- # Melihat table
-- \dt
select *
from pg_tables
where schemaname = 'public';


-- -----------------------------------------------------------------
-- # Membuat table
create table barang (
    kode         int          not null,
    name         varchar(100) not null,
    harga        int          not null default 1000,
    jumlah       int          not null default 0,
    waktu_dibuat TIMESTAMP    not null default current_timestamp
);

-- -----------------------------------------------------------------
-- # Mengubah table
alter table barang
    add column deskripsi text;

alter table barang
    drop column deskripsi;

alter table barang
    rename column name to nama;

-- -----------------------------------------------------------------
-- # Membuat ulang table
truncate barang;

-- -----------------------------------------------------------------
-- # Menghapus table
drop table barang;



--
-- [INSERT DATA] ===================================================
--

-- Sebelum kita meng memasukkan data kedalam tabel, tabel harus dibuat terlebih dahulu.
-- Kita bisa menyebutkan kolom mana yang ingin kita isi, jika kita tidak menyebutkan kolom nya, 
-- artinya kolom tersebut tidak akan kita isi, dan secara otomatis kolom yang tidak kita isi, 
-- nilainya akan NULL, kecuali memiliki DEFAULT VALUE.
-- Untuk memasukkan data kedalam tabel, kita bisa menggunakan perintah SQL yang bernama INSERT.

-- -----------------------------------------------------------------
-- # Membuat table product
create table products (
    id          varchar(10)  not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null default 0,
    created_at  timestamp    not null default current_timestamp
);

-- -----------------------------------------------------------------
-- # Memasukan Data
insert into products(id, name, price, quantity)
values ('P0001', 'Mie Ayam Original', 15000, 100);

insert into products(id, name, description, price, quantity)
values ('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

insert into products(id, name, price, quantity)
values ('P0003', 'Mie Ayam Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Spesial', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 15000, 100);

      
      
--
-- [SELECT DATA] ===================================================
--      

-- Untuk mengambil data di tabel, kita bisa menggunakan SQL dengan kata kunci SELECT
-- SELECT bisa digunakan untuk mengambil semua kolom yang ada di tabel, atau sebagian kolom saja
-- Jika kita ingin mengambil semua kolom, kita bisa gunakan karakter * (bintang)
-- Jika kita hanya ingin mengambil beberapa kolom saja, kita bisa sebutkan nama-nama kolom yang ingin kita ambil datanya

-- -----------------------------------------------------------------
-- # Mengambil Data
select * from products;

select id, name, price, quantity
from products;


--
-- [PRIMARY KEY] ===================================================
--      

-- Saat kita membuat tabel, idealnya tiap tabel memiliki Primary Key
-- Primary key adalah sebuah kolom yang kita tunjuk sebagai id dari tabel tersebut
-- Primary key adalah identitas untuk tiap baris data di dalam tabel
-- Primary key harus unik, tidak boleh ada data dengan primary key yang sama
-- Kita bisa menunjuk kolom yang akan kita jadikan primary key

-- [Primary key di Multiple column]
-- Kita bisa membuat primary key dengan kombinasi beberapa kolom
-- Namun disarankan untuk tetap menggunakan satu kolom ketika membuat primary key
-- Kecuali ada kasus khusus, seperti membuat tabel yang berelasi MANY TO MANY (yang nanti akan kita bahas)

-- -----------------------------------------------------------------
-- # Menambah Primary Key ketika membuat table.
create table products (
    id          varchar(10)  not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null default 0,
    created_at  timestamp    not null default current_timestamp,
    primary key (id)
);

-- -----------------------------------------------------------------
-- # Menambah Primary Key di table
alter table products
    add primary key (id);



--
-- [WHERE CLAUSE] ==================================================
--      

-- Saat mengambil data menggunakan perintah SQL SELECT, kadang kita ingin melakukan pencarian data
-- Misal, kita ingin mengambil data barang yang harganya 1jt, atau mengambil data barang yang quantity nya 0 (stok nya kosong)
-- Hal ini bisa kita lakukan dengan WHERE clause setelah perintah SELECT

-- -----------------------------------------------------------------
-- # Mencari Data
select id, name, price, quantity
from products
where quantity = 0;

select id, name, price, quantity
from products
where price = 20000;

select id, name, price, quantity
from products
where id = 'P0004';

select *
from products;


--
-- [UPDATE DATA] ===================================================
--      

-- Untuk mengubah data di tabel, kita bisa menggunakan perintah SQL UPDATE
-- Saat menggunakan SQL UPDATE, kita harus memberi tahu data mana yang akan di update dengan WHERE clause
-- Hati-hati ketika meng-update data di table, jika sampai WHERE clause nya salah, bisa-bisa kita malah meng-update seluruh data di tabel
-- Untuk update, kita harus beritahu, kolom mana yang akan di update

-- -----------------------------------------------------------------
-- # Menambah Kolom Kategori
create type PRODUCT_CATEGORY as enum ('Makanan', 'Minuman', 'Lain-Lain');

alter table products
    add column category PRODUCT_CATEGORY;

-- -----------------------------------------------------------------
-- # Mengubah satu kolom
select * from products;
   
update products
set category = 'Makanan'
where id = 'P0001';

update products
set category = 'Makanan'
where id = 'P0002';

update products
set category = 'Makanan'
where id = 'P0003';

update products
set category = 'Makanan'
where id = 'P0004';

update products
set category = 'Makanan'
where id = 'P0005';

-- -----------------------------------------------------------------
-- # Mengubah beberapa kolom
update products
set category    = 'Makanan',
    description = 'Mie Ayam + Ceker'
where id = 'P0003';

SELECT * from products;

-- -----------------------------------------------------------------
-- # Mengubah dengan value di kolom
update products
set price = price + 5000
where id = 'P0004';

SELECT * from products;



--
-- [DELETE DATA] ===================================================
--      

-- Setelah kita tahu cara menambah, mengubah dan mengambil data di tabel, terakhir yang perlu kita ketahui adalah menghapus data di table
-- Untuk menghapus data di table, kita bisa menggunakan perintah SQL DELETE
-- Perintah SQL DELETE sama seperti UPDATE, kita perlu memberi tahu data mana yang akan di hapus dengan WHERE clause
-- Dan hati-hati, jangan sampai salah menentukan WHERE clause, karena jika salah, bisa-bisa kita akan menghapus seluruh data di table


-- -----------------------------------------------------------------
-- # Menghapus Data
SELECT * from products;

insert into products(id, name, price, quantity, category)
values ('P0009', 'Contoh', 10000, 100, 'Minuman');

delete
from products
where id = 'P0009';



--
-- [ALIAS] ===================================================
--

-- PostgreSQL memiliki fitur untuk melakukan alias untuk kolom dan tabel
-- Alias berguna jika kita ingin mengubah nama kolom atau nama tabel ketika melakukan SELECT data
-- Mungkin saat ini alias untuk tabel tidak terlalu terlihat gunanya, tapi nanti ketika kita telah mempelajari tentang JOIN, maka fitur alias untuk tabel sangat berguna sekali


-- -----------------------------------------------------------------
-- # Alias untuk Kolom
select id as "Kode Barang", price as "Harga Barang", description as Deskripsi
from products;

-- -----------------------------------------------------------------
-- # Alias untuk Tabel
select p.id          as "Kode Barang",
       p.price       as "Harga Barang",
       p.description as "Deskripsi Barang"
from products as p;



--
-- [WHERE OPERATOR] ================================================
--      

-- Sebelumnya di materi where clause kita sudah menggunakan operator = (sama dengan)
-- Sebenarnya sangat banyak sekali operator yang bisa kita gunakan ketika menggunakan where clause
-- Sekarang kita akan bahas satu per satu


-- -----------------------------------------------------------------
-- # Operator Perbandingan

-- =           Sama dengan
-- <> atau !=  Tidak sama dengan
-- <           Kurang dari
-- <=          Kurang dari atau sama dengan
-- >           Lebih dari
-- >=          Lebih dari atau sama dengan

-- # Mencari data dengan operator perbandingan
select *
from products
where price > 15000;

select *
from products
where price <= 15000;

select *
from products
where category != 'Minuman';

-- -----------------------------------------------------------------
-- # Operator AND dan OR
SELECT * FROM products;

insert into products(id, name, price, quantity, category)
values ('P0006', 'Es teh tawar', 10000, 100, 'Minuman'),
       ('P0007', 'Es Campur', 20000, 100, 'Minuman'),
       ('P0008', 'Just Jeruk', 15000, 100, 'Minuman');

select *
from products
where price > 15000
   or category = 'Makanan';

select *
from products
where price > 15000
  and category = 'Makanan';

select *
from products
where quantity > 100
   OR category = 'Makanan' and price > 15000;

-- # Prioritas dengan kurung ()
select *
from products
where category = 'Makanan'
   or (quantity > 100 and price > 15000);

-- -----------------------------------------------------------------
-- # Operator LIKE
  
-- LIKE operator adalah operator yang bisa kita gunakan untuk mencari sebagian data dalam String
-- Ini cocok sekali ketika kita hanya ingin mencari sebagian kata dalam String
-- Namun perlu diingat, operasi LIKE itu sangat lambat, oleh karena itu, tidak disarankan jika datanya sudah terlalu besar di tabel
-- Operasi LIKE case sensitive, jadi huruf besar dan kecil juga berpengaruh, jika kita ingin tidak case sensitive, bisa menggunakan ILIKE

-- LIKE ‘b%’     String dengan awalan b
-- LIKE ‘%a’     String dengan akhiran a
-- LIKE ‘%kisah%’  String berisi kisah
-- NOT LIKE      Tidak LIKE

select *
from products
where name ilike '%es%';

-- -----------------------------------------------------------------
-- # Operator Null

-- Untuk mencari data yang berisi NULL, kita tidak bisa menggunakan operator perbandingan = NULL.
-- Ada operator khusus untuk mencari data NULL, yaitu menggunakan NULL operator
-- IS NULL, artinya mencari yang NULL
-- IS NOT NULL, artinya mencari yang tidak NULL

select *
from products
where description is null;

select *
from products
where description is not null;

-- -----------------------------------------------------------------
-- # Operator Between

-- Kadang kita ingin mencari data yang >= dan <= secara sekaligus
-- Misal kita ingin mencari products yang harganya antara 10000 sampai 20000
-- Untuk melakukan ini, kita bisa menggunakan WHERE price >= 10000 AND price <= 20000
-- Namun ada operator BETWEEN yang bisa kita gunakan agar lebih sederhana
-- Untuk kebalikannya, kita bisa gunakan NOT BETWEEN

select *
from products
where price between 10000 and 20000;

select *
from products
where price not between 10000 and 20000;

-- -----------------------------------------------------------------
-- # Operator IN

-- Operator IN adalah operator untuk melakukan pencarian sebuah kolom dengan beberapa nilai.
-- Misal kita ingin mencari products dengan category Makanan atau Minuman, maka kita bisa menggunakan operator IN
-- Untuk kebalikannya, kita bisa menggunakan NOT IN

select *
from products
where category in ('Makanan', 'Minuman');



--
-- [ORDER BY CLAUSE] ===============================================
--      

-- Untuk mengurutkan data ketika kita menggunakan perintah SQL SELECT, kita bisa menambahkan ORDER BY clause
-- ORDER BY clause digunakan untuk mengurutkan data berdasarkan kolom yang dipilih, dan jenis urutan (ASC atau DESC)
-- Kita juga bisa mengurutkan tidak hanya terhadap satu kolom, tapi beberapa kolom


-- -----------------------------------------------------------------
-- # Mengurutkan Data
select *
from products
order by price asc, id desc;

select *
from products
where price > 0
order by price asc, id desc;


--
-- [LIMIT CLAUSE] ===================================================
--      

-- Mengambil seluruh data di tabel bukanlah pilihan bijak, apalagi jika datanya sudah banyak sekali
-- Kita bisa membatasi jumlah data yang diambil dalam SQL SELECT dengan LIMIT clause
-- Selain membatasi jumlah data, kita juga bisa meng-skip sejumlah data yang tidak ingin kita lihat
-- LIMIT biasanya digunakan saat melakukan paging di aplikasi kita, dengan kombinasi OFFSET


-- -----------------------------------------------------------------
-- # Membatasi Hasil Query
select *
from products
where price > 0
order by price asc, id desc
limit 2;

-- 1 limit 2 offset 0, 2 limit 2 offset 2, 3 limit 2 offset 4
select *
from products
where price > 0
order by price asc, id desc
limit 2 offset 2;



--
-- [SELECT DISTINCT DATA] ==========================================
--      

-- Saat melakukan query dengan SELECT, kadang kita mendapatkan data yang duplikat
-- Misal kita ingin melihat semua kategori di tabel products, maka otomatis hasil query SELECT 
-- akan duplikat, karena banyak sekali produk dengan kategori yang sama
-- Jika kita ingin menghilangkan data-data duplikat tersebut , kita bisa menggunakan SELECT dengan 
-- tambahan DISTINCT sebelum nama kolom nya

select category from products;
-- -----------------------------------------------------------------
-- # Menghilangkan data duplikat
select distinct category
from products;



--
-- [NUMERIC FUNCTION] ==============================================
--      

-- -----------------------------------------------------------------
-- # Arithmetic Operator.
select 10 + 10 as hasil;

select id, name, price / 1000 as price_in_k
from products;

-- -----------------------------------------------------------------
-- # Mathematical Function

-- https://www.postgresql.org/docs/15/functions-math.html

select pi();

select power(10, 2);

select cos(10), sin(10), tan(10);

select id, name, power(quantity, 2) as quantity_power_2
from products;


--
-- [AUTO INCREMENT] ================================================
--      

-- Kadang kita butuh angka yang berurut untuk membuat primary key, misal 1, 2, 3, dan seterusnya.
-- Untuk melakukan hal ini secara manual bukanlah hal bijak, apalagi jika aplikasi yang kita buat diakses oleh 
-- banyak orang secara bersamaan
-- PostgreSQL memiliki tipe data Number bernama SERIAL, fitur ini bisa kita gunakan untuk membuat function yang 
-- akan otomatis mengembalikan nilai yang selalu naik ketika dipanggil
-- Dengan menggunakan SERIAL, kita tidak perlu lalu memasukkan data primary key secara manual, secara otomatis 
-- nilai primary key akan naik


-- -----------------------------------------------------------------
-- # Membuat table dengan Auto Increment
create table admin (
    id         serial       not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id)
);

-- -----------------------------------------------------------------
-- # Memasukkan data tanpa ID
insert into admin(first_name, last_name)
values ('Eko', 'Khannedy'),
       ('Budi', 'Nugraha'),
       ('Joko', 'Morro');

select * from admin;

-- -----------------------------------------------------------------
-- # Melihat ID terakhir
select currval('admin_id_seq');


--
-- [SEQUENCE] =====================================================
--      

-- Saat kita menggunakan tipe data SERIAL, sebenarnya dibelakangnya, PostgreSQL menggunakan Sequence
-- Sequence adalah fitur dimana kita bisa membuat function auto increment
-- Saat menggunakan tipe data SERIAL pada Primary Key, secara otomatis PostgreSQL akan membuat Sequence, dan memanggil function sequence nya sebagai default value untuk Primary Key nya

-- -----------------------------------------------------------------
-- # Membuat Sequence
create sequence contoh_sequence;

-- # Memanggil Sequence, otomatis increment.
select nextval('contoh_sequence');

-- # Mengambil nilai terakhir sequence
select currval('contoh_sequence');



--
-- [STRING FUNCTION] ===============================================
--      

-- Sama seperti number, di PostgreSQL juga banyak menyediakan function untuk tipe data String
-- Ada banyak sekali function-function yang bisa kita gunakan
-- https://www.postgresql.org/docs/15/functions-string.html

-- -----------------------------------------------------------------
-- # Menggunakan String function
select id, name, description 
from products;

select id, lower(name), length(name), lower(description)
from products;




--
-- [DATETIME FUNCTION] =============================================
--      

-- PostgreSQL juga menyediakan banyak sekali function yang bisa kita gunakan untuk mengolah data tipe Date dan Time
-- https://www.postgresql.org/docs/15/functions-datetime.html


-- -----------------------------------------------------------------
-- # Menambah Kolom Timestamp
select *
from products;

select id, extract(year from created_at), extract(month from created_at)
from products;



--
-- [FLOW CONTROL FUNCTION] =========================================
--      

-- PostgreSQL memiliki fitur flow control function
-- Ini mirip IF ELSE di bahasa pemrograman
-- Tapi ingat, fitur ini tidak se kompleks yang dimiliki bahasa pemrograman
-- https://www.postgresql.org/docs/current/functions-conditional.html 


-- -----------------------------------------------------------------
-- # Menggunakan Control Flow CASE
select id, category
from products;

select id,
       category,
       case category
           when 'Makanan' then 'Enak'
           when 'Minuman' then 'Seger'
           else 'Apa itu?'
           end as category_case
from products;

-- -----------------------------------------------------------------
-- # Menggunakan Control Flow Operator
select id,
       price,
       case
           when price <= 15000 then 'Murah'
           when price <= 20000 then 'Mahal'
           else 'Mahal Banget'
           end as "apakah murah?"
from products;

-- -----------------------------------------------------------------
-- # Menggunakan Control Flow Check Null
select id,
       name,
       case
           when description is null then 'kosong'
           else description
           end as description
from products;

--
-- [Aggregate Function] ============================================
--      

-- PostgreSQL mendukung function-function untuk melakukan aggregate
-- Misal, kita ingin melihat harga paling mahal di tabel product, atau harga termurah, 
-- atau rata-rata harga produk, atau total jumlah data di tabel, dan lain-lain
-- https://www.postgresql.org/docs/current/functions-aggregate.html 

-- -----------------------------------------------------------------
-- # Menggunakan Aggregate Function
select count(id) from products; -- menghitung jumlah produk

select avg(price) from products; -- rata-rata harga

select max(price) from products; -- maximal harga

select min(price) from products; -- minimum harga



--
-- [GROUPING] ===================================================
--      

-- -----------------------------------------------------------------
-- # GROUP BY 

-- Kadang saat melakukan aggregate, kita ingin datanya di grouping berdasarkan kriteria tertentu
-- Misal kita ingin melihat rata-rata harga product, tapi ingin per category
-- Atau kita ingin melihat total semua product, tapi per category
-- Hal ini bisa dilakukan di PostgreSQL dengan menggunakan GROUP BY clause
-- GROUP BY clause ini hanya bisa digunakan jika kita menggunakan aggregate function

-- # Menggunakan GROUP BY

select * from products;

select category, 
	   count(id) as "Total Product"
from products
group by category;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga termurah",
       max(price) as "Harga termahal"
from products
group by category;

-- -----------------------------------------------------------------
-- # Having Clause

-- sKadang kita ingin melakukan filter terhadap data yang sudah kita grouping
-- Misal kita ingin menampilkan rata-rata harga per kategori, tapi yang harganya diatas 10.000 misalnya
-- Jika menggunakan WHERE di SELECT, hal ini tidak bisa dilakukan
-- Untuk memfilter hasil aggregate function, kita harus menggunakan HAVING clause

-- # Menggunakan HAVING Clause
select * from products;

select category, count(id) as "Total Product"
from products
group by category
having count(id) > 3;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga termurah",
       max(price) as "Harga termahal"
from products
group by category
having avg(price) >= 20000;



--
-- [CONSTRAINT] ====================================================
--      

-- Di PostgreSQL, kita bisa menambahkan constraint untuk menjaga data di tabel tetap baik
-- Constraint sangat bagus ditambahkan untuk menjaga terjadi validasi yang salah di program kita, 
-- sehingga data yang masuk ke database tetap akan terjaga


-- -----------------------------------------------------------------
-- # Unique Constraint

-- Unique constraint adalah constraint yang memastikan bahwa data kita tetap unique
-- Jika kita mencoba memasukkan data yang duplikat, maka PostgreSQL akan menolak data tersebut

-- # Membuat Table dengan Unique Constraint
create table customer (
    id         serial       not null,
    email      varchar(100) not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id),
    constraint unique_email unique (email)
);

select * from customer;

insert into customer(email, first_name, last_name)
values ('eko@pzn.com', 'Eko', 'Khannedy'),
	   ('budi@pzn.com', 'Budi', 'Nugraha'),
       ('joko@pzn.com', 'Joko', 'Morro'),	
       ('rully@pzn.com', 'Rully', 'Irwansyah');

-- # Menambah/Menghapus Unique Constraint
alter table customer
    add constraint unique_email unique (email);
   
alter table customer
	drop constraint unique_email

-- -----------------------------------------------------------------
-- # Check Constraint

-- Check constraint adalah constraint yang bisa kita tambahkan kondisi pengecekannya
-- Ini cocok untuk mengecek data sebelum dimasukkan ke dalam database
-- Misal kita ingin memastikan bahwa harga harus diatas 1000 misal
-- Maka kita bisa menggunakan check constraint

-- # Membuat Table dengan Check Constraint
create table products (
    id          varchar(10)  not null,
    name        varchar(100) not null,
    description text,
    price       int          not null,
    quantity    int          not null default 0,
    created_at  timestamp    not null default current_timestamp,
    primary key (id),
    constraint price_check check (price >= 1000)
);

-- # Menambah/Menghapus Check Constraint
alter table products
    add constraint price_check check ( price > 1000 );

alter table products
    add constraint quantity_check check ( quantity >= 0 );
   
alter table products 
	drop constraint price_checks;

-- CONTOH GAGAL INSERT
insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10, 0, 'Minuman');

insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10000, -10, 'Minuman');

select *
from products;

--
-- [INDEX] =========================================================
--      

-- Secara default, PostgreSQL akan menyimpan data di dalam disk seperti tabel biasanya
-- Hal ini menyebabkan, ketika kita mencari data, maka PostgreSQL akan melakukan pencarian dari baris 
-- pertama sampai terakhir, yang artinya semakin banyak datanya, maka akan semakin lambat proses pencarian datanya
-- Kita bisa ubah cara PostgreSQL menyimpan data pada kolom, agar mudah dicari, yaitu menggunakan Index
-- Saat kita membuat index, PostgreSQL akan menyimpan data dalam struktur data B-Tree : 
-- https://en.wikipedia.org/wiki/B-tree 
-- Tidak hanya akan mempermudah kita saat melakukan pencarian, index juga akan mempermudah kita ketika 
-- melakukan pengurutan menggunakan ORDER BY

-- -----------------------------------------------------------------
-- # Cara kerja index

-- Kita bisa membuat lebih dari satu index di table, dan setiap kita membuat index, kita bisa membuat 
-- index untuk beberapa kolom sekaligus
-- Misal kita membuat index
-- (col1, col2, col3)
-- Artinya kita punya kemampuan untuk mencari lebih menggunakan index untuk kombinasi query di 
-- (col1), (col1, col2) dan (col1, col2, col3)

-- -----------------------------------------------------------------
-- # Efek Samping Membuat Index

-- Index mungkin akan mempercepat untuk proses pencarian dan query data
-- Namun, saat kita membuat index, artinya PostgreSQL akan melakukan proses update data di 
-- index tiap kali kita menambah, mengubah atau menghapus data di table
-- Artinya Index membuat proses pencarian dan query lebih cepat, tapi memperlambat proses 
-- manipulasi data (insert, update dan delete)
-- Oleh karena itu, kita harus bijak saat membuat index
-- NOTE: TERGANTUNG KEBUTUHAN

-- -----------------------------------------------------------------
-- # Tidak perlu index

-- Saat kita membuat PRIMARY KEY dan UNIQUE constraint, kita tidak perlu menambahkan lagi index
-- Hal ini dikarenakan PostgreSQL secara otomatis akan menambahkan index pada kolom PRIMARY KEY dan UNIQUE constraint


-- -----------------------------------------------------------------
-- # Membuat Table Sellers
create table sellers (
    id    serial       not null,
    name  varchar(100) not null,
    email varchar(100) not null,
    primary key (id),
    constraint email_unique unique (email)
);

insert into sellers(name, email)
values ('Galeri Olahraga', 'galeri@pzn.com'),
       ('Toko Tono', 'tono@pzn.com'),
       ('Toko Budi', 'budi@pzn.com'),
       ('Toko Rully', 'rully@pzn.com');

SELECT *
From sellers;

-- mencari menggunakan index
select * from sellers where id = 1; 
select * from sellers where email = 'rully@pzn.com';

-- combinasi ini tidak menggunakan index
select * from sellers where id = 1 or name = 'Toko Tono';
select * from sellers where email = 'rully@pzn.com' or name= 'Toko Tono';
select * from sellers where name= 'Toko Tono';

-- -----------------------------------------------------------------
-- # Menambah/Menghapus Index
create index sellers_id_and_name_index ON sellers (id, name);
create index sellers_email_and_name_index ON sellers (email, name);
create index sellers_name_index ON sellers (name);

-- combinasi ini akan menggunakan index jika sudah create index
select * from sellers where id = 1 or name = 'Toko Tono';
select * from sellers where email = 'rully@pzn.com' or name= 'Toko Tono';
select * from sellers where name= 'Toko Tono';



--
-- [FULL-TEXT SEARCH] ==============================================
--      

-- -----------------------------------------------------------------
-- # Masalah dengan like operator

-- Kadang kita ingin mencari sebuah kata dalam tabel, dan biasanya kita akan menggunakan LIKE operator
-- Operasi yang dilakukan LIKE operator adalah dengan cara mencari seluruh data di tabel dari baris pertama 
-- sampai terakhir, hal ini membuat operasi LIKE sangat lambat
-- Menambah index di tabel juga tidak akan membantu, karen LIKE operator tidak menggunakan index
-- PostgreSQL menyediakan fitur Full Text Search jika ada kasus kita ingin melakukan hal ini


-- -----------------------------------------------------------------
-- # Full-Text Search

-- Full-Text Search memungkinkan kita bisa mencari sebagian kata di kolom dengan tipe data String
-- Ini sangat cocok ketika pada kasus kita memang membutuhkan pencarian yang tidak hanya sekedar 
-- operasi = (equals, sama dengan)
-- https://www.postgresql.org/docs/current/textsearch-intro.html 
-- Di PostgreSQL, Full-Text Search menggunakan function to_tsvector(text) dan to_tsquery(query)
-- Bahkan kita bisa menggunakan function tersebut tanpa membuat index, namun performanya akan sama 
-- aja dengan LIKE, lambat karena harus di cek satu-satu
-- Operator Full-Text Search menggunakan @@, bukan = 

-- -----------------------------------------------------------------
-- # Mencari Tanpa Index
select * from products where name ilike '%mie%'; -- contoh like

select *
from products
where to_tsvector(name) @@ to_tsquery('mie'); -- contoh tanpa index

-- -----------------------------------------------------------------
-- # Membuat Index Full-Text Search

-- Get avaible language
select cfgname from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));
create index products_description_search on products using gin (to_tsvector('indonesian', description));

-- untuk menghapus bisa gunakan...
drop index products_name_search;
drop index products_description_search;

-- -----------------------------------------------------------------
-- # Mencari Menggunakan Full-Text Search Index
select *
from products
where name @@ to_tsquery('bakso');

select *
from products
where description @@ to_tsquery('mie');

-- -----------------------------------------------------------------
-- # Query Operator

-- to_tsquery() mendukung banyak operator
-- & untuk AND
-- | untuk OR
-- ! untuk NOT
-- ''' ''' untuk semua data

select *
from products
where name @@ to_tsquery('ayam & original');

select *
from products
where name @@ to_tsquery('''ayam ceker''');

-- -----------------------------------------------------------------
-- # Tipe Data TSVECTOR

-- Kita juga bisa secara otomatis membuat kolom dengan tipe data TSVECTOR
-- Secara otomatis kolom tersebut berisi text yang memiliki index Full-Text Search



--
-- [TABLE RELATIONSHIP] ============================================
--      

-- Dalam Relational DBMS, salah satu fitur andalan nya adalah table relationship. Yaitu relasi antar tabel
-- Kita bisa melakukan relasi dari satu tabel ke tabel lain.
-- Dalam kehidupan nyata pun pasti kita akan sering membuat relasi antar tabel
-- Misal, saat kita membuat aplikasi penjualan, di laporan penjualan pasti ada data barang. Jika di tabel artinya 
-- tabel penjualan akan berelasi dengan tabel barang
-- Misal dalam aplikasi kampus, tabel mahasiswa akan berelasi dengan tabel mata kuliah, dan tabel dosen
-- Dan lain-lain


-- -----------------------------------------------------------------
-- # Foreign Key

-- Saat membuat relasi tabel, biasanya kita akan membuat sebuah kolom sebagai referensi ke tabel lainnya
-- Misal saat kita membuat tabel penjualan, di dalam tabel penjualan, kita akan menambahkan kolom id_produk sebagai 
-- referensi ke tabel produk, yang berisi primary key di tabel produk
-- Kolom referensi ini di PostgreSQL dinamakan Foreign Key
-- Kita bisa menambah satu satu lebih foreign key ke dalam sebuah tabel
-- Membuat foreign key sama seperti membuat kolom biasanya, hanya saja kita perlu memberi tahu PostgreSQL bahwa itu 
-- adalah foreign key ke tabel lain

-- -----------------------------------------------------------------
-- # Keuntungan Menggunakan Foreign Key

-- Foreign key memastikan bahwa data yang kita masukkan ke kolom tersebut harus tersedia di tabel reference nya
-- Selain itu saat kita menghapus data di tabel reference, PostgreSQL akan mengecek apakah id nya digunakan di 
-- foreign key di tabel lain, jika digunakan, maka secara otomatis PostgreSQL akan menolak proses delete data di 
-- tabel reference tersebut

-- -----------------------------------------------------------------
-- # Ketika Menghapus Data Berelasi

-- Seperti yang sebelumnya dibahas, ketika kita menghapus data yang berelasi, maka secara otomatis PostgreSQL 
-- akan menolak operasi delete tersebut
-- Kita bisa mengubah fitur ini jika kita mau, ada banyak hal yang bisa dilakukan ketika data berelasi dihapus, 
-- defaultnya memang akan ditolak (RESTRICT)


-- -----------------------------------------------------------------
-- # Membuat Table dengan Foreign Key

create table wishlist (
    id          serial      not null,
    id_product  varchar(10) not null,
    description text,
    primary key (id),
    constraint fk_wishlist_product foreign key (id_product) references products (id)
);

insert into wishlist(id_product, description)
values ('P0001', 'Mie ayam kesukaan'),
       ('P0002', 'Mie ayam kesukaan'),
       ('P0005', 'Mie ayam kesukaan');

SELECT *
FROM wishlist;

delete
from products
where id = 'P0005'; -- tidak bisa dihapus karena sedang dipakai


-- -----------------------------------------------------------------
-- # Menambah/Menghapus Foreign Key
alter table wishlist
    drop constraint fk_wishlist_product;

alter table wishlist
    add constraint fk_wishlist_product foreign key (id_product) references products (id);

-- -----------------------------------------------------------------
-- # Behavior Foreign Key
   
-- NOTE: Rekomendasi tetap restrict, agar data tetap konsisten

-- Behavior       ON DELETE                   ON UPDATE
-- RESTRICT		  Ditolak                     Ditolak
-- CASCADE        Data akan dihapus           Data akan ikut diubah
-- NO ACTION      Data dibiarkan              Data dibiarkan
-- SET null       Diubah jadi null            Diubah jadi NULL
-- SET DEFAULT    Diubah jadi Default Value   Diubah jadi Default Value

alter table wishlist
    add constraint fk_wishlist_product foreign key (id_product) references products (id)
        on delete cascade on update cascade;
   
-- contoh menghapus ketika sedang berelasi
insert into products(id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

SELECT * FROM products;

insert into wishlist(id_product, description)
values ('XXX', 'Contoh');

select * from wishlist;

delete
from products
where id = 'XXX';



--
-- [JOIN] ==========================================================
--      

-- PostgreSQL mendukung query SELECT langsung ke beberapa tabel secara sekaligus
-- Namun untuk melakukan itu, kita perlu melakukan JOIN di SQL SELECT yang kita buat
-- Untuk melakukan JOIN, kita perlu menentukan tabel mana yang merupakan referensi ke tabel lain
-- Join cocok sekali dengan foreign key, walaupun di PostgreSQL tidak ada aturan kalau JOIN harus ada foreign key
-- Join di PostgreSQL bisa dilakukan untuk lebih dari beberapa tabel
-- Tapi ingat, semakin banyak JOIN, maka proses query akan semakin berat dan lambat, jadi harap bijak ketika 
-- melakukan JOIN
-- Idealnya kita melakukan JOIN jangan lebih dari 5 tabel, karena itu bisa berdampak ke performa query yang lambat

	
-- -----------------------------------------------------------------
-- # Melakukan JOIN Table
select *
from wishlist
         join products on wishlist.id_product = products.id;

select p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id;

-- -----------------------------------------------------------------
-- # Membuat Relasi ke Table Customers
alter table wishlist
    add column id_customer int;

alter table wishlist
    add constraint fk_wishlist_customer foreign key (id_customer) references customer (id);

-- menambahkan data
update wishlist
set id_customer = 1
where id in (2, 3);

update wishlist
set id_customer = 4
where id = 1;

select *
From customer;

select *
from wishlist;

-- -----------------------------------------------------------------
-- # Melakukan JOIN Multiple Table
select c.email, p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id
         join customer as c on c.id = w.id_customer;



--
-- [ONE TO ONE RELATIONSHIP] =======================================
--      

-- One to One relationship adalah relasi antar tabel yang paling sederhana
-- Artinya tiap data di sebuah tabel hanya boleh berelasi ke maksimal 1 data di tabel lainnya
-- Tidak boleh ada relasi lebih dari 1 data
-- Contoh misal, kita membuat aplikasi toko online yang terdapat fitur wallet, dan 1 customer, 
-- cuma boleh punya 1 wallet


-- -----------------------------------------------------------------
-- # Jenis-Jenis Relasi Tabel

-- Sekarang kita sudah tau untuk melakukan relasi antar tabel, kita bisa menggunakan FOREIGN KEY
-- Dan untuk melakukan SELECT beberapa tabel, kita bisa menggunakan JOIN
-- Dalam konsep relasi, ada banyak jenis-jenis relasi antar tabel
-- Sekarang kita akan bahas dari yang pertama yaitu One to One relationship



-- -----------------------------------------------------------------
-- # Membuat One to One Relationship

-- Cara membuat One to One relationship cukup mudah
-- Kita bisa membuat kolom foreign key, lalu set kolom tersebut menggunakan UNIQUE KEY, hal 
-- ini dapat mencegah terjadi data di kolom tersebut agar tidak duplikat
-- Atau cara lainnya, kita bisa membuat tabel dengan primary key yang sama, sehingga tidak butuh 
-- lagi kolom untuk FOREIGN KEY



-- -----------------------------------------------------------------
-- # Membuat Table Wallet
create table wallet (
    id          serial not null,
    id_customer int    not null,
    balance     int    not null default 0,
    primary key (id),
    constraint wallet_customer_unique unique (id_customer),
    constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);

select * from customer;

insert into wallet(id_customer, balance)
values (1, 1000000),
       (2, 2000000),
       (3, 3000000),
       (4, 4000000);

select *
from wallet;

select *
from customer
         join wallet on wallet.id_customer = customer.id;



--
-- [ONE TO MANY RELATIONSHIP] ======================================
--      

-- One to many relationship adalah relasi antar tabel dimana satu data bisa digunakan lebih dari satu kali di tabel 
-- relasinya
-- Berbeda dengan one to one yang cuma bisa digunakan maksimal 1 kali di tabel relasinya, one to many tidak ada 
-- batasan berapa banyak data digunakan
-- Contoh relasi antar tabel categories dan products, dimana satu category bisa digunakan oleh lebih dari satu 
-- product, yang artinya relasinya nya one category to many products
-- Pembuatan relasi one to many sebenarnya sama dengan one to one, yang membedakan adalah, kita tidak perlu 
-- menggunakan UNIQUE KEY, karena datanya memang bisa berkali-kali ditambahkan di tabel relasi nya


-- -----------------------------------------------------------------
-- # Membuat Table Category
create table categories (
    id   varchar(10)  not null,
    name varchar(100) not null,
    primary key (id)
);

-- Menambahkan data
insert into categories(id, name)
values ('C0001', 'Makanan'),
       ('C0002', 'Minuman');

select * from categories;

-- -----------------------------------------------------------------
-- # Mengubah table products (dari category enum menjadi table categories)
alter table products
	add column id_category varchar(10);

alter table products
    add constraint fk_product_category foreign key (id_category) references categories (id);

-- Menambahkan data
select * from products;

update products
set id_category = 'C0001'
where category = 'Makanan';

update products
set id_category = 'C0002'
where category = 'Minuman';

-- lalu hapus category
alter table products
    drop column category;

-- Join table products dan categories
select *
from products
         join categories on products.id_category = categories.id;



--
-- [MANY TO MANY RELATIONSHIP] =====================================
--      

-- Many to Many adalah table relationship yang paling kompleks, dan kadang membingungkan untuk pemula
-- Many to Many adalah relasi dimana ada relasi antara 2 tabel dimana table pertama bisa punya banyak relasi 
-- di table kedua, dan table kedua pun punya banyak relasi di table pertama
-- Ini memang sedikit membingungkan, bagaimana caranya bisa relasi kebanyakan secara bolak balik, sedangkan 
-- di table kita cuma punya 1 kolom?
-- Contoh relasi many to many adalah relasi antara produk dan penjualan, dimana setiap produk bisa dijual 
-- berkali kali, dan setiap penjualan bisa untuk lebih dari satu produk

-- -----------------------------------------------------------------
-- # Bagaimana Implementasi Many to Many?
        
-- Sekarang pertanyaannya, bagaimana implementasi many to many?
-- Apakah kita harus menambahkan id_order di table products? atau id_product di table orders?

-- -----------------------------------------------------------------
-- # Id Product di Table Order

-- Jika kita menambahkan id_product di table orders, artinya sekarang sudah benar, bahwa 1 product bisa dijual 
-- berkali-kali
-- Namun masalahnya adalah, berarti 1 order hanya bisa membeli 1 product, karena cuma ada 1 kolom untuk id_product
-- Oke kalo gitu kita tambahkan id_product1, id_product2, dan seterusnya. Solusi ini bisa dilakukan, tapi 
-- tidak baik, artinya akan selalu ada maksimal barang yang bisa kita beli dalam satu order

-- -----------------------------------------------------------------
-- # Id Order di Table Product

-- Jika kita tambahkan id_order di table products, artinya sekarang 1 order bisa membeli lebih dari 1 product, 
-- oke sudah benar
-- Tapi sayangnya masalahnya terbalik sekarang, 1 product cuma bisa dijual satu kali, tidak bisa dijual 
-- berkali-kali, karena kolom id_order nya cuma 1
-- Kalupun kita tambah id_order1, id_order2 dan seterusnya di table product, tetap ada batasan maksimal nya
-- Lantai bagaimana solusinya untuk relasi many to many?

-- -----------------------------------------------------------------
-- # Membuat Table Relasi

-- Solusi yang biasa dilakukan jika terjadi relasi many to many adalah, biasanya kita akan menambah 1 tabel ditengahnya
-- Tabel ini bertugas sebagai jembatan untuk menggabungkan relasi many to many
-- Isi table ini akan ada id dari table pertama dan table kedua, dalam kasus ini adalah id_product dan id_order
-- Dengan demikian, kita bisa menambahkan beberapa data ke dalam tabel relasi ini, sehingga berarti satu 
-- product bisa dijual beberapa kali di dalam table order, dan satu order bisa membeli lebih dari satu product

-- -----------------------------------------------------------------
-- # Membuat Table Order
create table orders (
    id         serial    not null,
    total      int       not null,
    order_date timestamp not null default current_timestamp,
    primary key (id)
);

-- Menambah data (dummy)
insert into orders(total)
values (1),
       (1),
       (1);

select * from orders;

-- -----------------------------------------------------------------
-- # Membuat Table Order Detail
create table orders_detail (
    id_product varchar(10) not null,
    id_order   int         not null,
    price      int         not null,
    quantity   int         not null,
    primary key (id_product, id_order)
);

-- Membuat Foreign Key Order Detail
alter table orders_detail
    add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail
    add constraint fk_orders_detail_order foreign key (id_order) references orders (id);

-- # Menambah/merelasikan data (dummy)
select * from products order by id;

-- order 1
insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 1, 1000, 2),
       ('P0002', 1, 1000, 2),
       ('P0003', 1, 1000, 2);

-- order 2
insert into orders_detail (id_product, id_order, price, quantity)
values ('P0004', 2, 1000, 2),
       ('P0006', 2, 1000, 2),
       ('P0007', 2, 1000, 2);

-- order 3
insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 3, 1000, 2),
       ('P0004', 3, 1000, 2),
       ('P0005', 3, 1000, 2);

select * from orders_detail;

-- -----------------------------------------------------------------
-- # Melihat Data Order, Detail dan Product-nya
select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id;

select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id
where orders.id = 3;



--
-- [JENIS-JENIS JOIN] ==============================================
--      

-- Sebelumnya kita sudah bahas tentang JOIN table, tapi sebenarnya ada banyak sekali jenis-jenis 
-- JOIN table di PostgreSQL, diantaranya :
--  + INNER JOIN
--  + LEFT JOIN
--  + RIGHT JOIN
--  + FULL JOIN

-- -----------------------------------------------------------------
-- # Sebelum itu kita akan menambahkan beberapa data
insert into categories (id, name)
VALUES ('C0003', 'Gadget'),
       ('C0004', 'Laptop'),
       ('C0005', 'Pulsa');

select * from categories;

insert into products(id, name, price, quantity)
values ('X0001', 'Contoh 1', 10000, 100),
       ('X0002', 'Contoh 2', 10000, 100);

select * from products;

-- -----------------------------------------------------------------
-- # INNER JOIN

-- INNER JOIN adalah mekanisme JOIN, dimana terdapat relasi antara tabel pertama dan tabel kedua
-- Jika ada data di tabel pertama yang tidak memiliki relasi di table kedua ataupun sebaliknya, maka hasil 
-- INNER JOIN tidak akan ditampilkan
-- Ini adalah default JOIN di PostgreSQL
-- Jika kita menggunakan JOIN seperti yang sudah kita praktekan sebelumnya, sebenarnya itu akan melakukan INNER JOIN

select *
from categories
         inner join products on products.id_category = categories.id;

-- -----------------------------------------------------------------
-- # LEFT JOIN

-- LEFT JOIN adalah mekanisme JOIN seperti INNER JOIN, namun semua data di table pertama akan diambil juga
-- Jika ada yang tidak memiliki relasi di table kedua, maka hasilnya akan NULL

select *
from categories
         left join products on products.id_category = categories.id;

-- -----------------------------------------------------------------
-- # RIGHT JOIN

-- RIGHT JOIN adalah mekanisme JOIN seperti INNER JOIN, namun semua data di table kedua akan diambil juga
-- Jika ada yang tidak memiliki relasi di table pertama, maka hasilnya akan NULL

select *
from categories
         right join products on products.id_category = categories.id;

-- -----------------------------------------------------------------
-- # FULL JOIN

-- Full Join adalah join dimana semua data di tabel pertama dan kedua akan ditampilkan
-- Jika tidak ada data join, maka hasilnya akan berisi data Null

select *
from categories
         full join products on products.id_category = categories.id;



--
-- [SUBQUERIES] ====================================================
--      

-- -----------------------------------------------------------------
-- # Subquery di WHERE

-- PostgreSQL mendukung pencarian data menggunakan WHERE dari hasil SELECT query
-- Fitur ini dinamakan Subquery
-- Contoh, kita ingin mencari products yang harganya diatas harga rata-rata, artinya kita 
-- akan melakukan SELECT dengan WHERE price > harga rata, dimana harga rata-rata perlu kita 
-- hitung menggunakan query SELECT lainnya menggunakan aggregate function AVG

select avg(price) from products;

select *
from products
where price > (select avg(price) from products);

-- -----------------------------------------------------------------
-- # Subquery di FROM

-- Selain di WHERE clause, Subquery juga bisa dilakukan di FROM clause
-- Misal kita ingin mencari data dari hasil query SELECT, itu bisa kita lakukan di PostgreSQL

select * from products;

-- Mengambil data harga maksimal
select max(price)
from (select products.price as price
      from categories
               join products on products.id_category = categories.id) as contoh;

-- Mengambil data seluruh harganya
select products.price
      from categories
               join products on products.id_category = categories.id;



--
-- [SET OPERATOR] ==================================================
--      

-- PostgreSQL mendukung operator Set, dimana ini adalah operasi antara hasil dari dua SELECT query. Ada banyak 
-- jenis operator Set, yaitu :
-- UNION
-- UNION ALL
-- INTERSECT
-- EXCEPT

-- # Sebagai contoh saya membuat table guest book
create table guestbooks (
    id      serial       not null,
    email   varchar(100) not null,
    title   varchar(100) not null,
    content text,
    primary key (id)
);

select * from customer;

insert into guestbooks(email, title, content)
values ('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
       ('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
       ('budi@pzn.com', 'feedback budi', 'ini feedback budi'),
       ('rully@pzn.com', 'feedback rully', 'ini feedback rully'),
       ('tono@pzn.com', 'feedback tono', 'ini feedback tono'),
       ('tono@pzn.com', 'feedback tono', 'ini feedback tono');

select * from guestbooks;

-- -----------------------------------------------------------------
-- # UNION

-- UNION adalah operasi menggabungkan dua buah SELECT query, dimana jika terdapat data yang duplikat, 
-- data duplikatnya akan dihapus dari hasil query

select distinct email from customer
union
select distinct email from guestbooks;

-- -----------------------------------------------------------------
-- # UNION ALL

-- UNION ALL adalah operasi yang sama dengan UNION, namun data duplikat tetap akan ditampilkan di hasil query nya

select email from customer
union all
select email from guestbooks;

-- Contoh menggunakan grouping
select email, count(email)
from (select email
      from customer
      union all
      select email
      from guestbooks) as contoh
group by email;

-- -----------------------------------------------------------------
-- # INTERSECT

-- INTERSECT adalah operasi menggabungkan dua query, namun yang diambil hanya data yang terdapat pada hasil 
-- query pertama dan query kedua 
-- Data yang tidak hanya ada di salah satu query, kan dihapus di hasil operasi INTERSECT 
-- Data nya muncul tidak dalam keadaan duplikat

select email from customer
intersect
select email from guestbooks;

-- -----------------------------------------------------------------
-- # EXCEPT

-- EXCEPT adalah operasi dimana query pertama akan dihilangkan oleh query kedua
-- Artinya jika ada data di query pertama yang sama dengan data yang ada di query kedua, 
-- maka data tersebut akan dihapus dari hasil query EXCEPT

select email from customer
except
select email from guestbooks;


--
-- [TRANSACTION] ===================================================
--      

-- -----------------------------------------------------------------
-- # Kenapa Butuh Transaction?
--
-- Saat membuat aplikasi berbasis database, jarang sekali kita akan melakukan satu jenis perintah SQL per aksi 
-- yang dibuat aplikasi.
-- Contoh, ketika membuat toko online, ketika customer menekan tombol Pesan, banyak yang harus kita lakukan, misal:
--   + Membuat data pesanan di tabel order,
--   + Membuat data detail pesanan di tabel order detail,
--   + Menurunkan quantity di tabel produk,
--   + Dan yang lainnya.
-- Artinya, bisa saja dalam satu aksi, kita akan melakukan beberapa perintah sekaligus.
-- Jika terjadi kesalahan di salah satu perintah, harapannya adalah perintah-perintah sebelumnya dibatalkan, 
-- agar data tetap konsisten.

-- -----------------------------------------------------------------
-- # Database Transaction
--
-- Database transaction adalah fitur di DBMS dimana kita bisa memungkinan beberapa perintah dianggap menjadi 
-- sebuah kesatuan perintah yang kita sebut transaction.
-- Jika terdapat satu saja proses gagal di transaction, maka secara otomatis perintah-perintah sebelumnya 
-- akan dibatalkan.
-- Jika sebuah transaction sukses, maka semua perintah akan dipastikan sukses.


-- -----------------------------------------------------------------
-- # CONTOH ALUR TRANSACTION

-- # Membuat Transaction
-- START TRANSACTION --> INSERT... --> INSERT... --> UPDATE... --> 	COMMIT TRANSACTION

-- # Membatalkan Transaction
-- START TRANSACTION --> INSERT... --> INSERT... --> UPDATE... --> 	ROLLBACK TRANSACTION

-- -----------------------------------------------------------------
-- # Transaction di PostgreSQL
--
-- Perintah            Keterangan
--
-- START TRANSACTION   Memulai proses transaksi, proses selanjutnya akan dianggap transaksi 
--                     sampai perintah COMMIT atau ROLLBACK.
-- COMMIT              Menyimpan secara permanen seluruh proses transaksi.
-- ROLLBACK            Membatalkan secara permanen seluruh proses transaksi.

-- -----------------------------------------------------------------
-- # Yang Tidak Bisa Menggunakan Transaction
--
-- + Perintah DDL (Data Definition Language) tidak bisa menggunakan fitur transaction.
-- + DDL adalah perintah-perintah yang digunakan untuk merubah struktur, seperti membuat tabel, 
--   menambah kolom, menghapus tabel, menghapus database, dan sejenisnya.
-- + Transaction hanya bisa dilakukan pada perintah DML (Data Manipulation Language), seperti operasi 
--   INSERT, UPDATE dan DELETE.

-- -----------------------------------------------------------------
-- # DEMO TRANSACTION COMMIT

-- 1) Dimulai dari START TRANSACTION
start transaction;

-- 2) INPUT DATA
insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 2');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 3');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 4');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'transaction 5');

-- jika kita cek data yang sudah diinput hanya bisa telihat oleh user ini saja
-- karena data belum dicommit.
select * from guestbooks;

-- 3) Jika sudah commit maka data transaction akan bisa dilihat siapapun
commit;

-- -----------------------------------------------------------------
-- # DEMO TRANSACTION ROLLBACK

-- 1) Dimulai dari START TRANSACTION
start transaction;

-- 2) INPUT DATA
insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 2');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 3');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 4');

insert into guestbooks(email, title, content)
values ('transaction@pzn.com', 'transaction', 'rollback 5');

-- jika kita cek data yang sudah diinput hanya bisa telihat oleh user ini saja.
select * from guestbooks;

-- 3) Jika sudah rollback maka data transaction akan dihapus
rollback;



--
-- [LOCKING] ===================================================
--      
--
-- + Locking adalah proses mengunci data di DBMS.
-- + Proses mengunci data sangat penting dilakukan, salah satunya agar data benar-benar terjamin konsistensinya.
-- + Karena pada kenyataannya, aplikasi yang akan kita buat pasti digunakan oleh banyak pengguna, dan banyak 
--   pengguna tersebut bisa saja akan mengakses data yang sama, jika tidak ada proses locking, bisa dipastikan 
--   akan terjadi RACE CONDITION, yaitu proses balapan ketika mengubah data yang sama.
-- + Contoh saja, ketika kita belanja di toko online, kita akan balapan membeli barang yang sama, jika data 
--   tidak terjaga, bisa jadi kita salah mengupdate stock karena pada saat yang bersamaan banyak yang melakukan 
--   perubahan stock barang.


-- -----------------------------------------------------------------
-- # LOCKING RECORD
--
-- + Saat kita melakukan proses TRANSACTION, lalu kita melakukan prose perubahan data, data yang kita ubah 
--   tersebut akan secara otomatis di LOCK.
-- + Hal ini membuat proses TRANSACTION sangat aman.
-- + Oleh karena itu, sangat disarankan untuk selalu menggunakan fitur TRANSACTION ketika memanipulasi data 
--   di database, terutama ketika perintah manipulasinya lebih dari satu kali.
-- + Locking ini akan membuat sebuah proses perubahan yang dilakukan oleh pihak lain akan diminta untuk menunggu.
-- + Data akan di lock sampai kita melakukan COMMIT atau ROLLBACK transaksi tersebut.

-- CONTOH:
select * from products;

-- 1) Melakukan start transaction
start transaction;

-- 2) Mengubah data deskripsi produk
update products
set description = 'Mie ayam original enak'
where id = 'P0001';

-- melakukan pengecekan di user ini
select * from products where id = 'P0001';

-- Jika update ini dijalankan oleh user/platform lain (misal: psql, demo ini menggunakan dbeaver) maka akan 
-- hang/berhenti, karena record diatas sudah dilock.
-- Jika ada proses lain ingin melakukan perubahan maka harus menunggu sampai lock dilepas.
update products
set quantity = 300
where id = 'P0001';

-- 3) Jika commit dilakukan maka lock akan dilepas dan perintah update di platform lain akan berjalan.
commit;

-- -----------------------------------------------------------------
-- # Locking Record Manual
-- 
-- + Selain secara otomatis, kadang saat kita membuat aplikasi, kita juga sering melakukan SELECT 
--   query terlebih dahulu sebelum melakukan proses UPDATE misalnya.
-- + Jika kita ingin melakukan locking sebuah data secara manual, kita bisa tambahkan perintah FOR 
--   UPDATE di belakang query SELECT.
-- + Saat kita lock record yang kita select, maka jika ada proses lain akan melakukan UPDATE, DELETE 
--   atau SELECT FOR UPDATE lagi, maka proses lain diminta menunggu sampai kita selesai melakukan COMMIT 
--   atau ROLLBACK transaction.

-- 1) menjalankan start transaction
start transaction;

-- 2) tanpa for update, platform lain bisa mengganti/insert pada product dengan id tersebut
select *
from products
where id = 'P0001' for update;

-- 3) disini kalian bisa update, dan lain lain
-- .....

-- 4) Jika sudah maka kalian bisa rollback ataupun commit
rollback;

-- Melakukan pengecekan.
select * from products where id = 'P0001';

-- -----------------------------------------------------------------
-- # DEADLOCK
--
-- + Saat kita terlalu banyak melakukan proses Locking, hati-hati akan masalah yang bisa terjadi, 
--   yaitu DEADLOCK
-- + Deadlock adalah situasi ada 2 proses yang saling menunggu satu sama lain, namun data yang ditunggu 
--   dua-duanya di lock oleh proses lainnya, sehingga proses menunggunya ini tidak akan pernah selesai.
--
-- # Contoh Deadlock
--
-- + Proses 1 melakukan SELECT FOR UPDATE untuk data 001
-- + Proses 2 melakukan SELECT FOR UPDATE untuk data 002
-- + Proses 1 melakukan SELECT FOR UPDATE untuk data 002, diminta menunggu karena di lock oleh Proses 2
-- + Proses 2 melakukan SELECT FOR UPDATE untuk data 001, diminta menunggu karena di lock oleh Proses 1
-- + Akhirnya Proses 1 dan Proses 2 saling menunggu dan Deadlock terjadi

-- 1) Melakukan start transaction
start transaction;

-- 2) select dari dbeaver, lalu jalankan di psql
select *
from products
where id = 'P0001' for update;

-- 2) select dari psql, lalu jalankan di dbeaver
select *
from products
where id = 'P0002' for update;

rollback;



--
-- [SCHEMA] ========================================================
--      
--
-- + Diawal, kita mengibaratkan bahwa database adalah sebuah folder, dan table adalah file-file nya
-- + Di PostgreSQL, terdapat fitur bernama Schema, anggap saja ini adalah folder didalam database
-- + Saat kita membuat database, secara tidak sadar sebenarnya kita menyimpan semua table kita di schema public
-- + Kita bisa membuat schema lain, dan pada schema yang berbeda, kita bisa membuat table dengan nama yang sama
-- + Saat kita membuat database di PostgreSQL, secara otomatis terdapat schema bernama public
-- + Dan saat kita membuat table, secara otomatis kita akan membuat table tersebut di schema public

-- -----------------------------------------------------------------
-- # Melihat Schema Saat Ini
select current_schema();
show search_path;

-- -----------------------------------------------------------------
-- # Membuat dan menghapus Schema
create schema contoh;

drop schema contoh;

-- -----------------------------------------------------------------
-- # Pindah Schema
SET search_path TO contoh;

select current_schema();

-- -----------------------------------------------------------------
-- # Membuat Table di Schema
-- 
-- + Saat kita membuat table, secara otomatis PostgreSQL akan membuatkan table di schema yang sedang kita pilih.
-- + Jika kita ingin menentukan schema secara manual tanpa menggunakan schema yang sedang dipilih, kita bisa 
--   menambahkan prefix nama schema di awal nama table nya.
-- + Misal namaschema.namatable.
-- + Termasuk jika ingin melakukan operasi DML ke table, bisa menggunakan prefix namaschema

select * from public.products;

create table contoh.products (
    id   serial       not null,
    name varchar(100) not null,
    primary key (id)
);

SET search_path TO public;

insert into contoh.products(name)
values ('iphone'),
       ('Play Station');

select * from contoh.products;



--
-- [USER MANAGEMENT] ===============================================
--      
-- 
-- # ROOT USER
--
-- + Secara default, PostgreSQL membuat user utama sebagai super administrator.
-- + Namun best practice nya, saat kita menjalankan PostgreSQL dengan aplikasi yang kita buat, sangat 
--   disarankan tidak menggunakan user utama.
-- + Lebih baik kita buat user khusus untuk tiap aplikasi, bahkan kita bisa batasi hak akses user tersebut, 
--   seperti hanya bisa melakukan SELECT, dan tidak boleh melakukan INSERT, UPDATE atau DELETE.
--
--
-- # Hak Akses dan User
--
-- + Dalam user management PostgreSQL, kita akan mengenal istilah Hak Akses dari User

-- -----------------------------------------------------------------
-- # Membuat/Menghapus User
create role kisah;
create role anto;

drop role kisah;
drop role anto;

-- -----------------------------------------------------------------
-- # Role Option
--
-- + Saat membuat user / role, terdapat banyak opsi yang bisa kita gunakan
-- + Kita bisa lihat semuanya disini : 
--     https://www.postgresql.org/docs/current/sql-createrole.html 
--     https://www.postgresql.org/docs/current/sql-alterrole.html 

alter role kisah login password 'rahasia';

alter role anto login password 'rahasia';

-- -----------------------------------------------------------------
-- # Daftar Hak Akses
--
-- + Ada banyak sekali hak akses di PostgreSQL
-- + Kita bisa melihatnya di daftar tabel yang terdapat di halaman berikut:
-- + https://www.postgresql.org/docs/current/sql-grant.html 
-- + Setelah membuat user / role, kita bisa menambahkan hak akses ke user tersebut
-- + Dan kita juga bisa menghapus hak akses yang sudah kita berikan ke user
-- + https://www.postgresql.org/docs/current/sql-revoke.html 

-- # Menambah.Menghapus Hak Akses ke User
grant insert, update, select on all tables in schema public to kisah;
-- walaupun punya akses ke table, kalau tidak punya akses ke sequence akan ditolak
grant usage, select, update on guestbooks_id_seq to kisah;
grant insert, update, select on customer to anto;

revoke insert, update, select on customer from anto;


--
-- [BACKUP DATABASE] ===============================================
--      
--
-- + Saat membuat aplikasi menggunakan database, ada baiknya kita selalu melakukan backup data secara reguler
-- + Untungnya PostgreSQL mendukung proses backup database
-- + Untuk melakukan backup database, kita tidak menggunakan perintah SQL, melainkan PostgreSQL menyediakan sebuah aplikasi khusus untuk melakukan backup database, namanya adalah pg_dump
-- + https://www.postgresql.org/docs/current/app-pgdump.html 


-- -----------------------------------------------------------------
-- # Melakukan Backup Database
-- pg_dump --host=localhost --port=5432 --dbname=belajar --username=khannedy --format=plain --file=/home/kisah/backup.sql



--
-- [RESTORE DATABASE] ==============================================
--      
--
-- + Selain melakukan backup database, di PostgreSQL juga kita bisa melakukan proses restore data dari file hasil backup
-- + Untuk melakukan restore database, kita bisa menggunakan aplikasi psql dari PostgreSQL.
 
-- -----------------------------------------------------------------
-- # Membuat Database untuk Restore
create database dbrestore;

-- -----------------------------------------------------------------
-- # Restore Database
-- psql --host=localhost --port=5432 --dbname=dbrestore --username=postgres --file=/home/kisah/backup.sql

