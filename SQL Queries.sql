-- Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.  

select candidate_id 
from Candidates 
where skill in ('Python','Tableau', 'PostgreSQL') 
group by candidate_id
having count(distinct skill) = 3
order by candidate_id;

-- Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

-- Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.
-- Pages     |      Page_likes
-- page_id   |      user_id
-- Page_name |      page_id
--           |      date
SELECT pages.page_id
FROM pages
LEFT OUTER JOIN page_likes pl 
  ON pages.page_id = pl.page_id
WHERE pl.page_id IS NULL;

-- Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.

-- Assumptions:

-- parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
-- An unfinished part is one that lacks a finish_date.
-- This question is straightforward, so let's approach it with simplicity in both thinking and solution.
-- parts_assembly
-- part
-- finis_date
-- assembly_step
SELECT part, assembly_step 
FROM parts_assembly
WHERE finish_date is NULL

-- Given a table of Facebook posts, for each user who posted at least twice in 2021, 
  -- write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
  -- Output the user and number of the days between each user's first and last post.


--- posts Table:
-- Column Name	Type
-- user_id	integer
-- post_id	integer
-- post_content	text
-- post_date	timestamp

SELECT user_id,
max(post_date::DATE) - min(post_date::DATE) as days_between
FROM posts
where DATE_PART('year', post_date::DATE) = 2021
group by user_id
having count(post_id) >1
