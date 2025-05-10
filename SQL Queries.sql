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

-- Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
-- Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.
SELECT sender_id,
count(message_id) as message_count
FROM messages
where EXTRACT(MONTH from sent_date) = '8'
 AND EXTRACT(YEAR from sent_date) = '2022'
 group by sender_id
 order by message_count DESC
 limit 2

-- Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

-- Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. 
--Output the city name and the corresponding number of completed trade orders.
SELECT u.city,
count(order_id) as total_orders
FROM trades
INNER join users u on trades.user_id = u.user_id
where trades.status = 'Completed'
group by u.city
order by total_orders DESC
limit 3;

-- Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. 
-- The output should display the month as a numerical value, product ID, 
-- and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.
SELECT EXTRACT(MONTH from submit_date) as mth, 
product_id, 
round(avg(stars),2) as avg_stars 
FROM reviews
GROUP by EXTRACT(MONTH from submit_date), product_id
order by mth, product_id;

-- Companies often perform salary analyses to ensure fair compensation practices. 
-- One useful analysis is to check if there are any employees earning more than their direct managers.
-- As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.
SELECT 
e.employee_id as employee_id, 
e.name as employee_name
FROM employee  as mng
inner join employee as e
on mng.employee_id = e.manager_id
where e.salary > mng.salary
;
