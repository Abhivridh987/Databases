alter table Match
add constraint fk_match_host_team_id
foreign key(host_team_id) references Team(team_id);

alter table Match
add constraint fk_match_guest_team_id
foreign key(guest_team_id) references Team(team_id);

alter table Substitutions
add constraint pk_Substitutions
primary key(match_id, player_id);

alter table Substitutions
add constraint fk_Substitutions_Match
foreign key(match_id) references Match(match_id);

alter table Substitutions
add constraint fk_Substitutions_Player_1
foreign key(player_id) references Player(player_id);

alter table Substitutions
add constraint fk_Substitutions_Player_2
foreign key(sub_id) references Player(player_id);

alter table Player_Accounts
add constraint fk_Player
foreign key(player_id) references Player(player_id);

alter table Player_Accounts
add constraint fk_Match
foreign key(match_id) references Match(match_id);

alter table Player_Accounts
add constraint pk_Player_Accounts
primary key(player_id, match_id);

alter table Match_Referee
add constraint fk_Match
foreign key(match_id) references Match(match_id);

alter table Match_Referee
add constraint fk_Referee_Main
foreign key(main_referee_id) references Referee(referee_id);

alter table Match_Referee
add constraint fk_Referee_Ass_1
foreign key(assis_referee_id_1) references Referee(referee_id);

alter table Match_Referee
add constraint fk_Referee_Ass_2
foreign key(assis_referee_id_2) references Referee(referee_id);
