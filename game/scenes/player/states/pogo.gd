extends PlayerState


func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("pogo")
	player.set_pogo_hitbox(true)
	

func _exit():
	player.set_pogo_hitbox(false)


func _update(_delta):
	player.update_gravity(_delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.walking_acceleration) 
	else:
		player.velocity.x = move_toward(
			player.velocity.x, 
			0.0, 
			_delta * player.walking_acceleration) 
	
	if player.is_on_floor():
		finished.emit(IDLE)
	
	player.move_and_slide()

func bounce():
	player.velocity.y = player.bounce_force


func _on_pogo_hitbox_area_entered(area: Area2D) -> void:
	print("pogo")
	bounce()


func _on_pogo_hitbox_body_entered(body: Node2D) -> void:
	print("pogo2")
	bounce()


func _on_pogo_hitbox_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("pogo3")
	bounce()
