extends Sprite2D

var max_dist: float = 25

func _process(delta) -> void:
	var diff: float = (get_parent().global_position - global_position).length()
	
	if Global.vertical:
		look_at(get_global_mouse_position())
		rotation += PI/2
	else: rotation = 0
	
	if diff > max_dist+5:
		global_position = global_position.move_toward(get_parent().global_position, diff - max_dist)
		if get_node_or_null("legs"): 
			if Global.vertical: $legs.move_vertical(delta)
			else: $legs.move(delta)
		
