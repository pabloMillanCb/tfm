extends PlayerState

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("move")


func _update_physics(_delta):
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.walking_acceleration) 
	else:
		player.velocity.x = move_toward(
			player.velocity.x, 
			0.0, 
			_delta * player.walking_acceleration) 
	
	player.move_and_slide()
	player.update_look_direction()
	
	if !player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("teleport"):
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif player.velocity.x == 0.0 and !direction:
		finished.emit(IDLE)
