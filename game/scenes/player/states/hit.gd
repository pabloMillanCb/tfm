extends PlayerState

signal show_hit_particles

var enter_dead = false

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("hit")
	player.invencible = true
	
	player.velocity.y = -60
	player.velocity.x = -player.velocity.normalized().x * 40
	
	show_hit_particles.emit(Vector2(player.velocity.x, 0.0))
	
	player.velocity.y = player.jump_force/1.5
	player.velocity.x = 0.0
	
	$KnockBackTimer.start()
	$InvencibleTimer.start()

func _update_physics(_delta):
	player.update_gravity(_delta)
	player.move_and_slide()

func _on_hit_received():
	pass


func _on_timer_timeout() -> void:
	finished.emit(IDLE)


func _on_invencible_timer_timeout() -> void:
	player.invencible = false
