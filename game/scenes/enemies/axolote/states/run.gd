extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.set_animation("run")

func _update_physics(_delta):
	axolote.update_gravity(_delta)
	
	run()
	
	if axolote.is_turn_around_needed():
		print("turn needed")
		#axolote.change_direction()
		finished.emit(MOVE)
		
	axolote.move_and_slide()


func run():
	axolote.velocity.x = axolote.run_speed * axolote.move_direction
