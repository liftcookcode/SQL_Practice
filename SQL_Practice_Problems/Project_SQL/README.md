 ## Disclaimer
 🚨 All credit goes to Luke Barousse and Kelly Adams 🚨
 
 I had a good foundation with SQL before taking this course. The areas I struggled with, I now feel comfortable. 
 
 I highly recommned this course -> [Course Link](https://www.youtube.com/watch?v=7mz73uXD9DA)
 ## Introduction
 📊 Dive into the data job market! Focusing on data analyst roles,
 this project exlores 💰 top-paying jobs, 🔥 in-demand skills, and
 📈 where high demand meets high salary in data analytics.

 🔍 SQL queries? Check them out here: [Project_SQL Folder](/SQL_Practice_Problems/Project_SQL/)
## Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born
from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst roles?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data anlaysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
## Tools I Used
- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: Mt go-to for database management and executing SQL queries.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
## The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Roles
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying oppertunities in the field.
```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    companies.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim AS companies ON job_postings_fact.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
### 2. Skills Required for Top-Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
     SELECT
        job_id,
        job_title,
        salary_year_avg,
        companies.name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim AS companies ON job_postings_fact.company_id = companies.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim AS skills ON skills_job_dim.skill_id = skills.skill_id
ORDER BY
    salary_year_avg DESC
```
### 3. Top In-Demand Skills for Data Anayst Roles
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
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
```
| Skills | Demand Count|
|--------|-------------|
| SQL    |    7291     |
| Excel  |    4611     |
| Python |    4330     |
| Tableau|    3745     |
|Power Bi|    2609     |
*Table of the demand for the top 5 skills in data analyst job postings*
### 4. Top Skills Based on Salary
Exploring the average salaries associated with different skills revealed which are the highest paying.
```sql
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
```
| Skills | Average Salary($)|
|--------|------------------|
| pyspark    |    208,172       |
| bitbucket  |    189,172       |
| couchbase |    160,515       |
| watson|      160,515     |
|datarobot|   155,486        |
|gitlab|   154,500          |
| swift |    153,750       |
| jupyter|      152,777    |
|pandas|   151,821        |
|elasticsearch|  145,000     |
*Table of the average salary for the top 10 paying skills for data analysts*
### 5. The Optimal Skills to Learn (Highest Paid and Demand)
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
 Skill ID | Skills | Demand Count | Average Salary($)| 
|--------|---------|--------------|------------------|
| 8|   go  | 27 | 115,320|
| 234 |  confluence| 11 | 114,210|
| 97|  hadoop        | 22 | 113,193|
| 80|   snowflake       | 37 | 112,948|
|74|    azure      | 34 | 111,225|
|77|   bigquery         | 13 | 109,654|
| 76|  aws        | 32 | 108,317|
| 4|   java      | 17 | 106,906|
|194|   ssis       | 12 | 106,683|
|233|  jira    | 20 | 104,918|
*Table of the most optimal skills for data analyst sorted by salary*
## What I Learned
Here's the 3 Biggest Takeaways:
 1. Enhnaced my preivous knowledge of SQL, as well as learned some great new skills like: CTE's, Subqueries, and becoming comfortable with the different tpyes of JOINS
 2. Learned how to build out a database from scratch. Very fun and enjoyable from the typical manner of using 'pre-built' database.
 3. Picked up a few helpful skills regarding git/github.
## Concluding Thoughts
Overall, this course was excellent. Being only a quick 4 hours, this course taught me a lot and I'm exited to keep building my skills within SQL and databases. 

Again big speical thanks to Luke Barousse and Kelly Adams for an amazing course!