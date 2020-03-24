
-- Process
--1. Rank grade by DESC and Course_id ASC
--2. select from the rankgrade = 1 for each student

select
	X.student_id,X.course_id,X.grade
from
	(select 
	student_id,
	course_id,
	grade,
	rank() over (partition by student_id order by grade DESC,course_id ASC) as rankgrade 
from 
Enrollments) X
where X.rankgrade=1
