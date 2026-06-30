SELECT
COUNT(ticket_id) AS Abertos
FROM f_tickets 
WHERE status_id IN (4,2,3)