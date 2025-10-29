SELECT skills,
    ROUND(AVG(fact.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact fact
    INNER JOIN skills_job_dim dim ON fact.job_id = dim.job_id
    INNER JOIN skills_dim skill ON skill.skill_id = dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;