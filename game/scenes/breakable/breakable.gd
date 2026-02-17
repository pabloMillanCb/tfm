extends Node2D
class_name Breakable

func take_damage():
	print("take_damage")
	queue_free()
