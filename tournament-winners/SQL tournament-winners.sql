
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