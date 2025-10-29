WITH demand_counts AS (
    SELECT skill.skill_id,
        skill.skills,
        COUNT(dim.job_id) AS demand_count
    FROM job_postings_fact fact
        INNER JOIN skills_job_dim dim ON fact.job_id = dim.job_id
        INNER JOIN skills_dim skill ON skill.skill_id = dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY skill.skill_id
    ORDER BY demand_count DESC
),
avg_salary_skills AS (
    SELECT skill.skill_id,
        ROUND(AVG(fact.salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact fact
        INNER JOIN skills_job_dim dim ON fact.job_id = dim.job_id
        INNER JOIN skills_dim skill ON skill.skill_id = dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skill.skill_id
    ORDER BY avg_salary DESC
)
SELECT demand_counts.skills,
    demand_count,
    avg_salary
FROM demand_counts
    INNER JOIN avg_salary_skills ON demand_counts.skill_id = avg_salary_skills.skill_id
WHERE demand_count > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25