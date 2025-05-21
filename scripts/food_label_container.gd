extends HBoxContainer

var root_label: PackedScene = preload("res://food_label.tscn")

func _ready() -> void:
	Global.new_food.connect(_new_food)
	Global.spawn_food.connect(_minus_food)

func _new_food() -> void:
	var new_label: Label = root_label.instantiate()
	add_child(new_label)

func _minus_food() -> void:
	if get_child_count() > 0:
		get_children().back().queue_free()
