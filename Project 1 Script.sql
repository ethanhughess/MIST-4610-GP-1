use ha_group3;

select * from owner;
select * from sponsor;
select * from division;
select * from sponsor_has_player;
select * from team;
select * from player;
select * from agent;

-- List the name, salary, and sponsor name of all Quarterbacks

select player_name, salary, sponsor_name
	from player
    join sponsor_has_player on player.player_name = sponsor_has_player.Player_name
    where position = 'Quarterback';
    
-- List player names and team name for players who earn above $3000000 and are on a top 10 ranked team

select player_name, salary, team.name AS 'Team Name', division_name, division_region
	from player
    join team on team.city_name = player.city_name
    join division on division.division_name = team.division_division_name
    where salary > 3000000
    AND team.rank <= 10;
    
-- List all players names and their agents names for all Wide Recievers

select player_name, position, agency, phone_number, email
	from player
    join agent on agent.license_number = player.agent_license_number
    Where player.position = 'Wide Receiver'
    Order by player_name;
    
-- List the owners and their teams with the top 5 highest net worths

select owner_name, net_worth, city_name
	from owner
    join team on team.owner_owner_name = owner.owner_name
    GROUP BY owner_name, city_name, net_worth
    Having count(*) <= 3
    Order by net_worth DESC;
    


