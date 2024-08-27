/*
Practice Problem 1:
-------------------
Identify the top 5 skills that are most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the highest count in the skills_job_dim table
and then join this result with the skills_dim table to get the skill names.
*/
WITH top_5_skills AS (
    SELECT 
    skill_id,
    COUNT(*) AS job_postings
FROM    
    skills_job_dim 
GROUP BY
    skill_id
LIMIT
    5
)

SELECT 
    skills.skills,
    top_5_skills.job_postings
FROM top_5_skills
LEFT JOIN skills_dim AS skills ON skills.skill_id = top_5_skills.skill_id
ORDER BY
    job_postings DESC


/* 
Practice Problem 2:
-------------------
Determine the size category ("Small", "Medium", or "Large") for each company by first identifying 
the number of job postings they have. Use a subqeury to calculate the total job postings per
company. A company is considered "Small" if it has less than 10 job postings. "Medium" if the
number job postings is between 10 and 50, and "Large" if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company before classifying them based on size.
*/

-- WITH total_job_postings AS (
--     SELECT
--         job_id,
--         company_id,
--         COUNT(job_id) AS job_postings
--     FROM
--         job_postings_fact 
--     GROUP BY
--         job_id
-- )

-- SELECT
--     companies.name,
--     CASE
--         WHEN total_job_postings.job_postings <= 10 THEN 'Small'
--         WHEN total_job_postings.job_postings >= 50 THEN 'Medium'
--         WHEN total_job_postings.job_postings > 50 THEN 'Large'
--     END AS job_size
-- FROM total_job_postings
-- LEFT JOIN company_dim AS companies ON total_job_postings.company_id = companies.company_id
-- ORDER BY
--     job_postings ASC


WITH total_job_openings AS (
    SELECT
        companies.name,
        job_postings_fact.job_id AS job_openings
    FROM
        company_dim AS companies
    LEFT JOIN
        job_postings_fact ON companies.company_id = job_postings_fact.company_id
)

SELECT
    CASE
        WHEN COUNT(total_job_openings.job_openings) < 10 THEN 'Small'
        WHEN COUNT(total_job_openings.job_openings) <= 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM 
    total_job_openings
GROUP BY
    total_job_openings.job_openings
ORDER BY
     total_job_openings.job_openings DESC