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
	return fish.player.global_position - fish.global_position


func _on_player_detect_body_exited(body: Node2D) -> void:
	finished.emit(SLEEP)
