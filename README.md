# Relational-Database-Pacmann-Penjualan-Mobil-Bekas-
# Relational Database & SQL Project
Relational Database, Sekolah Engineering, Pacmann

KELAS SOFTWARE ENGINEERING - ARDITA DWI SETYONUGROHO
## Latar Belakang
Dalam project ini anda diberikan tugas untuk membangun relational database untuk sebuah website yang menawarkan penjualan mobil bekas. Gambaran umum tentang project ini adalah siapa saja dapat menawarkan produknya (mobil bekas) dalam bentuk iklan dan calon pembeli dapat melakukan pencarian berdasarkan beberapa kategori. 
Untuk lebih jelasnya, berikut adalah fitur serta batasan project ini:
- Setiap user aplikasi dapat menawarkan lebih dari satu produk mobil bekasnya.
- Sebelum menjual produk mobil, user harus melengkapi data dirinya terlebih dahulu, seperti nama, kontak, dan domisili lokasi.
- User menawarkan produknya melalui iklan yang akan ditampilkan oleh website.
- Iklan ini berisikan judul, detail informasi produk yang ditawarkan, serta kontak penjual.
- Beberapa informasi yang harus ditulis dalam iklan adalah sebagai berikut
a. merek mobil: Toyota, Daihatsu, Honda, dll
b. Model: Toyota Camry, Toyota Corolla Altis, Toyota Vios,Toyota Camry Hybrid, dll
c. Jenis body mobil: MPV, SUV, Van, Sedan, Hatchback, dll
d. Tipe mobil: manual atau automatic
e. Tahun pembuatan mobil: 2005, 2010, 2011, 2020 
f. Deskripsi lain, seperti warna, jarak yang telah ditempuh, dsb,  boleh ditambahkan sesuai kebutuhan.
- Setiap user bisa mencari mobil yg ditawarkan berdasarkan lokasi user penjual, merk mobil, dan jenis body mobil.
- Jika calon pembeli tertarik terhadap sebuah mobil, ia dapat menawar (bid) harga produk jika penjual mengizinkan fitur tawar. 
- Transaksi pembelian dilakukan di luar aplikasi sehingga tidak dalam scope project

Anda akan diminta untuk membangun sebuah relational database berdasarkan tahapan perancangan database yang telah dipelajari, menginputkan dummy data ke dalam database, serta melakukan analisis sederhana terhadap dummy data tersebut.
 

## Designing The Database
Berdasarkan Latar Belakang diatas bisa dibuat ERD sebagai berikut:
- Membuat tabel kota dengan (kota_id = Primary Key)
- Membuat Tabel penjual dengan menghubungkan tabel kota dengan penjual (penjual_id = Primary Key, kota_id = Foreign Key)  
- Membuat Tabel produk dengan menghubungkan tabel produk dengan penjual (produk_id = Primary Key, penjual_id = Foreign Key)  
- Membuat Tabel iklan dengan menghubungkan tabel iklan dengan produk (iklan_id = Primary Key, produk_id = Foreign Key) 
- Membuat Tabel bid dengan menghubungkan tabel bid dengan iklan (bid_id = Primary Key, iklan_id = Foreign Key) 

Untuk lebih jelasnya kita bisa lihat ERD dibawah ini :
![ERD](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/ERD%20relational%20database.png)



