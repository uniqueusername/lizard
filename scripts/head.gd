extends Sprite2D

@export var food_container: Node2D

var target: float = get_viewport_rect().size.x - 100
var height: float = -10
var speed: float = 1.5
@onready var head_shape_scale: int = $head_shape.scale.x

func _ready():
	global_position = get_viewport_rect().size/2
	scale *= Global.scale
	offset.y = -16/Global.scale.y

func _process(delta: float) -> void:
	if food_container.get_child_count() > 0 and get_parent().get_hungry():
		target = food_container.get_child(0).global_position.x
	
	var new_pos: Vector2 = global_position
	if target > global_position.x: new_pos.x += speed * clampf(get_parent().get_hunger_percent()+0.3, 0, 1)
	else: new_pos.x -= speed * clampf(get_parent().get_hunger_percent()+0.3, 0, 1)
	new_pos.y = $RayCast2D.get_collision_point().y + height
	if (abs(global_position.x - target) > 5):
		if not new_pos.x > global_position.x: $head_shape.scale.x = -head_shape_scale
		else: $head_shape.scale.x = head_shape_scale
		$head_shape.rotation = ($RayCast2D2.get_collision_point() - $RayCast2D.get_collision_point()).angle()
		if not get_parent().sleeping and not get_parent().dead: global_position = new_pos

func _on_timer_timeout() -> void:
	if not get_parent().dead:
		target = randi_range(0, get_viewport_rect().size.x)
		$Timer.start(randi_range(5, 25))

func set_target(new_target: Vector2):
	if not get_parent().dead:
		target = new_target.x
