extends PlayerState

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("fall")

func _update(_delta):
	player.update_gravity(_delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.air_acceleration) 
	else:
		player.velocity.x = move_toward(
			player.velocity.x, 
			0.0, 
			_delta * player.air_acceleration) 
	
	if (Input.is_action_just_pressed("atack")
		and Input.is_action_pressed("aim_down")
		and player.data.has_pogo_update):
		finished.emit(POGO)
	elif Input.is_action_just_pressed("teleport") and player.data.has_teleport_update:
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("atack") and player.data.has_sword_update:
		finished.emit(ATACK)
	elif player.is_on_floor():
		finished.emit(IDLE)
	
	player.move_and_slide()
