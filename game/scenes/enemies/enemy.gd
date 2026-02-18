extends Node2D
class_name Enemy

@export var health := 1

func take_damage(direction: Vector2 = Vector2.ZERO):
	health -= 1
	if health == 0:
		die()
	else:
		react_to_damage()


func react_to_damage():
	pass


func die():
	queue_free()


func play_hit_animation():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.0, 1.5), 0.1)
	tween.chain()
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.0, 1.0), 0.1)
	tween.play()