## Implementing The Design
Membuat syntax DDL tabel yang dibutuhkan:
```
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
```   
## Populating the database
a. Membuat dummy file untuk tiap kolom dengan cara menggenerate menggunakan python dengan syntax sebagai berikut:
```
# Membuat penjual dummy file
import pandas as pd
from faker import Faker

fake = Faker('id_ID')

users = []

for i in range(15):
    user = {
        'penjual_id': i+1,
        'nama': fake.name(),
        'kontak': fake.phone_number(),
        
    }
     
    users.append(user)

df = pd.DataFrame(users)
df.to_csv('penjual dummy.csv', index=False)


# Menggabungkan tabel kota dengan penjual
import pandas as pd
df1 = pd.read_csv('tabel penjual.csv')
df2 = pd.read_csv('kota.csv')
df_merged = pd.merge(df1, df2, on='kota_id')
df_merged.to_csv('upgrade tabel penjual.csv', index=False)


# Meng upgrade tabel produk yang sudah disediakan
import pandas as pd
import random

df = pd.read_csv('produk_mobil.csv')

df['penjual_id'] = [random.randint(1,15) for _ in range(len(df))]

warna_mobil = ['merah', 'biru', 'kuning', 'hijau', 'hitam', 'putih']
df['warna'] = [random.choice(warna_mobil) for _ in range(len(df))]

df['jarak_tempuh'] = [random.randint(100000,500000) for _ in range(len(df))]

grade_mobil = ['a', 'b', 'c', 'a+', 'b+', 'c+']
df['kondisi_mobil(grade)'] = [random.choice(grade_mobil) for _ in range(len(df))]

df.to_csv('upgrade tabel produk.csv', index=False)


# Membuat tabel iklan dan mengupgrade tabel iklan
import pandas as pd
from faker import Faker

fake = Faker('id_ID')

users = []

for i in range(50):
    user = {
        'iklan_id': i+1,
        'product_id': i+1
        
    }
     
    users.append(user)

df = pd.DataFrame(users)
df.to_csv('tabel iklan.csv', index=False)

import pandas as pd
import random
import datetime
df = pd.read_csv('tabel iklan.csv')

start_date = datetime.date(2022, 1, 1)
end_date = datetime.date(2022, 2, 1)
date_list = [start_date + datetime.timedelta(days=x) for x in range((end_date-start_date).days + 1)]
df['tanggal_posting'] = random.choices(date_list, k=len(df))

df.to_csv('upgrade tabel iklan.csv', index=False)


# Membuat bid dummy file
import pandas as pd
from faker import Faker

fake = Faker('id_ID')

users = []

for i in range(500):
    user = {
        'bid_id': i+1,
        'nama_pembeli': fake.name(),
        'kontak_pembeli': fake.phone_number(),
    
    }
     
    users.append(user)

df = pd.DataFrame(users)
df.to_csv('bid.csv', index=False)

import pandas as pd
import random
import datetime
df = pd.read_csv('bid.csv')

df['iklan_id'] = [random.randint(1,50) for _ in range(len(df))]

start_date = datetime.date(2022, 2, 2)
end_date = datetime.date(2023, 2, 1)
date_list = [start_date + datetime.timedelta(days=x) for x in range((end_date-start_date).days + 1)]
df['tanggal_penawaran'] = random.choices(date_list, k=len(df))

df['harga_penawaran'] = [random.randint(150000000,300000000) for _ in range(len(df))]

df['status_penawaran'] = [('sent') for _ in range(len(df)) ]


df.to_csv('upgrade tabel bid.csv', index=False)
```
b. Memasukan dummy file csv dari hasil syntax diatas pada tiap tabel menggunakan syntax:  
```
COPY
kota
FROM 'C:\relational database\kota.csv' 
DELIMITER ',' 
CSV 
HEADER;

COPY 
penjual
FROM 'C:\relational database\upgrade tabel penjual.csv' 
DELIMITER ',' 
CSV 
HEADER;

COPY 
produk
FROM 'C:\relational database\upgrade tabel produk.csv' 
DELIMITER ',' 
CSV 
HEADER;

COPY 
iklan
FROM 'C:\relational database\upgrade tabel iklan.csv' 
DELIMITER ',' 
CSV 
HEADER;

COPY 
bid
FROM 'C:\relational database\upgrade tabel bid.csv' 
DELIMITER ',' 
CSV 
HEADER;
```
## Retrieve data
a. Contoh Kasus Transactional Query :
![transactional query 1](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/TRANSACSIONAL%20QUERY%201.png)

![transactional query 2](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/TRANSACSIONAL%20QUERY%202.png)

![transactional query 3](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/TRANSACTIONAL%20QUERY%203.png)

![transactional query 4](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/TRANSACSIONAL%20QUERY%204.png)

![transactional query 5](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/TRANSACSIONAL%20QUERY%205.png)

b. Contoh Kasus Analytical query :
![analyctical query 1](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/Analytical%20Query%201.png)

![analyctical query 2](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/Analytical%20Query%202.png)

![analyctical query 3](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/Analytical%20Query%203.png)

![analyctical query 4](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/Analytical%20Query%204.png)

![analyctical query 5](https://raw.githubusercontent.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-/main/Analytical%20Query%205.png)

link github [https://github.com/arditadwis/Relational-Database-Pacmann---Penjualan-Mobil-Bekas-]
