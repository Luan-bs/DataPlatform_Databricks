SELECT
  ROUND(
    SUM(CASE WHEN satisfaction >= 4 THEN 1 ELSE 0 END)
    / COUNT(*)
    ,2
  ) AS Positivos,
  SUM(CASE WHEN satisfaction >= 4 THEN 1 ELSE 0 END) AS Qtd_Positivos,
  ROUND(
    SUM(CASE WHEN satisfaction <= 3 THEN 1 ELSE 0 END)
    / COUNT(*)
    ,2
  ) AS Negativos,
  SUM(CASE WHEN satisfaction <= 3 THEN 1 ELSE 0 END) AS Qtd_Negativos
FROM f_ticketsatisfactions
WHERE satisfaction IS NOT NULL