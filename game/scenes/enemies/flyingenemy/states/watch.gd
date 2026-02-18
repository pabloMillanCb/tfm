extends TriangleFishState

var ray_cast: RayCast2D

func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("watch")
	ray_cast = fish.ray_cast

func _update_physics(_delta):
	ray_cast.target_position = vector_to_player()
	
	fish.update_direction(vector_to_player())
	
	if ray_cast.get_collider() is Player:
		finished.emit(CHASE)


func vector_to_player() -> Vector2:
	#fish.global_position.direction_to(fish.player.global_position)
	print(fish.player.global_position - fish.global_position)
	return fish.player.global_position - fish.global_position
