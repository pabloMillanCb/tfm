extends PlayerState



func _enter(_previous_state_path: String, _init_data := {}):
	player.velocity.y = player.jump_force
	player.set_animation("jump")

func _update(_delta):
	player.update_gravity(_delta)
	
	if Input.is_action_just_pressed("atack") and Input.is_action_pressed("aim_down"):
		finished.emit(POGO)
	elif Input.is_action_just_pressed("teleport"):
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif player.velocity.y > 0:
		finished.emit(FALLING)
	
	player.move_and_slide()
