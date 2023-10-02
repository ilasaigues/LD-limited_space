extends Node
class_name CharacterInstance
@export var base_data:CharacterData
@export var item_slot:UsableItemSlot

var hp:int

func is_alive():
	return hp>0

func _ready():
	$char_sprite.texture = base_data.texture
	hp = base_data.maxHP
	if item_slot:
		item_slot.SetCharacterData(base_data)

func TakeDamage(damage:int):
	hp-=damage
	UpdateHealthDisplay()
	
func UpdateHealthDisplay():
	$hp.value =hp as float / base_data.maxHP


