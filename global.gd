extends Node

signal feed_lizard
signal spawn_food
signal new_food

var vertical: bool = true
var target_margin: float = 3
var scale: Vector2 = Vector2(0.1, 0.1)
var food_count: int = 0
var max_food: int = 2
var dead: bool = false

func _input(event: InputEvent):
	if event.is_action_pressed("ui_focus_next"):
		vertical = not vertical
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func drop_food() -> void:
	if food_count > 0:
		spawn_food.emit()
		food_count -= 1
