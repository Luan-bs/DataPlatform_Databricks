SELECT

    priority,
    COUNT(*) AS quantidade

FROM workspace.glpi.f_tickets

GROUP BY priority

ORDER BY priority;