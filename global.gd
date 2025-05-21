extends Node

var vertical: bool = true

func _input(event: InputEvent):
	if event.is_action_pressed("ui_focus_next"):
		vertical = not vertical
