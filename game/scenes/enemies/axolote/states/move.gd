extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.set_animation("move")

func _update_physics(_delta):
	axolote.update_gravity(_delta)
	
	if axolote.is_turn_around_needed():
		print("move")
		axolote.change_direction()
	elif axolote.is_player_on_sight():
		finished.emit(SURPRISE)
		
	walk()
	axolote.move_and_slide()


func walk():
	axolote.velocity.x = axolote.walk_speed * axolote.move_direction
