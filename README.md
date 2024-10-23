# MIST-4610-GP-1

Group Members: Brooks Hess, Edward Gainer, Reid Huels, Ryan Lochman, Ethan Hughes

Scenario Description: We are building a business database for a new, upcoming soccer league. The goal is to keep track of all information involving all aspects of the league.

![image](https://github.com/user-attachments/assets/918f0113-1cbc-4d56-96ad-bc1d0085f983)

Data Dictionary:

10 Queries:
-- Simple --> give player names with their agents contact information
SELECT p.player_name, a.agency, a.phone_number
	FROM player as p
	JOIN agent as a ON p.agent_license_number = a.license_number;


-- Simple --> Give the division name for all teams
SELECT t.city_name AS team_city, d.division_name
	FROM team as t
	JOIN division as d ON t.division_division_name = d.division_name;

-- Simple --> List all players with a salary greater than 1 million
SELECT player_name, salary
	FROM player
	WHERE salary > 1000000;

-- Simple --> List the name, salary, and sponsor name of all Midfielders

select player_name, salary, position, sponsor_sponsor_name AS 'Sponsor Name'
	from player
    join sponsor_has_player on player.player_name = sponsor_has_player.player_player_name
    where position = 'Midfielder';
    
-- Complicated --> List player names and team name for players who earn above $3000000 and are on a top 5 ranked team

select player_name, salary, city, division_name, region, `rank` AS 'Team Rank'
	from player
    join team on team.city = player.team_city
    join division on division.division_name = team.division_division_name
    where salary > 3000000
    AND team.rank <= 5;
    

-- Complicated --> List the owners, their net worth, and the city of teams who wear the color red

select owner_name, net_worth, city_name
	from owner
    join team on team.owner_owner_name = owner.owner_name
    where main_color regexp 'Red'
    GROUP BY owner_name, city_name, net_worth
    Order by net_worth DESC;
    
-- Complicated --> Give names of forwards and their sponsors that make over 2 million dollars a year
    select player.player_name, salary, sponsor_name
		from player, sponsor_has_player, sponsor
		where player.player_name = sponsor_has_player.player_player_name
		and sponsor_has_player.sponsor_sponsor_name = sponsor.sponsor_name
		and position = 'Forward'
		and salary > 2000000;

-- complicated --> Testing to see if Christiano Ronaldo's contract is more than two times the average of all forwards
select player_name, salary
	from player
    where player_name = 'Cristiano Ronaldo' and 
    ((select avg(salary) from player where position = "Forward" * 2.0) <
    (select salary from player where player_name = "Cristiano Ronaldo"));
    
-- complicated --> Returns player names, height, and their sponsors because people over 6 foot get more sponsorships
select player_name, height, sponsor_name
	from player, sponsor_has_player, sponsor
    where player.player_name = sponsor_has_player.player_player_name
    and sponsor_has_player.sponsor_sponsor_name = sponsor.sponsor_name
    and height > 185
    and exists (
		select *
			from sponsor_has_player
            where player.player_name = sponsor_has_player.player_player_name);
            
-- Complicated --> Return the teams with the highest overall salary in descending order, along with their owner

SELECT t.city_name AS Team, o.owner_name AS Owner, SUM(p.salary) AS Total_Salary
	FROM team as t
	JOIN player as p ON t.city = p.team_city
	JOIN owner as o ON t.owner_owner_name = o.owner_name
	GROUP BY t.city_name, o.owner_name
	ORDER BY Total_Salary DESC;
