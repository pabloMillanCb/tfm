extends TriangleFishState

var ray_cast: RayCast2D

func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("watch")
	ray_cast = fish.ray_cast

func _update_physics(_delta):
	ray_cast.target_position = fish.player.global_position
	
	fish.update_direction()
	
	if ray_cast.get_collider() is Player:
		finished.emit(CHASE)
