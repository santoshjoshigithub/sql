/*
Problem: in a table you have a sequence of numbers but few of the numbers are missing and few are consecutive and thus forming an island.
		 how will you identify those island in your data set?

Reference: https://www.mssqltips.com/sqlservertutorial/9130/sql-server-window-functions-gaps-and-islands-problem/
*/

/*data prepration*/
drop table dateseq
create table dateseq (date_seq date)
insert into dateseq (date_seq) values (convert(date,getdate()-10))--2020-12-15
insert into dateseq (date_seq) values (convert(date,getdate()-9))--2020-12-16
insert into dateseq (date_seq) values (convert(date,getdate()-8))--2020-12-17
insert into dateseq (date_seq) values (convert(date,getdate()-3))--2020-12-22
insert into dateseq (date_seq) values (convert(date,getdate()-2))--2020-12-23
insert into dateseq (date_seq) values (convert(date,getdate()-1))--2020-12-24

--in above table, we can notice that there are 2 islands (first one from range 15 dec to 17 dec, second one from 22 to 24)

/*Approach 1: Using Ranking functions dense_rank()*/
;WITH cte_ranking
AS (
	SELECT 
		date_seq, 
		dateadd(day, -1 * dense_rank() over (order by date_seq),date_seq) as grp
	FROM dateseq
	)
SELECT 
	min(date_seq) as start_range, max(date_seq) as end_range
FROM
	cte_ranking
GROUP BY
	grp;