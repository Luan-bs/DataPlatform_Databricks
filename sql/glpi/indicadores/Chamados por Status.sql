SELECT 
    COUNT(f_tickets.ticket_id), 
    d_status.status_descricao 
FROM glpi.gold_chamados.f_tickets JOIN glpi.gold_chamados.d_status 
ON f_tickets.status_id = d_status.status_id 
GROUP BY 2;