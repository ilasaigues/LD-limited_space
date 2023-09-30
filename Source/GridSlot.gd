extends TextureButton

@export var grid_position:Vector2i

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	$"..".on_changed_hovered_node(self,get_global_rect().has_point(mouse_pos))
	
		
	
