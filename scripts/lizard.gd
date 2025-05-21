extends Node2D

const max_hunger: float = 20
const max_energy: float = 60
const foodiness: float = 30

var hunger: float = max_hunger
var energy: float = max_energy
var hungry: bool = false

func _ready() -> void:
	Global.feed_lizard.connect(_eat)

func _process(delta: float) -> void:
	if energy <= 0: _sleep()
	hungry = hunger <= max_hunger * 0.4
	$head/hungry.visible = hungry
	$head/head_shape/Area2D.monitorable = hungry
	
	if hunger <= 0:
		$head/head_shape/eye.sleep()
		$head/hungry.text = ""

func _tick_hunger() -> void:
	if hunger > 0: hunger -= 1

func _tick_energy() -> void:
	if energy > 0 and $sleep_timer.time_left == 0: energy -= 1

func _sleep() -> void:
	energy = max_energy
	$sleep_timer.start()
	$head/Timer.start($sleep_timer.wait_time)
	$head/head_shape/eye.sleep()
	
func _wake_up() -> void:
	print("asdfjlasdf")
	$head/head_shape/eye.wake_up()

func get_hunger_percent() -> float:
	return hunger/max_hunger

func get_hungry() -> bool:
	return hungry

func _eat() -> void:
	hunger += foodiness
