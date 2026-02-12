extends Node2D
class_name Enemy

func take_damage():
	die()


func die():
	queue_free()
