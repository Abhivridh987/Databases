create table Player (
player_id int primary key,
player_name text,
player_dob date,
player_start_year int,
player_shirt_no int
);

create table Team (
team_id int primary key,
team_name text,
team_main_stadium text,
team_city text
);

create table Match (
match_id int primary key,
host_team_id int,
guest_team_id int,
match_date date,
host_score int,
guest_score int
);

create table Referee(
referee_id int primary key,
referee_dob date,
referee_exp int
);

create table Substitutions (
match_id int,
player_id int,
sub_id int,
sub_time time
);

create table Player_Accounts(
player_id int,
match_id int,
goals int,
no_of_red_cards int,
no_of_yellow_cards int
);

create table Match_Referee(
match_id int,
main_referee_id int,
assis_referee_id_1 int,
assis_referee_id_2 int,
primary key(match_id)
);
