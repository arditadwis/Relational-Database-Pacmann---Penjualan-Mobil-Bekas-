-- Membuat Tabel Tabel --
CREATE TABLE kota (
    kota_id SERIAL PRIMARY KEY,
    nama_kota VARCHAR(255) NOT NULL,
	latitude DECIMAL(10,8) NOT NULL,
    longitude DECIMAL(11,8) NOT NULL
);

CREATE TABLE penjual (
    penjual_id SERIAL PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kontak VARCHAR(255) NOT NULL,
    kota_id INT NOT NULL,
    nama_kota VARCHAR(255) NOT NULL,
    latitude DECIMAL(10,8) NOT NULL,
    longitude DECIMAL(11,8) NOT NULL,
    CONSTRAINT fk_penjual
		FOREIGN KEY (kota_id) 
		REFERENCES kota(kota_id)
);

CREATE TABLE produk (
    product_id SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    body_type VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    price INT NOT NULL,
    penjual_id INT NOT NULL,
    warna VARCHAR(255) NOT NULL,
    jarak_tempuh INT NOT NULL,
    kondisi_mobil VARCHAR(255) NOT NULL,
	CONSTRAINT fk_produk
    	FOREIGN KEY (penjual_id) 
		REFERENCES penjual(penjual_id)
);

CREATE TABLE iklan (
    iklan_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    tanggal_posting DATE NOT NULL,
	CONSTRAINT fk_produk
    	FOREIGN KEY (product_id) 
		REFERENCES produk(product_id)
);

CREATE TABLE bid (
    bid_id SERIAL PRIMARY KEY,
    nama_pembeli VARCHAR(255) NOT NULL,
    kontak_pembeli VARCHAR(255) NOT NULL,
    iklan_id INT NOT NULL,
    tanggal_penawaran DATE NOT NULL,
    harga_penawaran INT NOT NULL,
    status_penawaran VARCHAR(255) NOT NULL,
	CONSTRAINT fk_bid
    	FOREIGN KEY (iklan_id) 
		REFERENCES iklan(iklan_id)
);