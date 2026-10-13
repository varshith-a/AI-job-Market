create database job_market;
use job_market;
create table location(
location_id int primary key, 
location_name varchar(65) not null,
work_mode varchar(100) not null,
city varchar(65) default 'Benguluru'
);
create table company(
company_id int primary key,
company_name varchar(67),
rating varchar(68) not null,
reviwe_count varchar(67) not null
);
create table job_category(
category_id int primary key,
category_name varchar(65) not null,
is_ai_related varchar(65) not null
);
create table skill(
skill_id int primary key,
skill_name varchar(65) not null,
skill_category varchar(65) not null
);
create table job_posting (
job_id int primary key,
job_title varchar(67) not null,
experience_level varchar(65) not null,
days_since_posted date,
min_experience int,
max_experience int,
salary_min decimal(10,2),
salary_max decimal(10,2),
company_id int,
category_id int,
location_id int,
foreign key(company_id)  REFERENCES company(company_id),
foreign key(category_id) references job_category(category_id),
foreign key(location_id) references location(location_id)
);
CREATE TABLE job_skill (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES job_posting(job_id),
    FOREIGN KEY (skill_id) REFERENCES skill(skill_id)
);
select * from location;
select * from company;
select * from job_category;
select * from job_posting;
DESCRIBE job_posting;
describe  job_skill;
alter table job_skill
modify job_id bigint;
ALTER TABLE job_posting
MODIFY job_id BIGINT;
DESCRIBE location;
use job_market;
alter table location drop column location_name;
alter table location alter column city drop default;
ALTER TABLE job_skill
DROP FOREIGN KEY job_skill_ibfk_1;
ALTER TABLE job_posting
MODIFY job_id BIGINT;
ALTER TABLE job_skill
MODIFY job_id BIGINT;
ALTER TABLE job_skill
ADD CONSTRAINT job_skill_ibfk_1
FOREIGN KEY (job_id)
REFERENCES job_posting(job_id);
DESCRIBE job_posting;
describe  job_skill;
SHOW CREATE TABLE job_skill;
select * from skill;
ALTER TABLE job_posting
MODIFY days_since_posted INT;
describe job_posting;
DROP TABLE IF EXISTS job_skill;
DROP TABLE IF EXISTS job_posting;

CREATE TABLE job_posting (
    job_id BIGINT,                                
    job_title VARCHAR(255) NOT NULL,
    experience_level VARCHAR(65) NOT NULL,
    days_since_posted INT,
    salary_min VARCHAR(65),                       
    salary_max VARCHAR(65),                       
    min_experience INT,
    max_experience INT,
    company_id INT,                               
    category_id INT,                              
    location_id INT,                              
    FOREIGN KEY(company_id) REFERENCES company(company_id),
    FOREIGN KEY(category_id) REFERENCES job_category(category_id),
    FOREIGN KEY(location_id) REFERENCES location(location_id)
);

CREATE TABLE job_skill (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id BIGINT NOT NULL,
    skill_id INT NOT NULL,
    FOREIGN KEY (skill_id) REFERENCES skill(skill_id)
);
-- 1. Temporarily turn off check constraints so everything loads smoothly
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE job_posting;

-- 2. Bulk load the copied file straight into your columns
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\job_posting.csv'
INTO TABLE job_posting
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  
IGNORE 1 LINES
(job_id, job_title, experience_level, days_since_posted, salary_min, salary_max, min_experience, max_experience, company_id, category_id, location_id);

-- 3. Turn the safety locks back on
SET FOREIGN_KEY_CHECKS = 1;
-- 1. Turn off constraint checks temporarily so it loads instantly without errors
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE job_skill;

-- 2. Bulk load your job_skill mapping file straight into your columns
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\job_skill.csv'
INTO TABLE job_skill
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  
IGNORE 1 LINES
(job_id, skill_id);

-- 3. Turn the relational safety locks back on
SET FOREIGN_KEY_CHECKS = 1;
select * from job_posting;
select * from  job_skill;
SELECT COUNT(*) FROM job_posting;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE job_skill;

