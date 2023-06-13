import random
import string 
import csv
from tqdm import tqdm

num_rows = 10000

club_pairs = [("The Lakers Fan Club", "Los Angeles"), ("The Bulls Fan Club", "Chicago"), ("The Celtics Fan Club", "Boston"), ("The Warriors Fan Club", "San Francisco"), ("The Knicks Fan Club", "New York"), ("The Heat Fan Club", "Miami"), ("The Spurs Fan Club", "San Antonio"), ("The Raptors Fan Club", "Toronto"), ("The Rockets Fan Club", "Houston"), ("The Mavericks Fan Club", "Dallas"), ("The Nets Fan Club", "Brooklyn"), ("The Clippers Fan Club", "Los Angeles"), ("The Nuggets Fan Club", "Denver"), ("The Jazz Fan Club", "Salt Lake City"), ("The Suns Fan Club", "Phoenix"), ("The Bucks Fan Club", "Milwaukee"), ("The 76ers Fan Club", "Philadelphia"), ("The Hawks Fan Club", "Atlanta"), ("The Wizards Fan Club", "Washington D.C."), ("The Hornets Fan Club", "Charlotte")]

club_membership_lengths = ["Monthly", "Quarterly", "Yearly"] 

def random_string(length): 
    return "".join(random.choice(string.ascii_letters) for _ in range(length))

def random_description(length): 
    words = ["basketball", "fan", "club", "team", "player", "game", "win", "lose", "support", "cheer", "fun", "love", "passion", "loyalty", "community"] 
    return " ".join(random.choice(words) for _ in range(length))

rows = []

for i in tqdm(range(num_rows)):
    club_id = i + 1 
    club_pair = random.choice(club_pairs)
    club_name = club_pair[0]
    club_description = random_description(20) 
    club_location = club_pair[1]
    club_membership_fee = round(random.uniform(10, 100), 2) 
    club_membership_length = random.choice(club_membership_lengths) 
    club_membership_count = random.randint(0, 1000) 
    team_id = random.randint(1, 400) 
    row = [club_id, club_name, club_description, club_location, club_membership_fee, club_membership_length, club_membership_count, team_id] 
    rows.append(row)

with open("fan_clubs.csv", "w") as f: 
    writer = csv.writer(f) 
    writer.writerow(["club_id", "club_name", "club_description", "club_location", "club_membership_fee", "club_membership_length", "club_membership_count", "team_id"]) 
    writer.writerows(rows)
