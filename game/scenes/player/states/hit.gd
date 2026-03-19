extends PlayerState

signal show_hit_particles

var enter_dead = false

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("hit")
	player.invencible = true
	
	player.velocity.x = -player.velocity.normalized().x * 40
	
	show_hit_particles.emit(Vector2(player.velocity.x, 0.0))
	
	player.velocity.x = 0.0
	
	var tween = get_tree().create_tween()
	
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(player, "scale", Vector2(0.7, 1.0), 0.15)
	tween.chain()
	tween.tween_property(player, "scale", Vector2(1.0, 1.0), 0.15)
	tween.play()
	
	player.play_sound("hit")
	
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
