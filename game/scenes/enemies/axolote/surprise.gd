extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.set_animation("surprise")
	await get_tree().create_timer(0.3).timeout
	finished.emit(RUN)
