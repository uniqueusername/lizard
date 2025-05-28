extends Sprite2D

func _on_timer_timeout() -> void:
	$AnimationPlayer.play("blink")
	$Timer.start(randi_range(1, 60))

func sleep() -> void:
	$Timer.paused = true
	scale.y = 0.05
	
func wake_up() -> void:
	scale.y = 0.22
	$Timer.paused = false
	$Timer.start(randi_range(1, 60))
