extends EnemyCharacter

@export var speed = 50
@export var gravity = 200
@export var direction = 1

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += delta * 400
	else:
		velocity.y = 0
	
	if $Walk.time_left > 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, delta * 2)
	
	move_and_slide()

func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == StringName("to_walk"):
		$AnimatedSprite2D.play("walk")


func _on_wait_timeout() -> void:
	$AnimatedSprite2D.play("to_walk")
	$Walk.start()


func _on_walk_timeout() -> void:
	$AnimatedSprite2D.play("to_idle")
	$Wait.start()
