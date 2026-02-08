extends PlayerState

signal show_hit_particles

func _enter(_previous_state_path: String, _init_data := {}):
	
	player.current_health -= 1
	player.set_animation("hit")
	
	if player.current_health <= 0:
		get_tree().create_timer(1).timeout.connect(func():
			finished.emit(DEAD)
		)
	else:
		#player.set_animation("shake")
		
		#Engine.time_scale = 0.25
		get_tree().create_timer(0.125).timeout.connect(func():
			Engine.time_scale = 1.0
		)
			
		player.velocity.y = -60
		player.velocity.x = -player.velocity.normalized().x * 40
		
		show_hit_particles.emit(Vector2(player.velocity.x, 0.0))
		
		$KnockBackTimer.start()
		$InvencibleTimer.start()
		
		player.invencible = true
	


func _update_physics(_delta):
	
	var GRAVITY_FORCE = 250
	player.velocity.y += GRAVITY_FORCE * _delta
	player.move_and_slide()
	
	if player.is_on_floor():
		player.velocity.x = 0.0


func _on_timer_timeout() -> void:
	finished.emit(IDLE)


func _on_invencible_timer_timeout() -> void:
	player.invencible = false
