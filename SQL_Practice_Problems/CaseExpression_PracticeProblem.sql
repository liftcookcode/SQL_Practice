/* 
--------------------
Practice Problem 1
--------------------

I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
- Puts salary into different buckets
- Define what's a high, standard, or low salary with your own conditions
- Why? It is easy to determine which job postings are worth looking at based on salary. Bucketing is a commmon
practice in data analysis when viewing categories
- I only want to look at data roles
- Order from highest to lowest
*/

SELECT
    COUNT(job_id) AS job_postings,
    CASE
        WHEN salary_year_avg <= 75000 THEN 'Low'
        WHEN salary_year_avg <= 150000 THEN 'Standard'
        WHEN salary_year_avg > 200000 THEN 'High'
        ELSE 'to high'
    END AS job_salary
FROM
    job_postings_fact
WHERE
    job_title_short LIKE '%Data%'
GROUP BY
    job_salary