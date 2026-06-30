SELECT
    u.nome_completo,
    COUNT(*) AS Chamados
FROM p_tickets_users tu
JOIN d_users u
ON tu.usuario_id = u.user_id
WHERE tu.tipo_relacionamento = 'Técnico'
GROUP BY u.nome_completo
ORDER BY Chamados DESC