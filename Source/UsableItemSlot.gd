extends TextureButton
class_name UsableItemSlot
var gridContainer:GridManager

var storedItem:ItemInstance=null
var characterData:CharacterData

func Initialize(grid:GridManager):
	gridContainer = grid

func SetCharacterData(charData:CharacterData):
	characterData = charData

func set_item(item:ItemInstance):
	storedItem = item	
	if storedItem:
		item.position = self.get_global_rect().position + self.get_global_rect().size/2 -item.base_data.textureOffset

func _pressed():
	gridContainer.on_equip_slot_pressed(self)
