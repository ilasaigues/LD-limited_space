extends Resource
class_name ItemData
enum ITEM_TYPE {Weapon, Consumable, Quest}
@export_flags("Fire","Ice","Acid") var weaknesses:int = 0
@export var type:ITEM_TYPE = ITEM_TYPE.Weapon
@export var dimensions:Array[Vector2i] = [Vector2i.ZERO]
@export var texture:Texture2D = null
@export var glow_texture:Texture2D = null
@export var textureOffset:Vector2 = Vector2.ZERO
