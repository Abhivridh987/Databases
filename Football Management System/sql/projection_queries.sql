-- Display the names and shirt numbers of 
-- all players who started their career after 2010.

select player_id, player_start_year from Player
where player_start_year > 2010;

-- Show all team names and cities where the city is
-- London, Madrid, or Manchester, ordered alphabetically by city.

select * from Team
where team_city in ('London', 'Madrid', 'Manchester')
order by team_name asc;

-- Display match IDs, dates, and total goals of matches where
-- the host team won by at least 2 goals.

select match_id, match_date, host_score, guest_score from Match
where host_score > guest_score and host_score >= 2;

-- Show player names and birth years of players born in February
-- or July .

select player_id, player_name, extract(year from player_dob) as year
from Player 
where extract(month from player_dob) in (2,7);

-- Display team names whose stadium name contains the word Stadium
-- or ends with Bridge.

select team_id , team_main_stadium from Team 
where team_main_stadium like '%Stadium%' or team_main_stadium like '%Bridge';


-- Show player names who have received yellow cards but never
-- received a red card in any match.

select * from Player p where exists(
  select 1 from Player_Accounts a
  where p.player_id = a.player_id and 
  a.no_of_yellow_cards > 0 and
  a.no_of_red_cards = 0
);

-- Show players and their total goals in their 
-- entire career

select player_id, sum(goals) from Player_Accounts
group by player_id;

-- Show all the players in 
-- Team Liverpool

select * from Player p
where exists(
  select 1 from Player_Team t
  where p.player_id = t.player_id and 
  t.to_date is NULL
  and exists(
    select 1 from Team s
    where s.team_id = t.team_id
    and s.team_name = 'Liverpool'
  )
);

-- Show player IDs whose total goals 
-- scored are more than 3

select player_id, sum(goals) as total_goals from Player_Accounts
group by player_id having sum(goals) > 3 order by total_goals desc;


-- Show referee IDs who handled more than 3 matches
-- as main referee using GROUP BY and HAVING.

select main_referee_id , count(main_referee_id) as total_matches from Match_Referee
group by (main_referee_id) having count(main_referee_id) > 3;


-- Display player names
-- and goals

select p.player_name, sum(g.goals)
from Player p join Player_Accounts g
on p.player_id = g.player_id group by p.player_name;


-- Display all players and their tcurrent team names and shirt number

select p.player_name, p.player_shirt_no , tt.team_id 
from Player p join (
  select distinct on (player_id) * from Player_Team t 
  order by t.player_id asc, t.to_date desc nulls first
) tt on p.player_id = tt.player_id; 

-- display top 5 goal scorers

select p.player_id, p.player_name, sum(a.goals) from 
Player p join Player_Accounts a on p.player_id = a.player_id
group by p.player_id, p.player_name order by sum(a.goals) desc limit 5;

-- display the team stadiums where the team Stadium name contains 'Arena'
select * from Team where team_main_stadium ilike '%Arena';

-- DISPlay names of players and their goals who scored more goals than Messi

select p.player_id, p.player_name, sum(a.goals) 
from Player p join Player_Accounts a on p.player_id = a.player_id
group by p.player_id, p.player_name having sum(goals) > (
  select sum(goals) from Player_Accounts aa
  where aa.player_id in (
    select pp.player_id from Player pp where pp.player_name = 'Lionel Messi'
  ) group by aa.player_id 
) order by sum(a.goals) desc;

-- Display the player with top goals in each Match
select distinct on (m.match_id) m.match_id, p.player_id, pp.player_name, p.goals from 
Match m join Player_Accounts p on m.match_id = p.match_id join Player pp on p.player_id = pp.player_id
order by m.match_id asc, p.goals desc;
