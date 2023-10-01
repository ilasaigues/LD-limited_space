extends TextureButton
class_name LootableSlot
var gridContainer:GridContainer

var storedItem:ItemInstance=null

func Initialize(grid:GridContainer):
	gridContainer = grid

func set_item(item:ItemInstance):
	storedItem = item

func _pressed():
	gridContainer.on_loot_slot_pressed(self)
