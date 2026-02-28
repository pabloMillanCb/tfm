extends TriangleFishState

@onready var agent: NavigationAgent2D = $"../../NavigationAgent2D"

var direction: Vector2 = Vector2.ZERO
var player: Player
var aligned_with_player = false
var ray_cast: RayCast2D

func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("chase")
	player = fish.player
	direction = fish.velocity.normalized()
	aligned_with_player = false
	ray_cast = fish.ray_cast


func _update_physics(_delta):
	
	ray_cast.target_position = vector_to_player()
	
	agent.target_position = player.global_position
	
	if agent.distance_to_target() > 0:
		#direction.x =  move_toward(direction.x, get_direction_to_chase().x, _delta * 2)
		#direction.y = move_toward(direction.y, get_direction_to_chase().y, _delta * 1.5)
		direction = direction.move_toward(get_direction_to_chase(), _delta * 1.5)
		#direction.y = get_direction_to_chase().y

	#fish.velocity.x = direction.x * fish.speed
	#fish.velocity.y = direction.y * fish.speed * 1.5
	fish.velocity = direction * fish.speed
	fish.update_direction(fish.velocity)
	
	fish.move_and_slide()
	

func get_direction_to_chase() -> Vector2:
	if abs(fish.global_position.y - player.global_position.y) > 10 and ray_cast.get_collider() is Player:
		return Vector2(sign(player.global_position.x - fish.global_position.x)*0.5,
			sign(player.global_position.y - fish.global_position.y)).normalized()
	elif fish.global_position.y == player.global_position.y and ray_cast.get_collider() is Player:
		return fish.global_position.direction_to(player.global_position).normalized()
	else:
		return (agent.get_next_path_position() - fish.global_position).normalized()


func get_ground_middle_point():
	return Vector2(player.global_position.x - fish.global_position.x, player.global_position.y)


func vector_to_player() -> Vector2:
	return fish.player.global_position - fish.global_position
