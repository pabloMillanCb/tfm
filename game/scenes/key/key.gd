extends Area2D
class_name Key

var player: Player

@export var speed_factor: float = 2.0


func _physics_process(delta: float) -> void:
	if player != null:
		var distance_to_player = global_position.distance_to(player.global_position)
		global_position = global_position.move_toward(
			player.global_position, 
			delta * distance_to_player * speed_factor)


func _on_player_touch(body: Node2D) -> void:
	player = body
