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



--
-- [] ===================================================
--      

-- 

-- -----------------------------------------------------------------
-- # 



--
-- [] ===================================================
--      

-- 

-- -----------------------------------------------------------------
-- # 




-- =================================================================



select currval('admin_id_seq');

create sequence contoh_sequence;

select nextval('contoh_sequence');

select currval('contoh_sequence');

select id, name, description
from products;

select id, lower(name), length(name), lower(description)
from products;

select *
from products;

select id, extract(year from created_at), extract(month from created_at)
from products;

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

select id,
       price,
       case
           when price <= 15000 then 'Murah'
           when price <= 20000 then 'Mahal'
           else 'Mahal Banget'
           end as "apakah murah?"
from products;

select id,
       name,
       case
           when description is null then 'kosong'
           else description
           end as description
from products;

select count(id)
from products;

select avg(price)
from products;

select max(price)
from products;

select min(price)
from products;

select category, count(id) as "Total Product"
from products
group by category;

select category,
       avg(price) as "Rata Rata Harga",
       min(price) as "Harga termurah",
       max(price) as "Harga termahal"
from products
group by category;

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

create table customer
(
    id         serial       not null,
    email      varchar(100) not null,
    first_name varchar(100) not null,
    last_name  varchar(100),
    primary key (id),
    constraint unique_email unique (email)
);

select *
from customer;

insert into customer(email, first_name, last_name)
values ('eko@pzn.com', 'Eko', 'Khannedy');

insert into customer(email, first_name, last_name)
values ('budi@pzn.com', 'Budi', 'Nugraha'),
       ('joko@pzn.com', 'Joko', 'Morro'),
       ('rully@pzn.com', 'Rully', 'Irwansyah');

alter table customer
    drop constraint unique_email;

alter table customer
    add constraint unique_email unique (email);

alter table products
    add constraint price_check check ( price > 1000 );

alter table products
    add constraint quantity_check check ( quantity >= 0 );

insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10, 0, 'Minuman');

insert into products(id, name, price, quantity, category)
values ('XXX1', 'Contoh Gagal', 10000, -10, 'Minuman');

select *
from products;

