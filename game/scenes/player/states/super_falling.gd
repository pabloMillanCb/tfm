extends FallState


func _enter(_previous_state_path: String, _init_data := {}):
	animation_name = "super_fall"
	sound_name = "heavy_land"
	player.set_animation("animation_name")
	vibration_force = 0.8
	vibration_time = 0.3

func _to_finish():
	finished.emit(STOMP)

func _exit():
	pass
