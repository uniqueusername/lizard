extends Node2D

const max_hunger: float = 100
const max_energy: float = 60
const foodiness: float = 30

var hunger: float = max_hunger
var energy: float = max_energy
var hungry: bool = false
var sleeping: bool = false
var dead: bool = false

func _ready() -> void:
	_load_state()
	Global.feed_lizard.connect(_eat)

func _process(delta: float) -> void:
	if energy <= 0: _sleep()
	hungry = get_hunger_percent() <= 0.4
	$head/hungry.visible = hungry and not sleeping and not dead
	$head/asleep.visible = sleeping and not dead
	$head/head_shape/Area2D.monitorable = hungry
	
	if hunger <= 0 or dead:
		dead = true
		Global.dead = true
		$head/head_shape/eye.sleep()
		$head/hungry.text = ""

func _tick_hunger() -> void:
	if hunger > 0 and $sleep_timer.time_left == 0: hunger -= 1

func _tick_energy() -> void:
	if energy > 0 and $sleep_timer.time_left == 0 and not dead: energy -= 1

func _sleep() -> void:
	sleeping = true
	energy = max_energy
	$sleep_timer.start()
	$head/Timer.start($sleep_timer.wait_time)
	$head/head_shape/eye.sleep()

func _wake_up() -> void:
	sleeping = false
	$head/head_shape/eye.wake_up()

func get_hunger_percent() -> float:
	return hunger/max_hunger

func get_hungry() -> bool:
	return hungry

func _eat() -> void:
	hunger += foodiness

func _save_state() -> void:
	var save_data = {
		"hunger": hunger,
		"energy": energy,
		"hungry": hungry,
		"sleeping": sleeping,
		"dead": dead,
		"head_orientation": $head/head_shape.scale.x
	}
	
	var save_file = FileAccess.open("user://save.save", FileAccess.WRITE)
	save_file.store_line(JSON.stringify(save_data))
	
	for child in get_tree().get_nodes_in_group("persist"):
		var node_data = {
			"path": child.get_path(),
			"pos_x": child.global_position.x,
			"pos_y": child.global_position.y,
		}
		
		save_file.store_line(JSON.stringify(node_data))

func _load_state() -> void:
	var save_file = FileAccess.open("user://save.save", FileAccess.READ)
	if not save_file: return
	
	var save_data = JSON.parse_string(save_file.get_line())
	
	hunger = save_data["hunger"]
	energy = save_data["energy"]
	hungry = save_data["hungry"]
	sleeping = save_data["sleeping"]
	dead = save_data["dead"]
	$head/head_shape.scale.x = save_data["head_orientation"]
	Global.dead = dead
	
	while save_file.get_position() < save_file.get_length():
		var node_data = JSON.parse_string(save_file.get_line())
		var node = get_node(node_data["path"])
		node.position = Vector2(node_data["pos_x"], node_data["pos_y"])

func _on_save_timer_timeout() -> void:
	_save_state()
