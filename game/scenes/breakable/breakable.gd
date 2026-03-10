extends Node2D
class_name Breakable

func take_damage(direction: Vector2 = Vector2.ZERO):
	print("take_damage")
	queue_free()
