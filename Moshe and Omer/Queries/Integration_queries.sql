
--1. כמות ההכנסות במכירת כרטיסים בכל משחק.
SELECT g.GameID, g.GameDate, SUM(ts.price) AS total_sales_amount
FROM akorman.games g
JOIN Ticket_Sales ts ON g.GameID = ts.game_id
GROUP BY g.GameID, g.GameDate

--2. רשימת המשחקים שנמכרו בהם הכי הרבה כרטיסים
SELECT g.GameID, g.GameDate, g.GameHour, COUNT(ts.ticket_sale_id) AS num_ticket_sales
FROM Games g
JOIN Ticket_Sales ts ON g.GameID = ts.game_id
GROUP BY g.GameID, g.GameDate, g.GameHour
ORDER BY num_ticket_sales DESC;

--3. פרטי הכרטיסים והקונים במשחק נתון.
SELECT b.buyer_name, b.buyer_email, t.section_name, t.row_number, t.seat, t.price
FROM Buyers b
JOIN Ticket_Sales t ON b.buyer_id = t.buyer_id
JOIN akorman.games g ON t.game_id = g.GameID
WHERE g.GameID = 18;