-- Adjusted load command that accepts standard Unix line breaks (\n)
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\job_skill.csv'
INTO TABLE job_skill
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- Changed to universal line breaks
IGNORE 1 LINES
(job_id, skill_id);

SET FOREIGN_KEY_CHECKS = 1;
SELECT COUNT(*) FROM job_skill;
select * from job_skill;
select 'location' t, count(*) n from location
union all select 'company', count(*) from company
union all select 'job_category', count(*) from job_category
union all select 'skill', count(*) from skill
union all select 'job_posting', count(*) from job_posting
union all select 'job_skill', count(*) from job_skill;
use job_market;


select count(*) from location;
select count(*) from company;
select count(*) from job_category;
select count(*) from skill;
select count(*) from job_posting;
select count(*) from job_skill;

-- 2. Every job must have a matching company (expected: 0)
select count(*) from job_posting j
left join company c on j.company_id = c.company_id
where c.company_id is null;
select count(*) from company;

select j.job_id, j.company_id
from job_posting j
left join company c on j.company_id = c.company_id
where c.company_id is null;
use job_market;

alter table company modify company_name varchar(150) not null;

insert into company (company_id, company_name, rating, reviews_count)
values (5437602,
        'DigiSME Software Pvt Ltd (Wholly Owned Subsidiary of Info-Tech Systems Integrators, Singapore)',
        4.0, 69);
use job_market;

alter table company rename column reviwe_count to reviews_count;
alter table company change reviwe_count reviews_count varchar(67) not null;
use job_market;
describe company;
select count(*) from company;

select count(*) from job_posting j
left join company c on j.company_id = c.company_id
where c.company_id is null;
#-- Q1. How many jobs are there in each category?
select * from job_posting;
select * from job_category;
select count(*)  as num_job,j.category_name as category
from job_category as j
left join job_posting as j1
on j.category_id =  j1.category_id
group by j.category_name
order by num_job desc;

select l.city, count(*) as total_jobs
from job_posting j
join location l 
on j.location_id = l.location_id
group by l.city
order by total_jobs desc
limit 10;
# Q2. Which 10 cities have the most data/AI jobs?
select l.city, count(*) as ai_jobs
from job_posting j
join location l 
on j.location_id = l.location_id
join job_category c
 on j.category_id = c.category_id
where c.category_name in ('AI / ML Engineer', 'Data Scientist')
group by l.city
order by ai_jobs desc
limit 10;
#
-- Q3. Top 15 most demanded skills
select * from job_posting;
select* from skill;
select * from job_skill;
select * from job_category;
select s.skill_name, count(*) as jobs_needing_skill
from job_skill js
join skill s on js.skill_id = s.skill_id
group by s.skill_name
order by jobs_needing_skill desc
limit 15;
-- Q4. Top 10 skills for Data Analyst jobs
select  * from job_skill;
select s.skill_name, count(*) as jobs_needing_skill
from job_posting j
join job_category c 
on j.category_id = c.category_id
join job_skill js 
on j.job_id = js.job_id
join skill s
 on js.skill_id = s.skill_id
where c.category_name = 'Data Analyst'
group by s.skill_name
order by jobs_needing_skill desc
limit 10;
-- Q5. Average salary by category (only jobs that show salary)
select * from job_posting;
select* from skill;
select * from job_skill;
select * from job_category;
select jc.category_name,count(*) as job_with_salary, round(avg(jp.salary_min) + avg(jp.salary_max) / 2) as avg_salary
from  job_category as jc
join job_posting as jp 
on jc.category_id = jp.category_id
group by jc.category_name
order by avg_salary desc;
#-- Q6. Average salary by experience level
select * from job_posting;
select* from skill;
select * from job_skill;
select * from job_category;
select experience_level,
       count(*) as jobs_with_salary,
       round(avg((salary_min + salary_max) / 2)) as avg_salary
from job_posting
where salary_min is not null
group by experience_level
order by avg_salary;
#-- Q6. maxsalary by experience level-- 
select experience_level,
       count(*) as jobs_with_salary,
