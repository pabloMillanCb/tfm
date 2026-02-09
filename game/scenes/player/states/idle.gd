extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	if Input.get_axis("move_left", "move_right") != sign(player.velocity.x):
		player.velocity.x = 0
	player.set_animation("idle")
	player.dialog_start_request.connect(start_talking)


func _exit():
	player.dialog_start_request.disconnect(start_talking)


func _update_physics(_delta):
	if !player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("teleport") and player.data.has_teleport_update:
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("atack") and player.data.has_sword_update:
		finished.emit(ATACK)
	elif Input.get_axis("move_left", "move_right"):
		finished.emit(MOVE)


func start_talking(dialogue_component: DialogueComponent):
	finished.emit(TALKING, {"dialogue": dialogue_component})
