extends TextureButton
class_name LootableSlot
var gridContainer:GridManager

var storedItem:ItemInstance=null

func Initialize(grid:GridManager):
	gridContainer = grid

func set_item(item:ItemInstance):
	storedItem = item	
	if storedItem:
		item.position = self.get_global_rect().position + self.get_global_rect().size/2

func _pressed():
	gridContainer.on_loot_slot_pressed(self)
