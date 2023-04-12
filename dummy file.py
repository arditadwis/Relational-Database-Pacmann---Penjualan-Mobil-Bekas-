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