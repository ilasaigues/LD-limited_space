extends Resource
class_name ItemData
enum ITEM_TYPE {Weapon, Consumable, Quest}
enum SPECIAL_PROPERTY {Fire, Ice, Acid, None = -1}
@export var property:SPECIAL_PROPERTY = SPECIAL_PROPERTY.None
@export_flags("Fire","Ice","Acid") var weaknesses:int = 0
@export var dimensions:Array[Vector2i] = [Vector2i.ZERO]
@export var texture:Texture2D = null
@export var textureOffset:Vector2 = Vector2.ZERO
