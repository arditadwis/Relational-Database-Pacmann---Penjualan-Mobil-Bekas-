--Analytical Query
--1. Ranking popularitas model mobil berdasarkan jumlah bid
SELECT model, COUNT(*) AS total_bid
FROM bid
JOIN iklan ON bid.iklan_id = iklan.iklan_id
JOIN produk ON iklan.product_id = produk.product_id
GROUP BY model
ORDER BY total_bid DESC;

--2. Harga rata-rata mobil tiap kota
SELECT 
	penjual.nama_kota, 
	produk.brand,
	produk.model,
	produk.year,
	AVG(produk.price)AS rerata_harga
FROM penjual
JOIN produk ON penjual.penjual_id = produk.penjual_id
GROUP BY penjual.nama_kota,produk.brand, produk.model, produk.year ;

--3. Cari perbandingan tanggal user melakukan bid dengan bid selanjutnya beserta harga tawar yang diberikan
SELECT 
	bid.bid_id,
	bid.tanggal_penawaran,
	LEAD(bid.tanggal_penawaran) OVER(ORDER BY bid.tanggal_penawaran) AS tanggal_penawaran_selanjutnya,
	bid.harga_penawaran,
	LEAD(bid.harga_penawaran) OVER(ORDER BY bid.tanggal_penawaran) AS harga_penawaran_selanjutnya
FROM 
	bid
JOIN iklan ON bid.iklan_id = iklan.iklan_id
JOIN produk ON iklan.product_id = produk.product_id
WHERE
	produk.model = 'Toyota Yaris'
ORDER BY 
	bid.tanggal_penawaran ASC;

--4. Membandingkan persentase perbedaan rata-rata harga mobil berdasarkan modelnya dan rata-rata harga bid yang ditawarkan oleh customer
SELECT 
	produk.model,
	AVG(produk.price) AS rerata_harga_mobil,
	AVG(bid.harga_penawaran) AS rerata_harga_bid,
	((AVG(bid.harga_penawaran)- AVG(produk.price))/AVG(produk.price)) * 100 AS persentase_perbedaan
FROM
	produk
JOIN iklan ON iklan.product_id = produk.product_id
JOIN bid ON bid.iklan_id = iklan.iklan_id
GROUP BY produk.model;

--5. Membuat window function rata-rata harga bid sebuah merk dan model mobil
SELECT 
    produk.brand, 
    produk.model, 
    bid.tanggal_penawaran, 
    bid.harga_penawaran, 
    AVG(bid.harga_penawaran) 
	OVER(PARTITION BY produk.brand, produk.model ORDER BY bid.tanggal_penawaran ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS rerata_harga_bid
FROM 
    produk
JOIN iklan ON iklan.product_id = produk.product_id
JOIN bid ON bid.iklan_id = iklan.iklan_id;