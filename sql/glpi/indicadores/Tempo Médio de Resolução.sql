SELECT

    ROUND(AVG(horas_resolucao),2) AS horas_medias

FROM glpi.gold_chamados.f_tickets

WHERE horas_resolucao IS NOT NULL;