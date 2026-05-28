--- count of total population sizes
SELECT 
    COUNT(CASE WHEN inter_dom = 'Inter' THEN 1 END) AS count_inter,
    COUNT(CASE WHEN inter_dom = 'Dom' THEN 1 END) AS count_dom
FROM students
	WHERE stay IS NOT NULL 
	AND inter_dom IS NOT NULL;

-- International Table
SELECT 
	stay, 
	COUNT(inter_dom) AS count_int, 
	ROUND(AVG(todep)::numeric, 2) AS average_phq, 
	ROUND(AVG(tosc)::numeric, 2) AS average_scs, 
	ROUND(AVG(toas)::numeric, 2) AS average_as 
FROM students
	WHERE stay IS NOT NULL 
	AND inter_dom LIKE 'Inter'
GROUP BY stay ORDER BY stay DESC;

-- Domestic Table
SELECT 
	stay, 
	COUNT(inter_dom) AS count_int, 
	ROUND(AVG(todep)::numeric, 2) AS average_phq, 
	ROUND(AVG(tosc)::numeric, 2) AS average_scs, 
	ROUND(AVG(toas)::numeric, 2) AS average_as 
FROM students WHERE 
	stay IS NOT NULL 
	AND inter_dom LIKE 'Dom'
GROUP BY stay ORDER BY stay DESC;

-- Comparing Averages
SELECT
    COUNT(CASE WHEN inter_dom = 'Inter' THEN 1 END) AS count_inter,
    COUNT(CASE WHEN inter_dom = 'Dom' THEN 1 END) AS count_dom,
    ROUND(AVG(CASE WHEN inter_dom = 'Inter' THEN todep END)::numeric, 2) AS avg_phq_inter,
    ROUND(AVG(CASE WHEN inter_dom = 'Dom' THEN todep END)::numeric, 2) AS avg_phq_dom
FROM students
	WHERE stay IS NOT NULL
    AND inter_dom IS NOT NULL;

-- Comparing Higher Values
SELECT 
	COUNT(CASE WHEN inter_dom = 'Inter' THEN 1 END) AS inter_instances,
	COUNT(CASE WHEN inter_dom = 'Dom' THEN 1 END) AS dom_instances
FROM students
	WHERE STAY IS NOT NULL
	AND inter_dom IS NOT NULL
	AND todep::numeric>=10;