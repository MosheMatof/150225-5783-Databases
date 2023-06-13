from faker import Faker
from tqdm import tqdm
import random
import csv

fake = Faker()

num_rows = 100000

game_ids = list(range(1, 101))
seller_ids = list(range(1, 201))
buyer_ids = list(range(1, 50001))

section_names = ["Lower Level", "Upper Level", "Club Level", "Suite"]
prices = [25.00, 50.00, 75.00, 100.00, 150.00, 200.00]

rows = []

for i in tqdm(range(num_rows)):
    ticket_sale_id = i + 1
    game_id = random.choice(game_ids)
    section_name = random.choice(section_names)
    row_number = random.randint(1, 50)
    seat = random.randint(1, 100)
    price = random.choice(prices)
    seller_id = random.choice(seller_ids)
    buyer_id = random.choice(buyer_ids)
    purchase_date = fake.date_between(start_date="-1y", end_date="today")
    row = [ticket_sale_id, game_id, section_name, row_number, seat, price, seller_id, buyer_id, purchase_date]
    rows.append(row)

with open("ticket_sales.csv", "w") as f:
    writer = csv.writer(f)
    writer.writerow(["ticket_sale_id", "game_id", "section_name", "row_number", "seat", "price", "seller_id", "buyer_id", "purchase_date"])
    writer.writerows(rows)
