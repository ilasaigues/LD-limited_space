extends AnimationPlayer
enum Types {none, melee, range, magic}
@export var type: Types
@export var element: GameRules.ElementType

var type_dictionary = {1: "melee", 2: "range", 3: "magic"}
var element_dictionary = {2: "ice", 1: "fire", 4: "poison"}

# Called when the node enters the scene tree for the first time.
func _ready():
	if(element == 0 || type == 0):
		current_animation = "default_attack"
	else:
		current_animation = (type_dictionary[type] + "_" + element_dictionary[element])
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