create table sellers
(
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

create index sellers_id_and_name_index ON sellers (id, name);
create index sellers_email_and_name_index ON sellers (email, name);
create index sellers_name_index ON sellers (name);

select *
from sellers
where id = 1;
select *
from sellers
where id = 1
   or name = 'Toko Tono';
select *
from sellers
where email = 'rully@pzn.com'
   or name = 'Toko Tono';
select *
from sellers
where name = 'Toko Tono';

select *
from products
where name ilike '%mie%';

select *
from products
where to_tsvector(name) @@ to_tsquery('mie');

select cfgname
from pg_ts_config;

create index products_name_search on products using gin (to_tsvector('indonesian', name));
create index products_description_search on products using gin (to_tsvector('indonesian', description));

select *
from products
where name @@ to_tsquery('ayam & tahu');
select *
from products
where description @@ to_tsquery('mie');

create table wishlist
(
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
where id = 'P0005';

alter table wishlist
    drop constraint fk_wishlist_product;

alter table wishlist
    add constraint fk_wishlist_product foreign key (id_product) references products (id)
        on delete cascade on update cascade;

insert into products(id, name, price, quantity, category)
values ('XXX', 'Xxx', 10000, 100, 'Minuman');

SELECT *
FROM products;
insert into wishlist(id_product, description)
values ('XXX', 'Contoh');

select *
from wishlist;

delete
from products
where id = 'XXX';

select *
from wishlist
         join products on wishlist.id_product = products.id;

select p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id;

alter table wishlist
    add column id_customer int;

alter table wishlist
    add constraint fk_wishlist_customer foreign key (id_customer) references customer (id);

update wishlist
set id_customer = 1
where id in (2, 3);

update wishlist
set id_customer = 4
where id = 4;

select *
From customer;

select *
from wishlist;

select c.email, p.id, p.name, w.description
from wishlist as w
         join products as p on w.id_product = p.id
         join customer as c on c.id = w.id_customer;

create table wallet
(
    id          serial not null,
    id_customer int    not null,
    balance     int    not null default 0,
    primary key (id),
    constraint wallet_customer_unique unique (id_customer),
    constraint fk_wallet_customer foreign key (id_customer) references customer (id)
);

select *
from customer;

insert into wallet(id_customer, balance)
values (1, 1000000),
       (4, 2000000),
       (5, 3000000),
       (6, 4000000);

select *
from wallet;

select *
from customer
         join wallet on wallet.id_customer = customer.id;

create table categories
(
    id   varchar(10)  not null,
    name varchar(100) not null,
    primary key (id)
);

insert into categories(id, name)
values ('C0001', 'Makanan'),
       ('C0002', 'Minuman');

select *
from categories;

alter table products
    add column id_category varchar(10);

alter table products
    add constraint fk_product_category foreign key (id_category) references categories (id);

select *
from products;

update products
set id_category = 'C0001'
where category = 'Makanan';

update products
set id_category = 'C0002'
where category = 'Minuman';

alter table products
    drop column category;

select *
from products
         join categories on products.id_category = categories.id;

create table orders
(
    id         serial    not null,
    total      int       not null,
    order_date timestamp not null default current_timestamp,
    primary key (id)
);

create table orders_detail
(
    id_product varchar(10) not null,
    id_order   int         not null,
    price      int         not null,
    quantity   int         not null,
    primary key (id_product, id_order)
);

alter table orders_detail
    add constraint fk_orders_detail_product foreign key (id_product) references products (id);

alter table orders_detail
    add constraint fk_orders_detail_order foreign key (id_order) references orders (id);

insert into orders(total)
values (1),
       (1),
       (1);

select *
from orders;

select *
from products
order by id;

insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 1, 1000, 2),
       ('P0002', 1, 1000, 2),
       ('P0003', 1, 1000, 2);

insert into orders_detail (id_product, id_order, price, quantity)
values ('P0004', 2, 1000, 2),
       ('P0006', 2, 1000, 2),
       ('P0007', 2, 1000, 2);

insert into orders_detail (id_product, id_order, price, quantity)
values ('P0001', 3, 1000, 2),
       ('P0004', 3, 1000, 2),
       ('P0005', 3, 1000, 2);

select *
from orders_detail;

select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id;


select *
from orders
         join orders_detail on orders_detail.id_order = orders.id
         join products on orders_detail.id_product = products.id
where orders.id = 3;

insert into categories (id, name)
VALUES ('C0003', 'Gadget'),
       ('C0004', 'Laptop'),
       ('C0005', 'Pulsa');

select *
from categories;

select *
from products;

insert into products(id, name, price, quantity)
values ('X0001', 'Contoh 1', 10000, 100),
       ('X0002', 'Contoh 2', 10000, 100);

select *
from categories
         inner join products on products.id_category = categories.id;

select *
from categories
         left join products on products.id_category = categories.id;

select *
from categories
         right join products on products.id_category = categories.id;

select *
from categories
         full join products on products.id_category = categories.id;

select avg(price)
from products;

select *
from products
where price > (select avg(price) from products);

select *
from products;

select max(price)
from (select products.price as price
      from categories
               join products on products.id_category = categories.id) as contoh;

create table guestbooks
(
    id      serial       not null,
    email   varchar(100) not null,
    title   varchar(100) not null,
    content text,
    primary key (id)
);

select *
from customer;

insert into guestbooks(email, title, content)
values ('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
       ('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
       ('budi@pzn.com', 'feedback budi', 'ini feedback budi'),
       ('rully@pzn.com', 'feedback rully', 'ini feedback rully'),
       ('tono@pzn.com', 'feedback tono', 'ini feedback tono'),
       ('tono@pzn.com', 'feedback tono', 'ini feedback tono');

select *
from guestbooks;

select distinct email
from customer
union
select distinct email
from guestbooks;

select email
from customer
union all
select email
from guestbooks;

select email, count(email)
from (select email
      from customer
      union all
      select email
      from guestbooks) as contoh
group by email;

select email
from customer
intersect
select email
from guestbooks;

select email
from customer
except
select email
from guestbooks;

start transaction;

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

select *
from guestbooks;

commit;

start transaction;

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

select *
from guestbooks;

rollback;

select *
from products;

start transaction;

update products
set description = 'Mie ayam original enak'
where id = 'P0001';

select *
from products
where id = 'P0001';

commit;

start transaction;

select *
from products
where id = 'P0001' for update;

rollback;

select *
from products
where id = 'P0001';

start transaction;

select *
from products
where id = 'P0001' for update;

select *
from products
where id = 'P0002' for update;

rollback;

select current_schema();

create schema contoh;

drop schema contoh;

SET search_path TO contoh;

select current_schema();

select *
from public.products;

create table contoh.products
(
    id   serial       not null,
    name varchar(100) not null,
    primary key (id)
);

select * from contoh.products;

SET search_path TO public;

insert into contoh.products(name)
values ('iphone'),
       ('Play Station');

select * from contoh.products;

create role eko;
create role budi;

drop role eko;
drop role budi;

alter role eko login password 'rahasia';

alter role budi login password 'rahasia';

grant insert, update, select on all tables in schema public to eko;
grant usage, select, update ON guestbooks_id_seq TO eko;
grant insert, update, select on customer to budi;

create database belajar_restore;