extends FallState


func _enter(_previous_state_path: String, _init_data := {}):
	animation_name = "super_fall"
	sound_name = "heavy_land"
	player.set_animation("animation_name")


func _exit():
	pass
