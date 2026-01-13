extends PlayerState

var current_speed = 0.0

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("move")
	current_speed = player.velocity.x
	player.get_node("DebugStateName").text = MOVE


func _update_physics(_delta):
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		current_speed = move_toward(
			current_speed, 
			player.walking_speed * direction, 
			_delta * player.walking_acceleration) 
	else:
		current_speed = move_toward(
			current_speed, 
			0.0, 
			_delta * player.walking_acceleration) 
		
	player.velocity.x = current_speed
	
	player.move_and_slide()
	player.update_look_direction()
	
	if Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif player.velocity.x == 0.0 and !direction:
		finished.emit(IDLE)

func _exit():
	player.velocity.x = 0.0
