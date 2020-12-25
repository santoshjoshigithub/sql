/*
Problem: in a table you have a sequence of numbers but few of the numbers are missing and few are consecutive and thus forming an island.
		 how will you identify those island in your data set?

Reference: T-SQL querying from Itzik Ben-Gan et. al.
*/

/*data prepration*/
drop table NumSeqDups
create table NumSeqDups (seqval int)
insert into NumSeqDups (seqval) values (1),(2),(2),(3),(11),(12), (13)
--in above table, we can notice that there are 2 islands (first one from range 1 to 3, second one from 11 to 13)

/*Approach 1: Using Ranking functions dense_rank()*/
;WITH cte_ranking
AS (
	SELECT seqval, seqval-dense_rank() OVER (
			ORDER BY seqval
			) as grp
	FROM NumSeqDups
	)
SELECT 
	min(seqval) as start_range, max(seqval) as end_range
FROM
	cte_ranking
GROUP BY
	grp;