extends Area2D
class_name Key

var player: Player
var following_player = false

@export var speed_factor: float = 2.0

var player_target_modifier = Vector2(0, -8)

func _ready() -> void:
	MetSys.register_storable_object(self)


func _physics_process(delta: float) -> void:
	if following_player:
		var target_position = player.global_position + player_target_modifier
		var distance_to_player = global_position.distance_to(target_position)
		global_position = global_position.move_toward(
			target_position, 
			delta * distance_to_player * speed_factor)


func _on_player_touch(body: Node2D) -> void:
	if player == null:
		player = body
		MetSys.store_object(self)
		GameEvent.key_picked_up.emit(self)
		following_player = true
