extends Control
class_name GridSlot
@export var grid_position:Vector2i

var grid_container:GridContainer
var item_instance:ItemInstance

func Initiate(grid:GridContainer):
	grid_container = grid

func SetItem(item:ItemInstance):
	item_instance = item
