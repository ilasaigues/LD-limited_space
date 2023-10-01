extends Control
class_name ItemInstance
var base_data:ItemData
var grid_position:Vector2i

var rotationIndex = 0

var is_stored:bool = false
var stored_center_slot:Vector2i = Vector2i(-1,-1)

func Init(data:ItemData):
	base_data = data
	get_node("Texture").position += base_data.textureOffset;
	get_node("Texture").texture = base_data.texture

func Rotate(clockwise:bool):
	rotationIndex = (rotationIndex +( 3 if clockwise else 1)) % 4
	rotation = rotationIndex/2.0*PI

func get_dimensions():
	var dimensions:Array[Vector2i] = []
	for vec in base_data.dimensions:
		match rotationIndex:
			0: # no rotation
				dimensions.append(vec)
			1: # ccw rotation
				dimensions.append(Vector2i(-vec.y,vec.x))
			2: # invert
				dimensions.append(Vector2i(-vec.x,-vec.y))
			3: # cw rotation
				dimensions.append(Vector2i(vec.y,-vec.x))
	return dimensions


