extends CharacterBody2D

var direction = Vector2.ZERO


func _physics_process(delta: float) -> void:
	var input = Input.get_vector("move_left", "move_right", "aim_up", "aim_down")
	
	var acceleration = 10
	if input:
		direction = direction.move_toward(input, delta * acceleration)
	else:
		direction = direction.move_toward(Vector2.ZERO, delta * acceleration)
	
	velocity = direction * 130
	
	move_and_slide()
