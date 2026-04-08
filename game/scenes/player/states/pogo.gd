extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("pogo")
	player.set_pogo_hitbox(true)
	

func _exit():
	player.set_pogo_hitbox(false)


func _update(_delta):
	update_gravity(_delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.pogo_acceleration) 
	else:
		player.velocity.x = move_toward(
			player.velocity.x, 
			0.0, 
			_delta * player.pogo_acceleration) 
			
	if Input.is_action_just_pressed("teleport") and player.data.has_teleport_update:
		finished.emit(PREPARE_TELEPORT)	
	elif player.is_on_floor():
		finished.emit(IDLE)
	
	player.move_and_slide()


func update_gravity(_delta: float):
	var POGO_GRAVITY_FORCE = 200
	var MAX_FALL_SPEED = 200
	
	player.velocity.y = min(player.velocity.y + POGO_GRAVITY_FORCE * _delta, MAX_FALL_SPEED)


func bounce():
	player.velocity.y = player.bounce_force


func _on_pogo_hitbox_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage") and player.data.has_break_update:
		area.take_damage(-(area.global_position - player.global_position).normalized())
	bounce()