max(salary_max) as max_salary
from job_posting
where salary_min is not null
group by experience_level
order by max_salary ;
#
-- Q7. Top 10 companies hiring the most
select * from job_posting;
select* from skill;
select * from job_skill;
select * from job_category;
select * from company;
select * from location;
select co.company_name, l.city, count(*) as open_jobs
from job_posting j
join company co on j.company_id = co.company_id
join location as l 
on l.location_id = j.location_id
group by co.company_name,l.city
order by open_jobs desc
limit 15;
select l.work_mode,
       count(*) as total_jobs,
       round(count(*) * 100.0 / (select count(*) from job_posting), 1) as percent_of_jobs
from job_posting j
join location l on j.location_id = l.location_id
group by l.work_mode;
-- Q9. Bengaluru vs Hyderabad vs Pune: jobs by category
select c.category_name,
       sum(l.city = 'Bengaluru') as bengaluru,
       sum(l.city = 'Hyderabad') as hyderabad,
       sum(l.city = 'Pune')      as pune
from job_posting j
join job_category c on j.category_id = c.category_id
join location l on j.location_id = l.location_id
group by c.category_name;
#
-- Q10. Entry-level (fresher) Data Analyst jobs in Bengaluru
select j.job_title, co.company_name, j.min_experience, j.max_experience
from job_posting j
join company co on j.company_id = co.company_id
join job_category c on j.category_id = c.category_id
join location l on j.location_id = l.location_id
where c.category_name = 'Data Analyst'
  and l.city = 'Bengaluru'
 and j.experience_level like 'Entry%'
order by co.company_name;
#-- Q11. Top 5 skills in each category (CTE + window function RANK)
with skill_counts as (
    select c.category_name, s.skill_name, count(*) as demand
    from job_posting j
    join job_category c on j.category_id = c.category_id
    join job_skill js on j.job_id = js.job_id
    join skill s on js.skill_id = s.skill_id
    group by c.category_name, s.skill_name
),
ranked as (
    select category_name, skill_name, demand,
          dense_rank() over (partition by category_name order by demand desc) as rnk
    from skill_counts
)
select category_name, rnk, skill_name, demand
from ranked
where rnk <= 5
order by category_name, rnk;
#-- Q12. Companies with rating above 4 and more than 5 open jobs
select co.company_name, co.rating, l.city,count(*) as open_jobs
from job_posting j
join company co on j.company_id = co.company_id
join location as l
on l.location_id = j.location_id
where co.rating > 4
group by co.company_name, co.rating,l.city
having count(*) > 5
order by open_jobs desc;
select * from company;
#-- Procedure 1: top skills for any category
delimiter //
create procedure top_skills_by_category(in p_category varchar(65), in p_limit int)
begin
    select s.skill_name, count(*) as jobs_needing_skill
    from job_posting j
    join job_category c on j.category_id = c.category_id
    join job_skill js on j.job_id = js.job_id
    join skill s on js.skill_id = s.skill_id
    where c.category_name = p_category
    group by s.skill_name
    order by jobs_needing_skill desc
    limit p_limit;
end //
delimiter ;
call top_skills_by_category('AI / ML Engineer', 10);
-- Procedure 2: jobs in one city for one category
drop procedure if exists jobs_by_city_category;
delimiter //
create procedure jobs_by_city_category(in p_city varchar(65), in p_category varchar(65))
begin
    select j.job_title, co.company_name, j.experience_level,
           j.salary_min, j.salary_max
    from job_posting j
    join company co on j.company_id = co.company_id
    join job_category c on j.category_id = c.category_id
    join location l on j.location_id = l.location_id
    where l.city = p_city
      and c.category_name = p_category
    order by co.company_name;
end //
delimiter ;
call jobs_by_city_category('Bengaluru', 'Data Analyst');
-- Procedure 3: salary summary by experience level for one category
drop procedure if exists salary_by_experience;
delimiter //
create procedure salary_by_experience(in p_category varchar(65))
begin
    select j.experience_level,
           count(*) as jobs_with_salary,
           round(avg((j.salary_min + j.salary_max) / 2)) as avg_salary
    from job_posting j
    join job_category c on j.category_id = c.category_id
    where c.category_name = p_category
      and j.salary_min is not null
    group by j.experience_level
    order by avg_salary;
end //
delimiter ;
call salary_by_experience('Data Scientist');

