extends CharacterBody2D
class_name EnemyCharacter

@export var health := 1

func take_damage():
	health -= 1
	if health == 0:
		die()
	else:
		react_to_damage()


func react_to_damage():
	pass


func die():
	queue_free()
