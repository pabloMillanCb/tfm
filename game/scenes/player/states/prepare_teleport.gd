extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("prepare_teleport")
	player.prepare_teleport()


func _update(_delta):
	player.update_gravity(_delta)
	
	if player.is_on_floor():
		player.velocity.x = 0
	
	if !Input.is_action_pressed("teleport"):
		finished.emit(RELEASE_TELEPORT)
	
	player.move_and_slide()
