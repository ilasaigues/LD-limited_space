extends Resource
class_name CharacterData


@export var maxHP:int = 100
@export var texture:Texture2D
@export var compatibleItems:Array[ItemData]
@export var animationName:String

@export var element:GameRules.ElementType = GameRules.ElementType.None

@export var vfxDictionary = {
	GameRules.ElementType.None:null, 
	GameRules.ElementType.Fire:null,
	GameRules.ElementType.Ice:null,
	GameRules.ElementType.Acid:null}
