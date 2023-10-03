extends Node
class_name CharacterInstance
@export var base_data:CharacterData
@export var item_slot:UsableItemSlot

var hp:int

func is_alive():
	return hp>0

var is_animating:bool = false

func _ready():
	#$char_sprite.texture = base_data.texture
	if base_data.animationName != "":
		$AnimationTree.active = true
		SetAnimatorCondition(base_data.animationName, true)
	if base_data.element != GameRules.ElementType.None:
		var elementalid = ""
		match base_data.element:
			GameRules.ElementType.Fire:
				elementalid=str( "fire_orc")
			GameRules.ElementType.Ice:
				elementalid=str( "ice_orc")
			GameRules.ElementType.Acid:
				elementalid=str( "poison_orc")
		SetAnimatorCondition(elementalid, true)
	hp = base_data.maxHP
	if item_slot:
		item_slot.SetCharacterData(base_data)

func TakeDamage(damage:int):
	hp-=damage
	UpdateHealthDisplay()
	if hp <= 0:
			SetAnimatorCondition("death", true)
	
func UpdateHealthDisplay():
	$hp.value =hp as float / base_data.maxHP

func SetAnimatorCondition(condition:String,value:bool):
	$AnimationTree["parameters/conditions/"+condition]=value

func attack(target:CharacterInstance):
	var attackElement = GameRules.ElementType.None
	SetAnimatorCondition("attack", true)
	is_animating=true
	target.SetAnimatorCondition("damage", true)	
	var damage = 1
	if item_slot && item_slot.storedItem:
		var storedItem = item_slot.storedItem
		attackElement = storedItem.property
		if storedItem.property == GameRules.ElementType.None:
			damage += 1
		else:
			damage += CalculateElementalRPS(storedItem.property,target.base_data.element)
		item_slot.consume_item()
	if damage > 0:
		target.TakeDamage(damage)
	else:
		target.TakeDamage(1)
		TakeDamage(1)
	var vfx = base_data.vfxDictionary[attackElement].instantiate()
	target.add_child(vfx)
	vfx.global_position = target.global_position + target.get_rect().size/3
	await get_tree().process_frame
	await get_tree().process_frame
	SetAnimatorCondition("attack", false)
	target.SetAnimatorCondition("damage", false)
	
func CalculateElementalRPS(attack:GameRules.ElementType, defender:GameRules.ElementType):
	if attack == defender: return 0
	match attack:
		GameRules.ElementType.Fire:
			if defender == GameRules.ElementType.Ice: return 1
			else: return -10
		GameRules.ElementType.Ice:
			if defender == GameRules.ElementType.Acid: return 1
			else: return -10
			pass
		GameRules.ElementType.Acid:
			if defender == GameRules.ElementType.Fire: return 1
			else: return -10
			pass
	
func _on_animation_finished(anim_name):
	is_animating=false
