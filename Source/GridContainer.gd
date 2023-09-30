extends GridContainer

@export var rows:int
var slot_prefab = preload("res://Prefabs/inventory_slot.tscn")
var grid = []

var closestNode = null

var emptyItem = preload("res://Prefabs/EmptyItem.tscn")
var selectedItem

func _ready():
	selectedItem = emptyItem.instantiate()
	selectedItem.Init(load("res://testWeapon.tres"))

	for r in rows:
		for c in columns:
			var instance = slot_prefab.instantiate()
			add_child(instance)
			var pos = Vector2i(c,r)
			instance.grid_position=pos
			add_slot(pos,instance)

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		selectedItem.Rotate(false)
	if Input.is_action_just_pressed("ui_right"):
		selectedItem.Rotate(true)
	for column in grid:
		for node in column:
			node.modulate=Color.WHITE
			if closestNode == null: closestNode = node
			elif closestNode.global_position.distance_to(get_global_mouse_position()) > node.global_position.distance_to(get_global_mouse_position()):
				closestNode = node
	var coveredNodes = []
	for offset in selectedItem.get_dimensions():
		var coveredNode = try_get_node(closestNode.grid_position+offset)
		if coveredNode: coveredNodes.append(coveredNode)
	for node in coveredNodes:
		node.modulate=Color.YELLOW
		
func try_get_node(id:Vector2i):
	if id.x >=0 && id.x < grid.size() && id.y >=0 && id.y < grid[id.x].size():
		return grid[id.x][id.y]
	return null

func add_slot(id:Vector2i,slot):
	while grid.size() <=id.x:
		grid.append([])
	while grid[id.x].size()<= id.y:
		grid[id.x].append([])
	grid[id.x][id.y] = slot

