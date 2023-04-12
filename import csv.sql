-- Import DUMMY FILE--

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