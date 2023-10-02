extends AnimationPlayer
enum Types {melee, range, magic, none}
@export var type: Types
enum Elements {ice, fire, poison, none}
@export var element: Elements

var type_dictionary = {0: "melee", 1: "range", 2: "magic"}
var element_dictionary = {0: "ice", 1: "fire", 2: "poison"}

# Called when the node enters the scene tree for the first time.
func _ready():
	if(element == 3 || type == 3):
		current_animation = "default_attack"
	else:
		current_animation = (type_dictionary[type] + "_" + element_dictionary[element])
	play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
