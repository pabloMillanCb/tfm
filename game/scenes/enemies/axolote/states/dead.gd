extends AxoloteState

func _enter(_previous_state_path: String, _init_data := {}):
	axolote.can_take_hits = false
	axolote.die()
