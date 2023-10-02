extends Node
class_name TurnManager

@export var grid:GridManager
@export var player_team:Array[CharacterInstance]
@export var enemy_team:Array[CharacterInstance]

func next_turn():
	grid.next_turn()
