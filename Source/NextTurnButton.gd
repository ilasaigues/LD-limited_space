extends TextureButton
class_name NextTurnButton

@export var turn_manager:TurnManager

func _pressed():
	turn_manager.next_turn()
