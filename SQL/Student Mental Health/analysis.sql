  --Breakdown of PHQ-9 by year & group
  SELECT stay,
    COUNT(*) FILTER (WHERE inter_dom = 'Inter')                        AS inter_pop,
    ROUND((AVG(todep) FILTER (WHERE inter_dom = 'Inter'))::numeric, 2) AS inter_phq,
    COUNT(*) FILTER (WHERE inter_dom = 'Dom')                          AS dom_pop,
    ROUND((AVG(todep) FILTER (WHERE inter_dom = 'Dom'))::numeric, 2)   AS dom_phq
  FROM students
  WHERE inter_dom IN ('Inter', 'Dom')
    AND stay IS NOT NULL
      GROUP BY stay
      ORDER BY stay;

--Inter_Dom descriptive statistics, population size, averages of psychometrics and standard deviation for PHQ-9
SELECT inter_dom,
       COUNT(*)                              AS n,
       ROUND(AVG(todep)::numeric, 2)         AS mean_phq9,
       ROUND(STDDEV_SAMP(todep)::numeric, 2) AS sd_phq9,
       ROUND(AVG(tosc)::numeric, 2)          AS mean_scs,
       ROUND(AVG(toas)::numeric, 2)          AS mean_as
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
  AND stay IS NOT NULL
GROUP BY inter_dom;

-- Shows survey responses with PHQ-9 results >= 10 as a percent for inter_dom.
SELECT inter_dom,
     COUNT(*)                                        AS n,
     COUNT(*) FILTER (WHERE todep >= 10)             AS mod_or_greater,
     ROUND(100.0 * COUNT(*) FILTER (WHERE todep >= 10)
           / COUNT(*), 2)                            AS "%"
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
AND stay IS NOT NULL
GROUP BY inter_dom;

-- Review of deptype frequency
  SELECT inter_dom,
         COUNT(*)                                                     AS n,
         COUNT(*) FILTER (WHERE deptype IN ('Major', 'Other'))        AS deptype,
         ROUND(100.0 * COUNT(*) FILTER (WHERE deptype IN ('Major', 'Other'))
               / COUNT(*), 2)                                         AS "%"
  FROM students
  WHERE inter_dom IN ('Inter', 'Dom')
    AND stay IS NOT NULL
  GROUP BY inter_dom;
