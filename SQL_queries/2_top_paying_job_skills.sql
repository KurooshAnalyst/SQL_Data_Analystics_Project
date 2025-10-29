WITH top_paying_skills AS (
    SELECT job_id,
        job_title,
        com.name AS company_name,
        salary_year_avg
    FROM job_postings_fact fact
        LEFT JOIN company_dim com ON fact.company_id = com.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_skills.*,
    skills
FROM top_paying_skills
    INNER JOIN skills_job_dim ON top_paying_skills.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC