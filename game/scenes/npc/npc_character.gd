extends Node2D

@export var appear_event_name: String
@export var disappear_event_name: String

var player: Player

func _ready() -> void:
	print(DataManager.is_event_registered(disappear_event_name))
	print((!DataManager.is_event_registered(appear_event_name) and appear_event_name != ""))
	if (DataManager.is_event_registered(disappear_event_name) or 
		(!DataManager.is_event_registered(appear_event_name) and appear_event_name != "")):
		print("pop")
		queue_free()


func _process(delta: float) -> void:
	if player != null:
		$AnimatedSprite2D.scale.x = sign(global_position.direction_to(player.global_position).x)


func _get_configuration_warnings():
	var warnings = []

	if get_node("AnimatedSprite2D") == null:
		warnings.append("Add an AnimatedSprite2D with animations talk_1, talk_2, etc.")

	# Returning an empty array means "no warning".
	return warnings


func _on_player_entered(body: Node2D) -> void:
	player = body
