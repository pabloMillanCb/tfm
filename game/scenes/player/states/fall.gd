extends PlayerState


func _update(_delta):
	player.update_gravity(_delta)
	player.set_animation("fall")
	
	if Input.is_action_just_pressed("atack"):
		finished.emit(ATACK)
	elif player.is_on_floor():
		finished.emit(IDLE)
	
	player.move_and_slide()
