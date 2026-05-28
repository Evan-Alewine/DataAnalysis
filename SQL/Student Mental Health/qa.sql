SELECT 
	stay, 
	COUNT(inter_dom) AS count_int, 
	ROUND(AVG(todep)::numeric, 2) AS average_phq, 
	ROUND(AVG(tosc)::numeric, 2) AS average_scs, 
	ROUND(AVG(toas)::numeric, 2) AS average_as 
FROM students
	WHERE 
	stay IS NOT NULL 
	AND inter_dom LIKE 'Inter'
GROUP BY stay ORDER BY stay DESC