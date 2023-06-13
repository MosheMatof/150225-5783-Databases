import random
import csv
from faker import Faker
from tqdm import tqdm

fake = Faker()

num_sellers = 200
num_buyers = 50000

sellers_rows = []

for i in tqdm(range(num_sellers)):
    seller_id = i + 1
    seller_email = fake.email()
    seller_name = fake.name()
    seller_phone = fake.phone_number()
    while len(seller_phone) > 15:
        seller_phone = fake.phone_number()
    row = [seller_id, seller_email, seller_name, seller_phone]
    sellers_rows.append(row)

buyers_rows = []

for i in tqdm(range(num_buyers)):
    buyer_id = i + 1
    buyer_email = fake.email()
    buyer_name = fake.name()
    buyer_phone = fake.phone_number()
    while len(buyer_phone) > 15:
        buyer_phone = fake.phone_number()
    club_id = random.randint(1, 9999)
    row = [buyer_id, buyer_email, buyer_name, buyer_phone, club_id]
    buyers_rows.append(row)

with open("sellers.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerow(["seller_id", "seller_email", "seller_name", "seller_phone"])
    writer.writerows(sellers_rows)

with open("buyers.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerow(["buyer_id", "buyer_email", "buyer_name", "buyer_phone", "club_id"])
    writer.writerows(buyers_rows)
