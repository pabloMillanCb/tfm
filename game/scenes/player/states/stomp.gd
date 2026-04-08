extends PlayerState
class_name StompState

signal show_death_particles

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("stomp")
	$Timer.start()
	show_death_particles.emit()


func _on_timer_timeout() -> void:
	finished.emit(IDLE)
