/*
Problem: in a table you have a sequence of dates but few of the dates are missing. 
		 how will you identify the missing date range?

Reference: T-SQL querying from Itzik Ben-Gan et. al.
*/

/*data prepration*/
--drop table dateseq
create table dateseq (date_seq date)
insert into dateseq (date_seq) values (convert(date,getdate()-10))--2020-12-15
insert into dateseq (date_seq) values (convert(date,getdate()-9))--2020-12-16
insert into dateseq (date_seq) values (convert(date,getdate()-8))--2020-12-17
insert into dateseq (date_seq) values (convert(date,getdate()))--2020-12-25

;with cte_distinct as (
select distinct date_seq from dateseq),
cte_rownum as (
select date_seq, row_number() over (order by date_seq asc) as rownum from cte_distinct
)

select 

	dateadd(day, 1, cur.date_seq) as start_range,
	dateadd(day, -1, nxt.date_seq) as end_range
from
	cte_rownum as cur
	inner join cte_rownum as nxt on cur.rownum+1 = nxt.rownum
where
	datediff(day,cur.date_seq,nxt.date_seq) > 1

--Note: this will give us ouptput as start_range = 2020-12-18 and end_range = 2020-12-24
	