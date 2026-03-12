extends PlayerState

@export var cooldown_time = 0.5
@export var release_teleport_time = 0.1

var time = 0.0
var ground_collisions = 0
var previous_player_position: Vector2
var player_position_shift

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("release_teleport")
	time = 0.0
	previous_player_position = player.global_position
	player.disable_collisions(true)
	player.teleport()
	player_position_shift = player.global_position - previous_player_position
	player.velocity.y = 0


func _update(_delta):
	time += _delta
	
	if time > cooldown_time:
		if ground_collisions > 0:
			player.global_position -= player_position_shift
		finished.emit(IDLE)


func _exit():
	player.disable_collisions(false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	ground_collisions += 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	ground_collisions -= 1
