extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.can_take_hits = false
	axolote.health -= 1
	if axolote.health == 0:
		finished.emit(DEAD)
	else:
		axolote.velocity = Vector2(axolote.walk_speed/2, -60)
		axolote.change_direction()


func _update_physics(_delta):
	axolote.update_gravity(_delta)
	
	axolote.move_and_slide()
	
	if axolote.is_on_floor():
		finished.emit(RUN)

func _exit():
	axolote.can_take_hits = true
