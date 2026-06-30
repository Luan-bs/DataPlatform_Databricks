SELECT
COUNT(f.ticket_id) AS Fechados
FROM f_tickets f
JOIN d_status d on f.status_id = d.status_id
WHERE d.status_descricao = "Chamado Fechado"