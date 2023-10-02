extends Node
class_name TurnManager

@export var grid:GridManager
@export var player_team:Array[CharacterInstance]
@export var enemy_team:Array[CharacterInstance]

func next_turn():
	grid.next_turn()
	do_combat()


func do_combat():
	attack_team(player_team,enemy_team)
	attack_team(enemy_team,player_team)
		

func attack_team(team_a:Array[CharacterInstance], team_b:Array[CharacterInstance]):
	for i in 3:
		if !team_a[i].is_alive():continue
		if team_b[i].is_alive():
			team_b[i].TakeDamage(1)
