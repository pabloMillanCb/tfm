extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("idle")
	player.get_node("DebugStateName").text = IDLE


func _update_physics(_delta):
	if Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif Input.get_axis("move_left", "move_right"):
		finished.emit(MOVE)
