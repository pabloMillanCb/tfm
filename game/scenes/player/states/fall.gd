extends PlayerState

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("fall")

func _update(_delta):
	player.update_gravity(_delta)
	
	if Input.is_action_just_pressed("atack") and Input.is_action_pressed("aim_down"):
		finished.emit(POGO)
	elif Input.is_action_just_pressed("teleport"):
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif player.is_on_floor():
		finished.emit(IDLE)
	
	player.move_and_slide()
