SELECT

    priority,
    COUNT(*) AS quantidade

FROM glpi.gold_chamados.f_tickets

GROUP BY priority

ORDER BY priority;