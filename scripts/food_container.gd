extends Node2D

var food: PackedScene = preload("res://food.tscn")

func _ready() -> void:
	Global.spawn_food.connect(_spawn_food)
	
func _spawn_food():
	var food_scene: RigidBody2D = food.instantiate()
	food_scene.global_position.x = randf_range(0, get_viewport_rect().size.x)
	add_child(food_scene)
