SELECT skills,
    COUNT(dim.job_id) AS demand_count
FROM job_postings_fact fact
    INNER JOIN skills_job_dim dim ON fact.job_id = dim.job_id
    INNER JOIN skills_dim skill ON skill.skill_id = dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY COUNT(dim.job_id) DESC
LIMIT 5;