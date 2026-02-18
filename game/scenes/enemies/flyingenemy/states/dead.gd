extends TriangleFishState


func _enter(_previous_state_path: String, _init_data := {}):
	fish.die()
