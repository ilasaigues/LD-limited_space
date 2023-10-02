extends Node
class_name CharacterInstance
@export var base_data:CharacterData
@export var item_slot:UsableItemSlot

var hp:int

func is_alive():
	return hp>0

func _ready():
	#$char_sprite.texture = base_data.texture
	if base_data.animationName != "":
		$AnimationTree.active = true
		var id = "parameters/conditions/"+base_data.animationName
		$AnimationTree[id] = true
	if base_data.element != base_data.SPECIAL_PROPERTY.None:
		var elementalid = "parameters/conditions/"
		match base_data.element:
			base_data.SPECIAL_PROPERTY.Fire:
				elementalid+=str( "fire_orc")
			base_data.SPECIAL_PROPERTY.Ice:
				elementalid+=str( "ice_orc")
			base_data.SPECIAL_PROPERTY.Acid:
				elementalid+=str( "poison_orc")
		$AnimationTree[elementalid]=true
	hp = base_data.maxHP
	if item_slot:
		item_slot.SetCharacterData(base_data)

func TakeDamage(damage:int):
	hp-=damage
	UpdateHealthDisplay()
	
func UpdateHealthDisplay():
	$hp.value =hp as float / base_data.maxHP


