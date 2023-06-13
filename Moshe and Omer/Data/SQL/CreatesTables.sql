CREATE TABLE Sellers (
  seller_id INT PRIMARY KEY,
  seller_email VARCHAR2(255),
  seller_name VARCHAR2(255),
  seller_phone VARCHAR2(20)
);

CREATE TABLE Buyers (
  buyer_id INT PRIMARY KEY,
  buyer_email VARCHAR2(255),
  buyer_name VARCHAR2(255),
  buyer_phone VARCHAR2(20),
  club_id INT,
  FOREIGN KEY (club_id) REFERENCES Fan_clubs (club_id)
);

CREATE TABLE TicketSales (
  ticket_sale_id INT PRIMARY KEY,
  game_id INT,
  section_name VARCHAR2(255),
  row_number INT,
  seat INT,
  price NUMBER(10,2),
  seller_id INT,
  buyer_id INT,
  purchase_date DATE,
  FOREIGN KEY (game_id) REFERENCES Games(game_id),
  FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE MerchandiseCategories (
  category_id INT PRIMARY KEY,
  category_name VARCHAR2(255)
);

CREATE TABLE Manufacturers (
  manufacturer_id INT PRIMARY KEY,
  manufacturer_name VARCHAR2(255)
);

CREATE TABLE Merchandise (
  merchandise_id INT PRIMARY KEY,
  merchandise_name VARCHAR2(255),
  merchandise_description CLOB,
  merchandise_price NUMBER,
  merchandise_quantity INT,
  category_id INT,
  manufacturer_id INT,
  FOREIGN KEY (category_id) REFERENCES MerchandiseCategories(category_id),
  FOREIGN KEY (manufacturer_id) REFERENCES Manufacturers(manufacturer_id)
);

CREATE TABLE MerchandiseSales (
  merchandise_sale_id INT PRIMARY KEY,
  merchandise_id INT,
  seller_id INT,
  buyer_id INT,
  sale_date DATE,
  price NUMBER(10,2),
  FOREIGN KEY (merchandise_id) REFERENCES Merchandise(merchandise_id),
  FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
  FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE Fan_clubs (
  club_id INT PRIMARY KEY,
  club_name VARCHAR2(255),
  club_description CLOB,
  club_location VARCHAR2(255),
  club_membership_fee NUMBER,
  club_membership_length VARCHAR2(255),
  club_membership_count INT,
  FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

