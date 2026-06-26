SELECT

    ROUND(AVG(horas_resolucao),2) AS horas_medias

FROM workspace.glpi.f_tickets

WHERE horas_resolucao IS NOT NULL;