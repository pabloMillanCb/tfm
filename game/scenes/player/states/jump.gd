extends PlayerState

var forced_jump = false

func _enter(_previous_state_path: String, _init_data := {}):
	player.velocity.y = player.jump_force
	forced_jump = _init_data.get("extra_force") != null
	if forced_jump:
		player.velocity.y += _init_data.get("extra_force")
	player.set_animation("jump")

func _update(_delta):
	player.update_gravity(_delta, forced_jump)
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.air_acceleration) 

	
	if (Input.is_action_just_pressed("atack")
		and Input.is_action_pressed("aim_down")
		and player.data.has_pogo_update):
		finished.emit(POGO)
	elif Input.is_action_just_pressed("teleport") and player.data.has_teleport_update:
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("atack") and player.data.has_sword_update:
		finished.emit(ATACK)
	elif player.velocity.y > 0:
		finished.emit(FALLING)
	
	player.move_and_slide()
