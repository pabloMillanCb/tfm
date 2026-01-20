extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	if Input.get_axis("move_left", "move_right") != sign(player.velocity.x):
		player.velocity.x = 0
	player.set_animation("idle")


func _update_physics(_delta):
	if !player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("teleport"):
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif Input.get_axis("move_left", "move_right"):
		finished.emit(MOVE)
