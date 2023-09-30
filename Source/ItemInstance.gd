extends Node
class_name ItemInstance
var base_data:ItemData
var grid_position:Vector2i

var rotationIndex = 0

func Init(data:ItemData):
	base_data = data

func Rotate(clockwise:bool):
	rotationIndex = (rotationIndex +( 3 if clockwise else 1)) % 4
	

func get_dimensions():
	var dimensions:Array[Vector2i] = []
	for vec in base_data.dimensions:
		match rotationIndex:
			0:
				dimensions.append(vec)
			1:
				dimensions.append(Vector2i(vec.y,-vec.x))
			2:
				dimensions.append(Vector2i(-vec.x,-vec.y))
			3:
				dimensions.append(Vector2i(-vec.y,vec.x))
	return dimensions


