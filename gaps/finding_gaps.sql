/*
Problem: in a table you have a sequence of numbers but few of the numbers are missing. 
		 how will you identify them? There could be dupes in the sequence as well but we can take the distinct first.

Reference: T-SQL querying from Itzik Ben-Gan et. al.
*/

/*data prepration*/

--drop table NumSeqDups
create table NumSeqDups (seqval int)
insert into NumSeqDups (seqval) values (1),(2),(2),(3),(11)
--in above table, we can notice that there is a gap from 4 to 10 and we need to identify it.

/*Approach 1: Using Ranking functions row_number()*/

;WITH cte_distinct
AS (
	SELECT DISTINCT *
	FROM NumSeqDups
	)
	,cte_rownum
AS (
	SELECT seqval
		,row_number() OVER (
			ORDER BY seqval
			) AS rownum
	FROM cte_distinct
	)
SELECT 
	cur.seqval + 1 AS start_range
	,nxt.seqval - 1 AS end_range
FROM cte_rownum AS cur
INNER JOIN cte_rownum AS nxt ON nxt.rownum = cur.rownum + 1
WHERE nxt.seqval - cur.seqval > 1