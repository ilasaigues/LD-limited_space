extends Resource
class_name CharacterData

@export var maxHP:int = 100
@export var texture:Texture2D
@export var compatibleItems:Array[ItemData]
@export var animationName:String
enum SPECIAL_PROPERTY { None = 0,Fire=1, Ice=2, Acid=4}
@export var element:SPECIAL_PROPERTY = SPECIAL_PROPERTY.None
