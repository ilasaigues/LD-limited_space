extends GridContainer

@export var rows:int
var slot_prefab = preload("res://Prefabs/inventory_slot.tscn")
var grid = []
var selectedNodes = []


func _ready():
	for x in columns:
		for y in rows:
			print(x,y)
			var instance = slot_prefab.instantiate()
			add_child(instance)
			var pos = Vector2i(x,y)
			instance.grid_position=pos
			add_slot(pos,instance)


func _process(delta):
	for column in grid:
		for node in column:
			node.modulate = Color.WHITE
	for node in selectedNodes:
		node.modulate = Color.RED

func add_slot(id:Vector2i,slot):
	while grid.size() <=id.x:
		grid.append([])
	while grid[id.x].size()<= id.y:
		grid[id.x].append([])
	grid[id.x][id.y] = slot

func on_changed_hovered_node(node, enter:bool):
	if enter && selectedNodes.count(node)==0:
		selectedNodes.append(node)
	elif !enter && selectedNodes.count(node)!=0:
		selectedNodes.erase(node)
