-- Get jobs and companies from Janurary

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    janurary_jobs

UNION

-- Gets jobs and companies from Feburary
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    feburary_jobs

UNION

-- Gets jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs


-- PRACTICE PROBLEM
/*
- Get the corresponding skill and skill type for each job posting in q1
- Includes those without any skills, too
- Why? Look at the skills and the type for each job in the first quarter that has a salary > $70,000
*/

SELECT 
    janurary_jobs.job_id AS job_postings,
    skills_to_job.skill_id,
    skills.skills,
    janurary_jobs.job_posted_date
FROM 
    janurary_jobs
INNER JOIN skills_job_dim AS skills_to_job ON janurary_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    janurary_jobs.salary_year_avg > 70000

UNION ALL 

SELECT 
    feburary_jobs.job_id AS job_postings,
    skills_to_job.skill_id,
    skills.skills,
    feburary_jobs.job_posted_date
FROM 
    feburary_jobs
INNER JOIN skills_job_dim AS skills_to_job ON feburary_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    feburary_jobs.salary_year_avg > 70000

UNION ALL

SELECT 
    march_jobs.job_id AS job_postings,
    skills_to_job.skill_id,
    skills.skills,
    march_jobs.job_posted_date
FROM 
    march_jobs
INNER JOIN skills_job_dim AS skills_to_job ON march_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
    march_jobs.salary_year_avg > 70000