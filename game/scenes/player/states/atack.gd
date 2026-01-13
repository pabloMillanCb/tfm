extends PlayerState

var stored_speed = 0.0

func _enter(_previous_state_path: String, _init_data := {}):
	
	if Input.get_axis("move_left", "move_right"):
		player.update_look_direction()
	
	player.set_animation("atack")
	player.get_node("DebugStateName").text = ATACK
	
func _update_physics(_delta):
	player.velocity.x = move_toward(player.velocity.x, 0, _delta * player.walking_acceleration * 1.2)
	player.move_and_slide()

func _on_atack_animation_end():
	if (stored_speed != 0):
		finished.emit(MOVE)
	else:
		finished.emit(IDLE)
	
