extends RigidBody2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.feed_lizard.emit()
	queue_free()
