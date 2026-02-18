extends TriangleFishState


func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("sleep")


func _update(_delta):
	if fish.player != null:
		finished.emit(WATCH)
