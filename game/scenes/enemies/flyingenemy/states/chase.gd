extends TriangleFishState

@onready var agent: NavigationAgent2D = $"../../NavigationAgent2D"

var direction: Vector2 = Vector2.ZERO
var player: Player
var aligned_with_player = false

func _enter(_previous_state_path: String, _init_data := {}):
	fish.set_animation("chase")
	player = fish.player
	direction = fish.velocity.normalized()
	aligned_with_player = false


func _update_physics(_delta):
	
	agent.target_position = player.global_position
	
	if agent.distance_to_target() > 20:
		direction = direction.move_toward(get_direction_to_chase(), _delta)
	fish.velocity = direction * fish.speed
	
	if aligned_with_player:
		fish.update_direction(fish.velocity)
	else:
		fish.update_direction(get_direction_to_chase())
		if sign(fish.velocity.x) == sign(get_direction_to_chase().x):
			aligned_with_player = true
	
	fish.move_and_slide()


func get_direction_to_chase():
	return (agent.get_next_path_position() - fish.global_position).normalized()
