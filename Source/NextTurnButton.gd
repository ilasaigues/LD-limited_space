extends TextureButton

@export var grid:GridController

func _pressed():
	grid.next_turn()
