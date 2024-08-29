/*
Question: What are the top skils based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    ROUND(AVG(salary_year_avg), 2) AS avg_salary,
    skills.skills
FROM
    job_postings_fact 
INNER JOIN skills_job_dim AS job_skills ON job_postings_fact.job_id = job_skills.job_id
INNER JOIN skills_dim AS skills ON job_skills.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY 
   skills.skills
ORDER BY
    avg_salary DESC
LIMIT 25