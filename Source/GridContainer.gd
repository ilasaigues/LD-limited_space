extends GridContainer

@export var rows:int
@export var all_items:Array[ItemData]

@export var new_item_slots:Array[LootableSlot]

@export var default_color : Color 
@export var hovered_color : Color 
@export var occupied_color : Color 
@export var overlap_color : Color 

var slot_prefab = preload("res://Prefabs/inventory_slot.tscn")
var grid = []

var closestSlot = null


var emptyItem = preload("res://Prefabs/EmptyItem.tscn")
var selectedItem = null
var storedItems:Array[ItemInstance]

func get_new_random_item():
	var newItem = emptyItem.instantiate()
	get_parent().add_child.call_deferred(newItem)
	newItem.Init(all_items[randi()%all_items.size()])
	return newItem

func _ready():
	for r in rows:
		for c in columns:
			var instance = slot_prefab.instantiate()
			add_child(instance)
			var pos = Vector2i(c,r)
			instance.grid_position=pos
			add_slot(pos,instance)
			
	for slot in new_item_slots:
		slot.Initialize(self)
		var newItem = get_new_random_item()
		var slotPos = slot.get_global_rect().position+slot.get_global_rect().size/2
		slot.set_item(newItem)
		newItem.position = slotPos

func _process(delta):
	print("----------")

	update_selected_transform()
		
	# find nearest slot to mouse
	for column in grid:
		for node in column:
			node.modulate = default_color
			if closestSlot == null: closestSlot = node
			elif closestSlot.global_position.distance_to(get_global_mouse_position()) > node.global_position.distance_to(get_global_mouse_position()):
				closestSlot = node
				
	var valid_space = true
				
	# find which nodes are occupied with items, recolor them
	var occupiedNodes = []
	for item in storedItems:
		for slot_id in item.get_dimensions():
			var pos = slot_id+item.stored_center_slot
			var slot = try_get_node(pos)
			if slot!=null:
				occupiedNodes.append(slot)
	for node in occupiedNodes:
		node.modulate=occupied_color
	
	if !selectedItem: return
	
	# find which nodes are being hovered over, recolor them
	var hoveredNodes = []
	for offset in selectedItem.get_dimensions():
		var coveredNode = try_get_node(closestSlot.grid_position+offset)
		if coveredNode:
			hoveredNodes.append(coveredNode)
		else:
			valid_space = false



	for node in hoveredNodes:
		node.modulate = hovered_color
		if occupiedNodes.has(node): # recolor the nodes that are overlapping in red
			node.modulate = overlap_color
			valid_space=false
		
	if valid_space && Input.is_action_just_pressed("click"):
		selectedItem.global_position = closestSlot.global_position
		selectedItem.is_stored = true
		selectedItem.stored_center_slot = closestSlot.grid_position
		storedItems.append(selectedItem)
		selectedItem=null
		
		
func update_selected_transform():
	if !selectedItem: return
	# update selected item
	selectedItem.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("rotate_ccw"):
		selectedItem.Rotate(true)
	if Input.is_action_just_pressed("rotate_cw"):
		selectedItem.Rotate(false)

func try_get_node(id:Vector2i):
	print(id)
	if id.x >=0 && id.x < grid.size() && id.y >=0 && id.y < grid[id.x].size():
		return grid[id.x][id.y]
	return null

func add_slot(id:Vector2i,slot):
	while grid.size() <=id.x:
		grid.append([])
	while grid[id.x].size()<= id.y:
		grid[id.x].append([])
	grid[id.x][id.y] = slot

func on_loot_slot_pressed(slot:LootableSlot):
	if slot.storedItem :
		selectedItem = slot.storedItem
		slot.set_item(null)
