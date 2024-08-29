/* 
Question: What are the most in-demand skills for data analyst?
- Join job postings to inner join table similary to query 2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings
- Why? Retreives the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers
*/


SELECT 
    skills.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    job_location
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim AS skills ON skills_job_dim.skill_id = skills.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_location = 'Boston, MA' OR 
    job_postings_fact.search_location = 'Spain'
GROUP BY
    skills.skills, job_location
ORDER BY
    demand_count DESC
LIMIT 50