extends PlayerState

var stored_speed = 0.0

func _enter(_previous_state_path: String, _init_data := {}):
	
	if Input.get_axis("move_left", "move_right"):
		player.update_look_direction()
	
	player.set_animation("atack")
	stored_speed = player.velocity.x
	player.velocity.x = 0.0
	player.get_node("DebugStateName").text = ATACK

func _exit():
	player.velocity.x = stored_speed

func _on_atack_animation_end():
	finished.emit(MOVE)
	
