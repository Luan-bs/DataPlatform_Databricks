SELECT

    s.status_descricao,
    COUNT(*) AS quantidade

FROM workspace.glpi.f_tickets t

INNER JOIN workspace.glpi.d_status s
    ON t.status_id = s.status_id

WHERE t.deletado = false

GROUP BY
    s.status_descricao


ORDER BY
    quantidade DESC;