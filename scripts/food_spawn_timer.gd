extends Timer

func _on_timeout() -> void:
	if Global.food_count < 3:
		Global.food_count += 1
		Global.new_food.emit()
