extends Node
class_name CharacterInstance
@export var base_data:CharacterData

var hp:int

func _ready():
	$char_sprite.texture = base_data.texture
	hp = base_data.maxHP

func TakeDamage(damage:int):
	hp-=damage
	UpdateHealthDisplay()
	
func UpdateHealthDisplay():
	$hp.value =hp as float / base_data.maxHP


