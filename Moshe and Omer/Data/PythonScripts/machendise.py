import csv
import random
from tqdm import tqdm
from faker import Faker

# Initializing the faker library
fake = Faker()

# Defining constants
NUM_CATEGORIES = 200
NUM_MANUFACTURERS = 200
NUM_MERCHANDISE = 2000

# Generating mock data
categories = []
manufacturers = []
merchandise = []

# Generating categories
for i in range(NUM_CATEGORIES):
    category_id = i + 1
    category_name = fake.word()
    categories.append((category_id, category_name))

# Generating manufacturers
for i in range(NUM_MANUFACTURERS):
    manufacturer_id = i + 1
    manufacturer_name = fake.company()
    manufacturers.append((manufacturer_id, manufacturer_name))

# Generating merchandise with a progress bar using tqdm module
for i in tqdm(range(NUM_MERCHANDISE)):
    merchandise_id = i + 1
    merchandise_name = fake.word()
    merchandise_description = fake.text(max_nb_chars=50)
    merchandise_price = round(random.uniform(1, 1000), 2)
    merchandise_quantity = random.randint(0, 100)
    category_id = random.choice(categories)[0]
    manufacturer_id = random.choice(manufacturers)[0]
    merchandise.append((merchandise_id, merchandise_name, merchandise_description, merchandise_price, merchandise_quantity, category_id, manufacturer_id))

# Saving mock data to csv files with a progress bar using tqdm module
with open("MerchandiseCategories.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["category_id", "category_name"])
    writer.writerows(categories)

with open("Manufacturers.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["manufacturer_id", "manufacturer_name"])
    writer.writerows(manufacturers)

with open("Merchandise.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["merchandise_id", "merchandise_name", "merchandise_description", "merchandise_price", "merchandise_quantity", "category_id", "manufacturer_id"])

    with tqdm(total=len(merchandise)) as pbar:
        for row in merchandise:
            writer.writerow(row)
            pbar.update(1)

print("Mock data generated and saved successfully!")
