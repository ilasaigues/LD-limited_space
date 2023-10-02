extends Node
class_name TurnManager

@export var grid:GridManager
@export var player_team:Array[CharacterInstance]
@export var enemy_team:Array[CharacterInstance]

var locked:bool = false

func next_turn():
	if locked: return
	grid.next_turn()
	do_combat()


func do_combat():
	locked = true
	await attack_team(player_team,enemy_team)
	await attack_team(enemy_team,player_team)
	locked = false
		

func attack_team(team_a:Array[CharacterInstance], team_b:Array[CharacterInstance]):
	for i in 3:
		if !team_a[i].is_alive():continue
		var nextEnemyIndex= -1
		if team_b[i].is_alive():
			nextEnemyIndex = i
		else:
			match i:
				0:
					if team_b[1].is_alive(): nextEnemyIndex=1
					elif team_b[2].is_alive(): nextEnemyIndex=2
				1:
					if team_b[0].is_alive(): nextEnemyIndex=0
					elif team_b[2].is_alive(): nextEnemyIndex=2
				2:
					if team_b[1].is_alive(): nextEnemyIndex=1
					elif team_b[0].is_alive(): nextEnemyIndex=0
		if nextEnemyIndex >= 0:
			team_a[i].attack(team_b[nextEnemyIndex])
			while team_a[i].is_animating:
				await get_tree().process_frame
