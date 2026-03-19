extends CharacterBody2D
class_name EnemyCharacter

var alive = true

@export var health := 1
@export var knockback_force = Vector2(25.0, 25.0)
@export var hit = false

@export var vibration_force = 0.4
@export var vibration_time = 0.2

func take_damage(direction: Vector2 = Vector2.ZERO):
	health -= 1
	Input.start_joy_vibration(0,vibration_force,vibration_force,vibration_time)
	if health <= 0:
		die()
	else:
		react_to_damage(direction)


func react_to_damage(direction: Vector2 = Vector2.ZERO):
	hit = true
	print("REACT TO")
	print(direction)
	velocity = Vector2(direction.x * knockback_force.x, knockback_force.y)


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
