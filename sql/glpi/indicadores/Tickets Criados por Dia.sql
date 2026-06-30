SELECT
    DATE(data_criacao) AS data,
    COUNT(*) AS quantidade
FROM glpi.gold_chamados.f_tickets
GROUP BY DATE(data_criacao)
ORDER BY data;