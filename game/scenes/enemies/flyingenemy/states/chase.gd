extends TriangleFishState

@onready var agent: NavigationAgent2D = $"../../NavigationAgent2D"


var player: Player
var ray_cast: RayCast2D

func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("chase")
	player = fish.player
	#fish.direction = fish.velocity.normalized()
	ray_cast = fish.ray_cast


func _update_physics(_delta):
	
	ray_cast.target_position = vector_to_player()
	agent.target_position = player.global_position

	fish.direction = fish.direction.move_toward(get_direction_to_chase(), _delta * 2)
	
	print(fish.direction)
	
	fish.velocity = fish.direction * fish.speed
	fish.update_direction(fish.velocity)
	
	fish.move_and_slide()
	#var collision = fish.move_and_collide(fish.velocity.normalized())
	#if collision:
	#	var collider = collision.get_collider_velocity()
	#	fish.velocity = -10*collider
		#fish.velocity = -fish.velocity.normalized() * 300
	#	direction = fish.velocity.normalized()
	

func get_direction_to_chase() -> Vector2:
	if abs(fish.global_position.y - player.global_position.y) > 10 and ray_cast.get_collider() is Player:
		$"../../Label".text = "1"
		return fish.global_position.direction_to(get_ground_quarter_point()).normalized()
	elif abs(fish.global_position.y - player.global_position.y) <= 10 and ray_cast.get_collider() is Player:
		$"../../Label".text = "2"
		return fish.global_position.direction_to(player.global_position).normalized()
	else:
		$"../../Label".text = "3"
		return (agent.get_next_path_position() - fish.global_position).normalized()


func get_ground_middle_point():
	var x_middle_point = (player.global_position.x + fish.global_position.x)/2
	return Vector2(x_middle_point, player.global_position.y)


func get_ground_quarter_point():
	var x_quarter_point = (get_ground_middle_point().x + fish.global_position.x)/2
	return Vector2(x_quarter_point, player.global_position.y)


func vector_to_player() -> Vector2:
	return (fish.player.global_position - fish.global_position) * 2
