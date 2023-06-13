import random
from faker import Faker
import csv
from tqdm import tqdm

num_rows = 100000

fake = Faker()

merchandise_ids = list(range(1, 2001))
seller_ids = list(range(1, 200))
buyer_ids = list(range(1, 50000))

sales = []

for i in tqdm(range(num_rows)):
    sale_id = i + 1
    merchandise_id = random.choice(merchandise_ids)
    seller_id = random.choice(seller_ids)
    buyer_id = random.choice(buyer_ids)
    sale_date = fake.date_between(start_date='-1y', end_date='today')
    price = round(random.uniform(5, 100), 2)
    purchase_date = fake.date_between(start_date="-1y", end_date="today")
    row = [sale_id, merchandise_id, seller_id, buyer_id, sale_date, price,purchase_date]
    sales.append(row)

with open("merchandise_sales.csv", "w") as f: 
    writer = csv.writer(f) 
    writer.writerow(["merchandise_sale_id", "merchandise_id", "seller_id", "buyer_id", "sale_date", "price","purchase_date"]) 
    writer.writerows(sales)
