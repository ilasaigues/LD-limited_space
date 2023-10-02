extends Node
@onready var BGM = $BGM
@onready var FSX = $SFX

# Called when the node enters the scene tree for the first time.
func _ready():
	BGM.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
