extends PlayerState

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("move")
	player.dialog_start_request.connect(start_talking)


func _exit():
	player.dialog_start_request.disconnect(start_talking)

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
	elif Input.is_action_just_pressed("atack") and player.data.has_sword_update:
		finished.emit(ATACK)
	elif player.velocity.x == 0.0 and !direction:
		finished.emit(IDLE)


func start_talking(dialogue_component: DialogueComponent):
	finished.emit(TALKING, {"dialogue": dialogue_component})
