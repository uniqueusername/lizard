extends Sprite2D

@export var dist_constraint: float = 20
@export var forward_segment: Sprite2D
var moving_right: bool = false

func _ready() -> void:
	scale *= Global.scale
	offset.y = -16/Global.scale.y
	if not forward_segment: forward_segment = get_parent()

func _process(delta: float) -> void:
	var seg_to_seg: Vector2 = (forward_segment.position - position)
	var diff: float = seg_to_seg.length()
	if diff > dist_constraint+1:
		var new_position = global_position.move_toward(forward_segment.global_position, diff - dist_constraint)
		moving_right = new_position.x > global_position.x
		position = new_position
		
	
