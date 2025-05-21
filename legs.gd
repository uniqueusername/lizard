extends Node2D

var ticks: float = 0

func move(delta: float):
	ticks += delta
	for i in get_child_count():
		get_child(i).position.x = 25 * sin(ticks*8 + (i*PI))
		get_child(i).position.y = 0

func move_vertical(delta: float):
	ticks += delta
	for i in get_child_count():
		get_child(i).position.x = -25 + 50 * sin(i*PI/2)
		get_child(i).position.y = 25 * sin(ticks*8 + (i*PI))
