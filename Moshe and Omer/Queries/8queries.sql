--1. פרטי הקונים שקנו כרטיסים.

SELECT *
FROM BUYERS
WHERE buyer_id IN (SELECT DISTINCT buyer_id FROM TICKET_SALES);

-- 43397 שורות ב 12.462 שניות.

-- 2. הבאת פרטי הקונים וכמות הרכישות שביצעו.
SELECT BUYERS.buyer_name, COUNT(TICKET_SALES.buyer_id) AS purchase_count
FROM BUYERS
JOIN TICKET_SALES ON BUYERS.buyer_id = TICKET_SALES.buyer_id
GROUP BY BUYERS.buyer_name;

-- 3. רשימת הקונים שקנו ביותר מ 1000$ מוצרי ספורט.
SELECT COUNT(*) AS club_count
FROM FAN_CLUBS
WHERE club_membership_count >= 100;

-- 80 שורות ב 0.131 שניות.

-- 4. סה"כ הרכישות וההכנסות מכל המועדונים.
SELECT FAN_CLUBS.club_name, COUNT(TICKET_SALES.ticket_sale_id) AS total_sales, SUM(TICKET_SALES.price) AS total_revenue
FROM FAN_CLUBS
LEFT JOIN TICKET_SALES ON FAN_CLUBS.club_id = TICKET_SALES.buyer_id
GROUP BY FAN_CLUBS.club_name;

-- 20 שורות ב 0.051 שניות.

-- 5. המוצר ספורט הנמכר ביותר בכל חודש בשנה נתונה.
SELECT
    EXTRACT(MONTH FROM ms.purchase_date) AS month,
    MAX(m.merchandise_name) AS top_selling_merchandise,
    COUNT(ms.merchandise_sale_id) AS sales_count
FROM
    Merchandise_Sales ms
    JOIN Merchandise m ON ms.merchandise_id = m.merchandise_id
WHERE
    EXTRACT(YEAR FROM ms.purchase_date) = 2022
GROUP BY
    EXTRACT(MONTH FROM ms.purchase_date)
ORDER BY
    EXTRACT(MONTH FROM ms.purchase_date);

-- זמן ריצה כולל 0.078

-- 6. עשרת המוכרים שמכרו הכי הרבה כרטיסים.
SELECT s.seller_name, COUNT(ts.ticket_sale_id) AS ticket_count
FROM Sellers s
JOIN Ticket_Sales ts ON s.seller_id = ts.seller_id
GROUP BY s.seller_name
ORDER BY ticket_count DESC
FETCH FIRST 10 ROWS ONLY;

-- 10 שורות  ב0.45 שניות.

-- 7. עשרת המועדונים שהחברים בהם קנו הכי הרבה כרטיסים.
SELECT fc.club_id, fc.club_name, COUNT(*) AS tickets_purchased_count
FROM Fan_clubs fc
JOIN Buyers b ON fc.club_id = b.club_id
JOIN Ticket_Sales ts ON b.buyer_id = ts.buyer_id
GROUP BY fc.club_id, fc.club_name
ORDER BY tickets_purchased_count DESC
FETCH FIRST 10 ROWS ONLY;

-- זמן ריצה 12.614 שניות.

-- 8. השוואת נתוני מכירות של מוצרי ספורט וכרטיסים לפי חודשים.
-- מחזיר כמות מכירות (פריטים/כסף) של שתי הקטגוריות , משווה כמה לקוחות קנו מכל דבר, כמה מהם הם לקוחות יחודיים (שקנו רק מהקטגוריה הספציפית) וכמה יחודיים.
-- זמן ריצה כולל 44.837 שניות (לחישוב של חודשיים)
WITH ms AS (
    SELECT 
        TRUNC(purchase_date, 'MM') AS sale_date, 
        COUNT(DISTINCT merchandise_sale_id) AS merchandise_sales_count,
        SUM(price) AS merchandise_sales_amount,
        COUNT(DISTINCT merchandise_id) AS distinct_merchandise_count,
        COUNT(DISTINCT buyer_id) AS shared_buyers_count
    FROM Merchandise_Sales
    WHERE purchase_date >= DATE '2023-01-01' AND purchase_date < DATE '2023-03-01'
    GROUP BY TRUNC(purchase_date, 'MM')
), 
ts AS (
    SELECT 
        TRUNC(purchase_date, 'MM') AS sale_date, 
        COUNT(DISTINCT ticket_sale_id) AS ticket_sales_count,
        SUM(price) AS ticket_sales_amount,
        COUNT(DISTINCT CASE WHEN buyer_id NOT IN (SELECT buyer_id FROM Merchandise_Sales) THEN buyer_id END) AS ticket_only_buyers_count
    FROM Ticket_Sales
    WHERE purchase_date >= DATE '2023-01-01' AND purchase_date < DATE '2023-03-01'
    GROUP BY TRUNC(purchase_date, 'MM')
)
SELECT 
    TO_CHAR(ms.sale_date, 'YYYY-MM') AS month,
    COALESCE(ms.merchandise_sales_count, 0) AS merchandise_sales_count,
    COALESCE(ts.ticket_sales_count, 0) AS ticket_sales_count,
    COALESCE(ms.merchandise_sales_amount, 0) AS merchandise_sales_amount,
    COALESCE(ts.ticket_sales_amount, 0) AS ticket_sales_amount,
    COALESCE(ms.distinct_merchandise_count, 0) AS distinct_merchandise_count,
    COALESCE(ts.ticket_only_buyers_count, 0) AS ticket_only_buyers_count,
    COALESCE(ms.shared_buyers_count, 0) AS shared_buyers_count
FROM ms
FULL JOIN ts ON ms.sale_date = ts.sale_date
ORDER BY month;
