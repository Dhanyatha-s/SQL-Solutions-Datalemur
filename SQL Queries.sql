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
