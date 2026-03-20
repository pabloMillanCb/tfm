extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.can_take_hits = false
	Input.start_joy_vibration(0,axolote.vibration_force,axolote.vibration_force,axolote.vibration_time)
	axolote.set_animation("hit_enemy")
	axolote.health -= 1
	if axolote.health == 0:
		finished.emit(DEAD)
	else:
		var direction = _init_data.get("direction")
		axolote.change_direction()
		axolote.velocity = Vector2(axolote.walk_speed/1.5 * direction.x, -75)


func _update_physics(_delta):
	axolote.update_gravity(_delta)
	
	axolote.move_and_slide()
	
	if axolote.is_on_floor():
		finished.emit(RUN)

func _exit():
	axolote.can_take_hits = true
