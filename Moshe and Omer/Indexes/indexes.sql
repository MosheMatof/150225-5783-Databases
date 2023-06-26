-- Index on Merchandise_Sales.buyer_id
CREATE INDEX idx_merchandise_sales_buyer_id
ON Merchandise_Sales (buyer_id);

-- Index on Ticket_Sales.buyer_id
CREATE INDEX idx_ticket_sales_buyer_id
ON Ticket_Sales (buyer_id);

-- Index on Merchandise_Sales for month-based grouping
CREATE INDEX idx_merchandise_sales_month
ON Merchandise_Sales (TRUNC(purchase_date, 'MM'));

-- Index on Ticket_Sales for month-based grouping
CREATE INDEX idx_ticket_sales_month
ON Ticket_Sales (TRUNC(purchase_date, 'MM'));
