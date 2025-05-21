extends Sprite2D

@export var food_container: Node2D

var target_margin: float = Global.target_margin
var target: float = 640
var height: float = -10
var speed: float = 1.5

func _ready():
	global_position = Vector2.ZERO
	scale *= Global.scale
	offset.y = -16/Global.scale.y

func _process(delta: float) -> void:
	if food_container.get_child_count() > 0 and get_parent().get_hungry():
		target = food_container.get_child(0).global_position.x
	
	var new_pos: Vector2 = global_position
	if target > global_position.x: new_pos.x += speed * get_parent().get_hunger_percent()
	else: new_pos.x -= speed * get_parent().get_hunger_percent()
	new_pos.y = $RayCast2D.get_collision_point().y + height
	if (abs(global_position.x - target) > 5):
		if not new_pos.x > global_position.x: $head_shape.scale.x = -1
		else: $head_shape.scale.x = 1
	$head_shape.rotation = ($RayCast2D2.get_collision_point() - $RayCast2D.get_collision_point()).angle()
	global_position = new_pos

func _on_timer_timeout() -> void:
	target = randi_range(0, get_viewport_rect().size.x)
	$Timer.start(randi_range(5, 25))

func set_target(new_target: Vector2):
	target = new_target.x
