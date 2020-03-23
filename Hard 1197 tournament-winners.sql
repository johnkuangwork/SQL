
-- Process
--1. We firstly find out the first_player and the Second Player score
--2. Union the two above
--3. Sum up the total score by player_id
--4. Rank the total score by DESC and player_id by ASC

select
	Z.group_id,
	Z.player as player_id
from
	(select
		Y.player,
		Y.totalscore,
		P.group_id,
		RANK() over (partition by group_id order by totalscore DESC,player ASC) as rankscore
	from
		(select
		X.player,sum(score) as totalscore
		from
				(select
					first_player as player,
					sum(first_score) as score
				from Matches
				group by first_player
			union all
				select
					second_player as player,
					sum(second_score) as score
				from Matches
				group by second_player) X
		group by X.player) Y 
		join Players P on Y.player=P.player_id) Z
where Z.rankscore=1